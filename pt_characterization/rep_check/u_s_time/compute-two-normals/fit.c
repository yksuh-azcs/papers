/* fit.c, authored by Robert S. Maier <rsm@math.arizona.edu>.
 * Compile by: 
 * gcc -O fit.c -o fit -lm
 */

/* Typical invocations, for constructing a normal fit and a binormal
   (i.e. mixture-of-two-normals) fit, to the frequency histograms
   obtained from Young's data:

   tail -n +2 256_sec.dat | awk '{print $2}' | sort -n |  fit
   tail -n +2 64_sec.dat | awk '{print $2}' | sort -n |  fit -b 6 10 2 2 0.3

   For a normal fit, no parameters are specified on the command line.
   For a binormal fit, the "-b" option is specified, followed by
   initializations of the 5 parameters of the binormal distribution:
   mean1, mean2, sd1, sd2, scale1.  The fitting procedure will
   optimize these 5 parameters, in an iterative manner that terminates
   when no further improvement can be made.

   Note that the mean1,mean2 parameters, as supplied on the command
   line, should be relative to the minimum value in the dataset.  Thus
   in the example above, `mean1=6' and `mean2=10' mean that the first
   mode is (initially, before optimization) centered at 6 units above
   the minimum value, and the second mode is centered at 10 units
   above the minimum value.  These values were chosen by examining the
   INC64 histogram.

   In the example, `sd1=2' and `sd2=2' specify the initial width,
   i.e. standard deviation, of each mode to be 2.  These values were
   also chosen by examining the INC64 histogram.  `scale1=0.3' was
   chosen because approximately 30% of the total seems to be in the
   first mode, rather than the second.  (scale1 is the relative
   strength of the first mode, and by definition, scale2 equals
   1.0-scale1.)
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <limits.h>
#include <math.h>

#define OUR_BUFSIZ 2

void optimize_pdf_normal (double *pdf, double *pdf_fit, int data_range, double mean, double sd, double *best_mean, double *best_sd);
void optimize_pdf_binormal (double *pdf, double *pdf_fit, int data_range, double mean1, double mean2, double sd1, double sd2, double scale1, double *best_mean1, double *best_mean2, double *best_sd1, double *best_sd2, double *best_scale1);
void fill_pdf_normal (double *pdf, int data_range, double mean, double sd);
void fill_pdf_binormal (double *pdf, int data_range, double mean1, double mean2, double sd1, double sd2, double scale1);
double pdf_difference (double *pdf1, double *pdf2, int data_range);
int * read_data (int *num_ints);

int
main (int argc, char **argv)
{
  int *data;
  int n, data_min, data_max, data_range, i;
  int *pdf_int, *cdf_int, *rev_cdf_int;
  double *pdf, *pdf_fit;
  int accum;
  double sum, sumsq, sumcub, variance, sumcub_norm, g1;
  double mean, sd;
  double new_mean, new_sd;

  int binormal_fit = 0;

  /* used for binormal fitting [-b] only */
  double mean1, mean2, sd1, sd2, scale1;
  double new_mean1, new_mean2, new_sd1, new_sd2, new_scale1;

  if (argc > 1)
    {
      if ((argc != 7) || strcmp (argv[1], "-b") != 0)
	{
	  fprintf (stderr, "Usage: %s [-b mean1 mean2 sd1 sd2 scale2]\n", argv[0]);

	  exit (EXIT_FAILURE);
	}
      binormal_fit = 1;
      
      sscanf (argv[2], "%lf", &mean1);
      sscanf (argv[3], "%lf", &mean2);
      sscanf (argv[4], "%lf", &sd1);
      sscanf (argv[5], "%lf", &sd2);
      sscanf (argv[6], "%lf", &scale1);
    }

  /* read data() returns number of integers read (i.e. n), via ptr;
     data[] is indexed by 0..(n-1), and pre-sorting of data values is
     checked for */
  data = read_data (&n);

  if (n <= 2)
    {
      fprintf (stderr, "insufficient data read\n");
      exit (EXIT_FAILURE);
    }

  data_min = data[0];
  data_max = data[n-1];
  data_range = data_max - data_min;
  if (data_range <= 0)
    {
      fprintf (stderr, "data range is zero\n");
      exit (EXIT_FAILURE);
    }

  fprintf (stdout, "Data: n = %d, min = %d, max = %d, range = %d\n", n, data_min, data_max, data_range);

  /* compute summary statistics: mean, variance and sd, skewness (i.e. g1) */

  sum = 0.0;
  for (i = 0; i < n; i++)
    sum += (data[i] - data_min);
  mean = sum / n;
  
  sumsq = 0.0;
  for (i = 0; i < n; i++)
    sumsq += ((data[i] - data_min) - mean) * ((data[i] - data_min) - mean);
  variance = sumsq / (n-1);
  sd = sqrt (variance);
    
  sumcub = 0.0;
  for (i = 0; i < n; i++)
    sumcub += ((data[i] - data_min) - mean) * ((data[i] - data_min) - mean) * ((data[i] - data_min) - mean);
  sumcub_norm = sumcub / n;
  g1 = ((sumcub_norm / (sd * sd * sd)) * n * n) / ((n-1) * (n-2));

  fprintf (stdout, "Statistics: mean = %f, sd = %f, g1 (i.e., skewness) = %f\n", mean, sd, g1);

  /* fill in empirical pdf and cdf arrays, indexed by 0..data_range */

  pdf_int = malloc ((data_range + 1) * sizeof(int));
  if (pdf_int == NULL)
    {
      fprintf (stderr, "malloc failed: %s\n", strerror (errno));
      exit (EXIT_FAILURE);
    }

  pdf = malloc ((data_range + 1) * sizeof(double));
  if (pdf == NULL)
    {
      fprintf (stderr, "malloc failed: %s\n", strerror (errno));
      exit (EXIT_FAILURE);
    }

  cdf_int = malloc ((data_range + 1) * sizeof(int));
  if (cdf_int == NULL)
    {
      fprintf (stderr, "malloc failed: %s\n", strerror (errno));
      exit (EXIT_FAILURE);
    }

  rev_cdf_int = malloc ((data_range + 1) * sizeof(int));
  if (rev_cdf_int == NULL)
    {
      fprintf (stderr, "malloc failed: %s\n", strerror (errno));
      exit (EXIT_FAILURE);
    }

  for (i = 0; i <= data_range; i++)
    pdf_int[i] = 0;
  for (i = 0; i < n; i++)
    pdf_int[data[i] - data_min]++;

  for (i = 0; i <= data_range; i++)
    pdf[i] = ((double)pdf_int[i]) / n;

  accum = 0;
  for (i = 0; i <= data_range; i++)
    {
      accum += pdf_int[i];
      cdf_int[i] = accum;
    }

  accum = 0;
  for (i = data_range; i >= 0; i--)
    {
      accum += pdf_int[i];
      rev_cdf_int[i] = n - accum;
    }

  /* allocate a buffer for a normal or binormal PDF, to be fit to empirical PDF */
  
  pdf_fit = malloc ((data_range + 1) * sizeof(double));
  if (pdf_fit == NULL)
    {
      fprintf (stderr, "malloc failed: %s\n", strerror (errno));
      exit (EXIT_FAILURE);
    }

  if (binormal_fit == 0)
    /* default, do normal fit, starting with empirical parameter values */
    {
      optimize_pdf_normal (pdf, pdf_fit, data_range, mean, sd, &new_mean, &new_sd);

      fprintf (stdout, "Best normal fit: mean = %f, sd = %f\n", new_mean, new_sd);
    }
  else
    /* do binormal fit, starting with command-line parameter values */
    {
      optimize_pdf_binormal (pdf, pdf_fit, data_range, mean1, mean2, sd1, sd2, scale1, &new_mean1, &new_mean2, &new_sd1, &new_sd2, &new_scale1);

      fprintf (stdout, "Initial parameter values: mean1 = %f, mean2 = %f, sd1 = %f, sd2 = %f, scale1 = %f, scale2 = %f\n", mean1, mean2, sd1, sd2, scale1, 1.0 - scale1);

      fprintf (stdout, "Optimum parameter values: mean1 = %f, mean2 = %f, sd1 = %f, sd2 = %f, scale1 = %f, scale2 = %f\n", new_mean1, new_mean2, new_sd1, new_sd2, new_scale1, 1.0 - new_scale1);
    }

  fprintf (stdout, "\n");
  fprintf (stdout, "Histograms (raw and fitted):\n\n");
  fprintf (stdout, "\tTIME\tFREQ_RAW\tFREQ_FITTED\n");
  for (i = 0; i <= data_range; i++)
    {
      fprintf (stdout, "%d\t%d\t%f\t%f\n", i, data_min + i, pdf[i], pdf_fit[i]);
    }
  fprintf (stdout, "\n");

  exit(EXIT_SUCCESS);
}

