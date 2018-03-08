#include <stdio.h>    /* standard in and output*/
#include <sys/socket.h> /* for socket() and socket functions*/
#include <arpa/inet.h>  /* for sockaddr_in and inet_ntoa() */
#include <stdlib.h>   
#include <string.h>    
#include <unistd.h>     /* for close() */
#include <time.h> 
#include <limits.h> 
#define PRINT 0
//#define NUM_ELE1 22200
#define NUM_ELE1 20800
#define NUM_ELE64 174000
#define NUM_ELE128 241000
//#define MAT_SZ 10000

#define PORT_NUM 2400
#define COEF 1460000000 
//#define ROW_COEF 1460000000 
//#define COL_COEF 1457000000 
//#define ROW_COEF 1800000
//#define COL_COEF 1800000
#define MAT_COEF 2000000
char c;

//int matrix[MAT_SZ][MAT_SZ];
int** matrix = NULL;
static int MAT_SZ = -1;

inline void mat_walker(int exp_secs, int type){
	int i, j,v;
	unsigned long long k = 0;
	unsigned long long numIters = (long)exp_secs * (long)MAT_COEF;
	if (type == 2){
		for(k=1;k<=numIters;k++){
			for(i=0;i<MAT_SZ;i++){
				for(j=0;j<MAT_SZ;j++){
					v = matrix[i][j];	
				}
			}
		}
	}else{
		for(k=1;k<=numIters;k++){
			for(j=0;j<MAT_SZ;j++){
				for(i=0;i<MAT_SZ;i++){
					v = matrix[i][j];		
				}
			}
		}
	}
}

inline void foo(int exp_secs) {
	unsigned long long i, j, x;
	//printf("Increment work of %d seconds starts!\n", exp_secs);
	//max = 2147483647;
	//max = 2000000000; 
	unsigned long long fn = (long)COEF*(long)exp_secs;
	//printf("max iterations: %llu\n", n);
	for (i = 1; i <= fn; i++) {
		x = 0;
		for (j = 0; j < UINT_MAX; j++) {
			x++;
		}
	}
	//sleep(exp_secs);
	//printf("Done!\n");
}

void reply(char c, int connected){
//	printf("Response signal has been sent! : %d on %c\n\n", success, c);
	if (send(connected, "1", 1, 0) == -1) {
		perror("send() failed");
	}
//	printf("Response signal has been sent! : %d on %c\n\n", success, c);
//	success = 0;
	close (connected);
}


int* iarr = NULL;
int* iarr_unsorted = NULL;
int numCnt = 0;
int MAX_NUM = 1000000;//1M

void reset(){
	memset(iarr, 0, sizeof(int)*numCnt);
	memcpy(iarr, iarr_unsorted, sizeof(int)*numCnt);
}

int init(int task_length){
	//numCnt = task_length * 22200;
	//numCnt = task_length * NUM_ELEMENT;
	/*if(task_length == 1) numCnt = NUM_ELE1;
	else if(task_length == 64) numCnt = NUM_ELE64;
	else if(task_length == 128) numCnt = NUM_ELE128;

	// numCnt should be translated from a task length
	iarr = (int*)malloc(sizeof(int)*numCnt);
	iarr_unsorted = (int*)malloc(sizeof(int)*numCnt);

	int i;
	time_t t;
	// Intializes random number generator
  	srand((unsigned) time(&t));
	for (i = 0; i < numCnt; i++) {
		iarr_unsorted[i] = rand()%MAX_NUM;
	}
	return numCnt;*/
	/*if(task_length == 1)         numCnt = 1000000 / sizeof(int); // 0.25M elements = 1M;106455.595947 msecs
        else if(task_length == 10)   numCnt = 10000000 / sizeof(int); // 2.5M elements = 10M
        else if(task_length == 100)  numCnt = 100000000 / sizeof(int); // 2.5M elements = 100M
        else if(task_length == 1000) numCnt = 1000000000 / sizeof(int); // 2.5M elements = 1000M*/
	/*if(task_length == 1)         numCnt = 1000; // 1M;3.469971 msecs elapsed
        else if(task_length == 10)    numCnt = 10000; // 10M elements;242.077881 msecs elapsed
        else if(task_length == 100)    numCnt = 100000; // 100M elements;17277.270020 msecs elapsed
        else if(task_length == 1000)    numCnt = 1000000;// 1000M elements;*/
	//if(task_length == 1)         numCnt = 1000; // 1k
        if(task_length == 100)    numCnt = 100000; // 100k
        else if(task_length == 200)    numCnt = 200000; // 200k
        else if(task_length == 400)    numCnt = 400000;// 400k
	else if(task_length == 800)    numCnt = 800000;// 800k

        // numCnt should be translated from a task length
        iarr = (int*)malloc(sizeof(int)*numCnt);
        iarr_unsorted = (int*)malloc(sizeof(int)*numCnt);

        int i;
        time_t t;
        /* Intializes random number generator */
        srand((unsigned) time(&t));
        for (i = 0; i < numCnt; i++) {
                iarr_unsorted[i] = rand()%MAX_NUM;
        }
        reset(numCnt);
        return numCnt;
}

