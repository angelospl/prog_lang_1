#include<stdio.h>
#include<stdlib.h>

typedef struct stoixeio stoixeio;
struct stoixeio{        //struct to implement a queue
    int i;
    int j;
    int type;
};
int cnt=0;
int f=0;
struct node{            //each node is a queue element
    stoixeio data;
    struct node* next;
};
struct node *front=NULL;        //pointers for the queue
struct node *rear=NULL;

stoixeio create(int i,int j,int type){  //function to create stoixeio 
    stoixeio temp;
    temp.i=i;
    temp.j=j;
    temp.type=type;
    return temp;
}
void enqueue(stoixeio item){    
    struct node *nptr=malloc(sizeof(struct node));
    nptr->data=item;
    nptr->next=NULL;
    if (rear==NULL){
        front=nptr;
        rear=nptr;
    }
    else{
        rear->next=nptr;
        rear=rear->next;
    }
    cnt++;
}
void dequeue(){
    struct node* temp;
    temp=front;
    front=front->next;
    free(temp);
    cnt--;
}

int display(int *x,int *y){
    struct node* temp;
    temp=front;
    *x=temp->data.i;
    *y=temp->data.j;
    return temp->data.type;
}

int empty(){    //check if queue is empty
    if (front==NULL) return 1;
    else return 0;
}
char paint(int i,int j,int type,int geit){      //function that puts the appropriate symbol in position i,j of the grid
    if (geit==0){
        stoixeio temp;
        temp=create(i,j,type);
        enqueue(temp);
        if (type==1) return '+';
        else  return '-';
    }
    else if(geit==1&&type==1) return '+';
    else if(geit==-1&&type==-1) return '-';
    else if (geit==4) return '*';
    else if (geit+type==0){
        f=1;
        return '*';
    }
    else return 'X';
}



int elegxos(char a){    //a helper function 
    if(a=='+') return 1;
    else if (a=='-') return -1;
    else if (a=='.') return 0;
    else if (a=='*') return  4;
    else return 2;
}

int main(int argc,char** argv){
    char A[1000][1000];
    int N,M,i,j,t,type,arx,ep;
    stoixeio temp;
    FILE* infile=fopen(argv[1],"r");
    if (infile<=0){
        perror("infile");
        exit(1);
    }
    N=0;
    M=0;
    i=0;
    j=0;
    while(!feof(infile)){       //read from file the grid
        char c=fgetc(infile);
        if (c=='\n'){
            N++;
            i++;
            M=j;
            j=0;
        }
        else {  //enqueue every '+' or '-' element 
            A[i][j]=c;
            if (c=='+'){
                temp=create(i,j,1);
                enqueue(temp);
            }
            else if (c=='-'){
                temp=create(i,j,-1);
                enqueue(temp);
            }
            j++;
        }
    }
    t=1;
    i=0;
    j=0;
    arx=cnt;
    ep=0;
    /*
    the general idea is:
    dequeue every + and - element from the queue
    check its neighbours and paint the neighbours accordingly
    if we have a conflict of + and - paint it as *
    */
    while(!empty()){
        ep++;
        type= display(&i,&j);
        //the following if checks for the border elements of the grid 
        if(i==0){       
            if (j>0) A[0][j-1]=paint(0,j-1,type,elegxos(A[0][j-1]));
            if (j<M-1) A[0][j+1]=paint(0,j+1,type,elegxos(A[0][j+1]));
            if (N>1) A[1][j]=paint(1,j,type,elegxos(A[1][j]));
        }
        else if(i<N-1){
            A[i-1][j]=paint(i-1,j,type,elegxos(A[i-1][j]));
            if (j>0) A[i][j-1]=paint(i,j-1,type,elegxos(A[i][j-1]));
            if (j<M-1) A[i][j+1]=paint(i,j+1,type,elegxos(A[i][j+1]));
            if (i<N-1) A[i+1][j]=paint(i+1,j,type,elegxos(A[i+1][j]));
        }
        else{
            A[N-2][j]=paint(N-2,j,type,elegxos(A[N-2][j]));
            if (j>0) A[N-1][j-1]=paint(N-1,j-1,type,elegxos(A[N-1][j-1]));
            if (j<M-1) A[N-1][j+1]=paint(N-1,j+1,type,elegxos(A[N-1][j+1]));
        }
        dequeue();
        if (ep==arx){   //we count every round that we dont have a conflict 
            if (f==1) break; 
            t++;
            arx=cnt;
            ep=0;
        }
    }
    if (f==1) printf("%d\n",t);
    else printf("the world is saved\n");
    for(i=0;i<N;i++){   //print the grid
        for(j=0;j<M;j++){
            printf("%c",A[i][j]);
        }
        printf("\n");
    }
    return 0;
}    