/* factor by which to increment/decrement each parameter, in each pass of search */
#define STEPSIZE 0.001

/* number of passes of search */
#define NUMTIMES 200

/* amount by which discrepancy should improve, to justify acceptance */
#define ABSURDLY_SMALL 1e-9

void
optimize_pdf_normal (double *pdf, double *pdf_fit, int data_range, double mean, double sd, double *best_mean, double *best_sd)
{
  int i;
  int d1, d2;
  double discrep, new_discrep, delta_discrep = 0.0;
  double new_mean, new_sd;
  
  *best_mean = mean;
  *best_sd = sd;

  /* initialize with passed values for normal parameters */

  fill_pdf_normal (pdf_fit, data_range, mean, sd);
  discrep = pdf_difference (pdf, pdf_fit, data_range);

  for (i = 0; i < NUMTIMES; i++)
    {
      int found_better;

      found_better = 0;
      delta_discrep = 0.0;
      for (d1 = -1; d1 <= 1; d1++)
	for (d2 = -1; d2 <= 1; d2++)
	    {
	      new_mean = mean * (1.0 + d1 * STEPSIZE);
	      new_sd = sd * (1.0 + d2 * STEPSIZE);
	      
	      fill_pdf_normal (pdf_fit, data_range, new_mean, new_sd);
	      new_discrep = pdf_difference (pdf, pdf_fit, data_range);

	      if (new_discrep - discrep < -(ABSURDLY_SMALL))
		{
		  found_better = 1;
		  delta_discrep = new_discrep - discrep;
		  discrep = new_discrep;
		  mean = new_mean;
		  sd = new_sd;
		}
	    }

      if (found_better == 0)	/* explored all 3**2 possibilities without success */
	{
#if 0
	  fprintf (stderr, "breaking after pass %d\n", i);
#endif
	  break;
	}
#if 0
      else
	{
	  fprintf (stderr, "not breaking after pass %d, delta = %g\n", i, delta_discrep);
	}
#endif
    }

  *best_mean = mean;
  *best_sd = sd;
}

