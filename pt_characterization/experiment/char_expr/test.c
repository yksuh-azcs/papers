#include <stdio.h>    /* standard in and output*/
#include <stdlib.h>   
#include <string.h>    
#include <unistd.h>     /* for close() */
#include <time.h> 
#include <limits.h> 
#include <sys/time.h>
#define PRINT 0
#define PORT_NUM 2400
#define COEF 1460000000 // 16B
//#define MAT_SZ 10000
#define COLUMN_MAJOR 1
#define ROW_MAJOR 2
#define MAT_COEF 2000000

/* for sort */
int* iarr = NULL;
int* iarr_unsorted = NULL;
int numCnt = 0;
int MAX_NUM = 1000000;//1M
/* for matrix */
int MAT_SZ = 0;
int** matrix = NULL;

void mat_init(int task_length);
void mat_walker(int exp_secs, int type);

int main(int argc, char *argv[]) {
	int task_length = atoi(argv[1]);
printf("task length: %d\n", task_length);
	mat_init(task_length);

struct timeval tim;
gettimeofday(&tim, NULL);
double t1=tim.tv_sec*1000+(tim.tv_usec/1000.0);
clock_t cpu_start = clock();
	mat_walker(task_length, COLUMN_MAJOR);
clock_t cpu_end = clock();
double cpu_temp = (double)(cpu_end-cpu_start) / CLOCKS_PER_SEC;
gettimeofday(&tim, NULL);
double t2=tim.tv_sec*1000+(tim.tv_usec/1000.0);
fprintf(stdout, "Total CPU time on read requests: '%.4f(sec)'\n", cpu_temp);
fprintf(stdout, "%.6lf msecs elapsed\n", t2-t1);

}

/* for matrix worker */
inline void mat_init(int task_length){
	time_t t;
	/* Intializes random number generator */
  	srand((unsigned) time(&t));
	
	if(task_length == 1024) MAT_SZ = 16000;//1G
else if(task_length == 250) MAT_SZ = 8000;//1G
else if(task_length == 500) MAT_SZ = 11314;//1G
else if(task_length == 1440) MAT_SZ = 17152;//1G
	else if(task_length == 2048) MAT_SZ = 22627;// 2G
else if(task_length == 2880) MAT_SZ = 24256;//1G
	else if(task_length == 4096) MAT_SZ = 32000;// 4G
else if(task_length == 5760) MAT_SZ = 34304;//1G
	else if(task_length == 8192) MAT_SZ = 45254;// 8G
else if(task_length == 11520) MAT_SZ = 48512;//1G
	else if(task_length == 16000) MAT_SZ = 64000;// 16G
else if(task_length == 23040) MAT_SZ = 68608;// 16G
	else if(task_length == 32000) MAT_SZ = 90508;// 16G
else if(task_length == 46080) MAT_SZ = 128000;// 16G
//	MAT_SZ = task_length;
printf("MAT_SZ : %d\n", MAT_SZ);
	int i=0,j=0;
	matrix = (int**)malloc(sizeof(int*)*MAT_SZ);
	for(i=0;i<MAT_SZ;i++){
		matrix[i] = (int*)malloc(sizeof(int)*MAT_SZ);
		for(j=0;j<MAT_SZ;j++){
			matrix[i][j] = rand()%MAX_NUM;
			if((i) % 1000 == 0 && (j) %1000 == 0) 
				printf("matrix[%d][%d]:%d\n", i, j, matrix[i][j]);
		}	
	}
	printf("i: %d, j: %d\n", i, j);
	//printf("matrix[%d][%d]:%d\n", i, j, matrix[i][j]);
}

inline void mat_walker(int exp_secs, int type){
	int i, j,v;
	unsigned long long k = 0;
	unsigned long long numIters = (long)exp_secs * (long)MAT_COEF;
printf("numIters:%llu\n", numIters);
	if (type == COLUMN_MAJOR){
		for(k=1;k<=numIters;k++){
			for(i=0;i<MAT_SZ;i++){
				for(j=0;j<MAT_SZ;j++){
					v = matrix[i][j];		
				}
			}
		}
	}else if(type == ROW_MAJOR){
		for(k=1;k<=numIters;k++){
			for(j=0;j<MAT_SZ;j++){
				for(i=0;i<MAT_SZ;i++){
					v = matrix[i][j];		
				}
			}
		}
	}
}

