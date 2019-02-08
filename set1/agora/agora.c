/*
 * ask1.c
 *
 *  Created on: Mar 20, 2018
 *  Author: Aggelos Plevris
 */
#include<stdio.h>
#include<stdlib.h>
long long int** A;
long long int gcd(long long int a, long long int b){//ypologizoume ton mkd gia na ton xrisimopoihsoume sto ekp
    long long int t;
    while (b!=0){
        t=b;
        b=a%b;
        a=t;
    }
    return a;
}
long long int lcm(long long int a, long long int b){//ypologizoume to ekp
    return a/gcd(a,b)*b;
}
/*
gemizoume dyo pinakes enan apo dexia kai enan apo aristera 
h ylopoihsh mas exei enan disdiastato pinaka
o pinakas A[0][N] exei ta stoixeia tis eisodou
oi pinakes A[1][N] kai A[2][N] gemizontai ws e3hs
h anadromiki sxesi pou gemizei ton pinaka A[1][i]=lcm(A[1][i-1],A[0][i])
h anadromiki sxesi pou gemizei ton pinaka A[2][i]=lcm(A[1][i+1],A[0][i])
*/
void gemisma(long int N){		
    long int i;
    A[1][0]=A[0][0];
    for(i=1;i<N;i++){
        A[1][i]=lcm(A[1][i-1],A[0][i]);
    }
    A[2][N-1]=A[0][N-1];
    for(i=N-2;i>-1;i--){
        A[2][i]=lcm(A[2][i+1],A[0][i]);
    }
    A[0][0]=A[2][1];
    for(i=1;i<N-1;i++){
        A[0][i]=lcm(A[1][i-1],A[2][i+1]);
    }
    A[0][N-1]=A[1][N-2];
}
long long int elaxisto(long int N,long int* tmik){
    long int i;
    long long int min=A[0][0];
    *tmik=0;
    for(i=1;i<N;i++){
        if (A[0][i]<min){
            min=A[0][i];
            *tmik=i;
        }

    }
    if (min==A[1][N-1]) *tmik=-1;
    return min;
}
int main(int argc,char** argv){
    FILE* infile;
    long long int min;
    long int i,N,xwrio;
    infile=fopen(argv[1],"r");      //anoigume to arxio isodu
    if (infile<0){                  //elegxume gia sfalmata sto anoigma tu arxeiou
        perror("fopen");
        exit(1);
    }
    fscanf(infile,"%ld",&N);         //diavazume ti metavliti N
    A=(long long int**)malloc(3*sizeof(long long int*));
    for(i=0;i<3;i++){
        A[i]=(long long int*)malloc(N*sizeof(long long int));
    }
    for(i=0;i<N;i++){               //sti sinexeia vazume stin proti grammi tu pinaka ton xrono pu 8elei ka8e
        fscanf(infile,"%lld",&A[0][i]);   //xwrio dld ta xi
    }
    gemisma(N);                   //kalume ti gemisma 
    min=elaxisto(N,&xwrio);       //vriskume to elaxisto kai ti 8esi tu me tin elaxisto
    xwrio++;                    //au3anoume to xwrio kata 1 gt exei -1 an einai ola ta xwria i alliws ti 8esi tu pinaka
    printf("%lld %ld \n",min,xwrio);   //typwnoume ta zitumena
    fclose(infile);                 //kleinoume to arxeio
    return 0;
}