void
optimize_pdf_binormal (double *pdf, double *pdf_fit, int data_range, double mean1, double mean2, double sd1, double sd2, double scale1, double *best_mean1, double *best_mean2, double *best_sd1, double *best_sd2, double *best_scale1)
{
  int i;
  int d1, d2, d3, d4, d5;
  double discrep, new_discrep, delta_discrep = 0.0;
  double new_mean1, new_mean2, new_sd1, new_sd2, new_scale1;
  
  *best_mean1 = mean1;
  *best_mean2 = mean2;
  *best_sd1 = sd1;
  *best_sd2 = sd2;
  *best_scale1 = scale1;

  /* initialize with passed values for normal parameters */

  fill_pdf_binormal (pdf_fit, data_range, mean1, mean2, sd1, sd2, scale1);
  discrep = pdf_difference (pdf, pdf_fit, data_range);

#if 0
  fprintf (stderr, "discrep = %f\n", discrep);
#endif

  for (i = 0; i < NUMTIMES; i++)
    {
      int found_better;

      found_better = 0;
      delta_discrep = 0.0;
 
      for (d1 = -1; d1 <= 1; d1++)
	for (d2 = -1; d2 <= 1; d2++)
	  for (d3 = -1; d3 <= 1; d3++)
	    for (d4 = -1; d4 <= 1; d4++)
	      for (d5 = -1; d5 <= 1; d5++)
		{
		  new_mean1 = mean1 * (1.0 + d1 * STEPSIZE);
		  new_mean2 = mean2 * (1.0 + d2 * STEPSIZE);
		  new_sd1 = sd1 * (1.0 + d3 * STEPSIZE);
		  new_sd2 = sd2 * (1.0 + d4 * STEPSIZE);
		  new_scale1 = scale1  * (1.0 + d5 * STEPSIZE);
	      
		  fill_pdf_binormal (pdf_fit, data_range, new_mean1, new_mean2, new_sd1, new_sd2, new_scale1);
#if 0
		  fprintf (stderr, "fill_pdf_binormal(data_range = %d, mean1 = %f, mean2 = %f, sd1 = %f, sd2 = %f, scale1 = %f\n", data_range, mean1, mean2, sd1, sd2, scale1);
#endif
		  new_discrep = pdf_difference (pdf, pdf_fit, data_range);

#if 0
		  fprintf (stderr, "new_discrep = %f\n", new_discrep); */
#endif
		  if (new_discrep - discrep < -(ABSURDLY_SMALL))
		    {
		      found_better = 1;
		      delta_discrep = new_discrep - discrep;
		      discrep = new_discrep;
		      mean1 = new_mean1;
		      mean2 = new_mean2;
		      sd1 = new_sd1;
		      sd2 = new_sd2;
		      scale1 = new_scale1;
		    }
		}

      if (found_better == 0)	/* explored all 3**5 possibilities without success */
	{
	  fprintf (stderr, "Optimization accomplished after pass %d:\n", i);
	  break;
	}
#if 0
      else
	{
	  fprintf (stderr, "not breaking after pass %d, delta = %g\n", i, delta_discrep);
	}
#endif

#if 0
      fprintf (stderr, "new mean1 = %f, mean2 = %f, sd1 = %f, sd2 = %f, scale1 = %f, new discrep = %f\n", mean1, mean2, sd1, sd2, scale1, discrep);
#endif
    }

  *best_mean1 = mean1;
  *best_mean2 = mean2;
  *best_sd1 = sd1;
  *best_sd2 = sd2;
  *best_scale1 = scale1;
}