void mat_init(int task_length){
	time_t t;
	/* Intializes random number generator */
  	srand((unsigned) time(&t));
	
	//if(task_length == 1) MAT_SZ = 10000;
	//if(task_length == 1)       MAT_SZ = 500;  // 1M
	//else if(task_length == 10)   MAT_SZ = 1582; // 10M
	/*if(task_length == 128)       MAT_SZ = 5000; // 128M
	else if(task_length == 256) MAT_SZ = 5656; //256M
	else if(task_length == 512) MAT_SZ = 11313; //512M
	else if(task_length == 1024) MAT_SZ = 16000; //1G: 50000 => 10G*/
	if(task_length == 1024) MAT_SZ = 16000;//1G
	else if(task_length == 2048) MAT_SZ = 22627;// 2G
	else if(task_length == 4096) MAT_SZ = 32000;// 4G
	else if(task_length == 8192) MAT_SZ = 45254;// 8G
	//else if(task_length == 16384) MAT_SZ = 64000;// 1G

	int i=0,j=0;
	matrix = (int**)malloc(sizeof(int*)*MAT_SZ);
	for(i=0;i<MAT_SZ;i++){
		matrix[i] = (int*)malloc(sizeof(int)*MAT_SZ);
		for(j=0;j<MAT_SZ;j++){
			matrix[i][j] = rand()%MAX_NUM;
	//		if((i+1) % 1000 == 0 && (j+1) %1000 == 0) printf("i: %d, j:%d, v:%d ", i, j, matrix[i][j]);	
		}	
	}
}

void insertion_sort(int num) {
   int i=0, j=0, k=0, temp=0;
#if PRINT
   printf("\nUnsorted Data:");
   for (k = 0; k < num; k++) {
      printf("%d ", iarr[k]);
      if((k+1) % 10 == 0) printf("\n");
   }
#endif 
   //printf("\n------------------\n");
   /*for (i = 1; i < num; i++) {
      for (j = 0; j < num - 1; j++) {
         if (iarr[j] > iarr[j + 1]) {
            temp = iarr[j];
            iarr[j] = iarr[j + 1];
            iarr[j + 1] = temp;
         }
      }
   }*/
	for(i = 1; i < num;i++){
        j = i;
        while (j > 0 && iarr[j-1] > iarr[j]){
                temp = iarr[j];
                iarr[j] = iarr[j-1];
                iarr[j-1] = temp;
                j--;
        }
   }

#if PRINT
   for (k = 0; k < num; k++) {
      printf("%d ", iarr[k]);
      if((k+1) % 10 == 0) printf("\n");
   }
#endif 
}

void free_array(){
	if(iarr != NULL) free(iarr);
	if(iarr_unsorted != NULL) free(iarr_unsorted);

	if(matrix != NULL){
		int i;
		for(i=0;i<MAT_SZ;i++){
			free(matrix[i]);
		}
		free(matrix);
	}
}

