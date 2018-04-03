#include <stdio.h>

int g_numCnt = 0;

int main(int argc, char* argv[]){
    g_numCnt++;
    
    int l_numCnt2 = 1;
    printf("numCnt: %d, numCnt2: %d\n", 
		g_numCnt, l_numCnt2);
    return 0;
}