#define SUBDIVS 50

void
fill_pdf_normal (double *pdf, int data_range, double mean, double sd)
{
  int i;
  
  for (i = 0; i <= data_range; i++)
    {
      int k;
      double accum = 0.0;
      
      for (k = -(SUBDIVS); k <= SUBDIVS; k++)
	{
	  double x, y;
	  
	  x = i + k/(2*(SUBDIVS));
	  y = exp (- (x - mean)*(x - mean) / (2 * sd * sd)) / (sqrt (2 * M_PI) * sd);
	  accum += y;
	}

      pdf[i] = accum / (2*(SUBDIVS) + 1);
    }
}

void
fill_pdf_binormal (double *pdf, int data_range, double mean1, double mean2, double sd1, double sd2, double scale1)
{
  int i;
  double scale2 = 1.0 - scale1;
  
#if 0
  fprintf (stderr, "fill_pdf_binormal (mean1=%f, mean2=%f, sd1=%f, sd2=%f, scale1=%f)\n", mean1, mean2, sd1, sd2, scale1);
#endif

  for (i = 0; i <= data_range; i++)
    {
      int k;
      double accum = 0.0;
      
      for (k = -(SUBDIVS); k <= SUBDIVS; k++)
	{
	  double x, y;
	  
	  x = i + k/(2*(SUBDIVS));
	  y = scale1 * (exp (- (x - mean1)*(x - mean1) / (2 * sd1 * sd1))) / (sqrt (2 * M_PI) * sd1)
	    + scale2 * (exp (- (x - mean2)*(x - mean2) / (2 * sd2 * sd2))) / (sqrt (2 * M_PI) * sd2);
	  accum += y;
	}

      pdf[i] = accum / (2*(SUBDIVS) + 1);
    }
}

double
pdf_difference (double *pdf1, double *pdf2, int data_range)
{
  double accum = 0.0;
  int i;

  for (i = 0; i <= data_range; i++)
    accum += fabs (pdf1[i] - pdf2[i]);

  return accum / (data_range + 1);
}

int *
read_data (int *num_ints)
{
  int *data;
  int n = 0;
  int olditem = INT_MIN;
  size_t datasize = OUR_BUFSIZ;

  data = malloc (datasize * sizeof(int));
  if (data == NULL)
    {
      fprintf (stderr, "malloc failed: %s\n", strerror (errno));
      exit (EXIT_FAILURE);
    }

  n = 0;
  while (1)
    {
      int item, retval;

      retval = fscanf (stdin, "%d", &item);
      if (retval != 1)
	{
	  if (retval == EOF)
	    break;
	  else
	    {
	      if (ferror (stdin))
		fprintf (stderr, "fscanf failed: %s\n", strerror (errno));
	      else
		fprintf (stderr, "bad input\n");
	      
	      exit (EXIT_FAILURE);
	    }
	}

      if (n != 0 && item < olditem)
	{
	  fprintf (stderr, "data not sorted\n");
	  exit (EXIT_FAILURE);
	}

      if (n == (int)datasize)
	{
	  datasize *= 2;
	  data = realloc (data, datasize * sizeof(int));
	  if (data == NULL)
	    {
	      fprintf (stderr, "realloc failed: %s\n", strerror (errno));
	      exit (EXIT_FAILURE);
	    }
	}

      data[n++] = item;
      olditem = item;
    }

  *num_ints = n;
  return data;
}