int main(int argc, char *argv[]) {
	int type = atoi(argv[1]);
	int exp_run_time = atoi(argv[2]);
        fprintf(stdout, "\ntype: %d, task_len:%d\n", type, exp_run_time);

if(type == 1){
	// init and assign to values
	int numCnt = init(exp_run_time);
	
int k = 0;
for(k=0;k<1;k++){
	reset();
	struct timeval tim;
        gettimeofday(&tim, NULL);
        double t1=tim.tv_sec*1000+(tim.tv_usec/1000.0);
        clock_t cpu_start = clock();
        //foo(exp_run_time);
        insertion_sort(numCnt);
        clock_t cpu_end = clock();
        double cpu_temp = (double)(cpu_end-cpu_start) / CLOCKS_PER_SEC;
        fprintf(stdout, "\nTotal CPU time on read requests: '%.4f(sec)'\n", cpu_temp);
        gettimeofday(&tim, NULL);
        double t2=tim.tv_sec*1000+(tim.tv_usec/1000.0);
        printf("%.6lf msecs elapsed\n", t2-t1);
}	
	free_array();
}else if (type == 2 || type == 3){// matrix
	mat_init(exp_run_time);
 int k = 0;
 for(k=0;k<1;k++){
        struct timeval tim;
        gettimeofday(&tim, NULL);
        double t1=tim.tv_sec*1000+(tim.tv_usec/1000.0);
        clock_t cpu_start = clock();
	mat_walker(exp_run_time, type);
        clock_t cpu_end = clock();
        double cpu_temp = (double)(cpu_end-cpu_start) / CLOCKS_PER_SEC;
        fprintf(stdout, "\nTotal CPU time: '%.4f(sec)'\n", cpu_temp);
        gettimeofday(&tim, NULL);
        double t2=tim.tv_sec*1000+(tim.tv_usec/1000.0);
        printf("%.6lf msecs elapsed\n", t2-t1);
 }
}
#if 0
	int total_size = sizeof(int);

	int sock, connected, bytes_received, true = 1;
	struct sockaddr_in server_addr, client_addr;
	int sin_size;
	if ((sock = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
//		if ((sock = socket(AF_LOCAL, SOCK_STREAM, 0)) == -1) {
		perror("Socket");
		exit(1);
	}
printf("command socket : %d\n", sock);
	
	if (setsockopt(sock, SOL_SOCKET, SO_REUSEADDR, &true, sizeof(int)) == -1) {
		perror("Setsockopt");
		exit(1);
	}

	server_addr.sin_family = AF_INET;
//		server_addr.sin_family = AF_LOCAL;
	server_addr.sin_port = htons(PORT_NUM);
	server_addr.sin_addr.s_addr = INADDR_ANY;
	bzero(&(server_addr.sin_zero), 8);

	if (bind(sock, (struct sockaddr *) &server_addr, sizeof(server_addr))
			== -1) {
		perror("Unable to bind");//Unable to bind: Address already in use
		exit(1);
	}

	if (listen(sock, 5) == -1) {
		perror("Listen");
		exit(1);
	}

	/***
	 * Data Socket
	 */
	int data_sock, data_connected, data_true = 1;
	struct sockaddr_in data_server_addr, data_client_addr;
	if ((data_sock = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
		perror("Data Socket Error");
		exit(1);
	}
printf("data socket : %d\n", data_sock);
	if (setsockopt(data_sock, SOL_SOCKET, SO_REUSEADDR, &true, sizeof(int)) == -1) {
		perror("Setsockopt");
		exit(1);
	}

	int dataPortNum = PORT_NUM+1;
	data_server_addr.sin_family = AF_INET;
	data_server_addr.sin_port = htons(dataPortNum);
	data_server_addr.sin_addr.s_addr = INADDR_ANY;
	bzero(&(data_server_addr.sin_zero), 8);

	if (bind(data_sock, (struct sockaddr *) &data_server_addr, sizeof(data_server_addr))
			== -1) {
		printf("cannot bind\n");
		perror("Unable to bind");//Unable to bind: Address already in use
		exit(1);
	}

	if (listen(data_sock, 5) == -1) {
		perror("Listen");
		exit(1);
	}
			
	//printf("\nTCPServer Waiting for client on port 2400");
	char c;
	while (1) { // until receiving signal 'k' 
		sin_size = sizeof(client_addr);
//			puts("\nWaiting for incoming connections...");
		connected = accept(sock, (struct sockaddr *) &client_addr,
				(socklen_t*) &sin_size);
		if (connected < 0) {
			perror("accepted failed");
		}

		if((bytes_received = read(connected, &c, 1)) > 0){
			if (c == 'd') { // ready to receive a list for fooing
				// send reply signal
				reply(c, connected);
				
				printf("OK, I am ready to receive!\n");
				
				puts("\nWaiting for incoming data connections...");
				int data_sin_size = sizeof(data_client_addr);
				data_connected = accept(data_sock, (struct sockaddr *) &data_client_addr,
						(socklen_t*) &data_sin_size);
				if (data_connected < 0) {
					perror("data socket accept failed");
				}
				
				printf("ready to receive data ...  %d\n", total_size);
				
				int data_bytes_received = 0;
				int sum_recv_bytes = 0;
				int offset = 0;
				do{
					int size = 4;
					char c[size];
					if((data_bytes_received=read(data_connected, c, size)) > 0){
						sum_recv_bytes += data_bytes_received;
						exp_run_time = *(int*)c;
					}
				}while(sum_recv_bytes < total_size);
				printf("\n done with receipt ... : %d\n", exp_run_time);
				reply('1', data_connected);
				continue;
			}
			else if (c == 's') { // start fooing	
				//printf("foo start\n");
				//struct timeval tim;
				//gettimeofday(&tim, NULL);
				//double t1=tim.tv_sec*1000+(tim.tv_usec/1000.0);
				//clock_t cpu_start = clock();
				foo(exp_run_time);
				//clock_t cpu_end = clock();
				//double cpu_temp = (double)(cpu_end-cpu_start) / CLOCKS_PER_SEC;
				//fprintf(stdout, "Total CPU time on read requests: '%.4f(sec)'\n", cpu_temp);
				//gettimeofday(&tim, NULL);
				//double t2=tim.tv_sec*1000+(tim.tv_usec/1000.0);
				//printf("%.6lf msecs elapsed\n", t2-t1);
			}
			// send reply signal
			reply(c, connected);	
			/****
			 * Post-processing 
			 */
			if (c == 'k'){ // if signal is 'k', then program is over!
				break;
			}
		}
	}
#endif
//		printf("Program normally exits!:%c\n",c);	
	return 0;
}

