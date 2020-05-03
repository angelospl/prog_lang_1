# -*- coding: utf-8 -*-
"""
Created on Thu Jun  7 12:31:39 2018

@author: Aggelos
"""
from collections import deque
class point:
    def __init__(self,i,j,val,xronos):
        self.x=i
        self.y=j
        self.value=val
        self.time=xronos
    def change(self,other):
        if (other=='.' or other==self.value):
            return self.value
        elif ((other=='+' and self.value=='-') or (other=='-' and self.value=='+') or other=='*'):
            return '*'
        elif (other=='X'):
            return 'X'
class map:
    def __init__(self,f):
        self.xartis = [[[0 for k in range(2)] for j in range(10)] for i in range(10)]   
        self.oura=deque()
        i=j=self.N=self.M=0
        while True:
            c=f.read(1)
            if not c:
                self.N=self.N+1
                self.M=j
                break
            else:
                if (c!='\n'):
                    if (c=='+' or c=='-'):
                        elem=point(i,j,c,0)
                        self.oura.appendleft(elem)
                    self.xartis[0][j][i]=c
                    j=j+1
                else:
                    self.N=self.N+1 
                    self.M=j
                    j=0
                    i=i+1

    def exw_mpei(self,elem):
        if(self.xartis[1][elem.y][elem.x]==elem.value):
            return True
        else:
            return False
    def enqueue (self,elem):
        self.oura.append(elem)
        self.xartis[1][elem.y][elem.x]=elem.value
    def vale_geitones(self,x,y,xar,nosxro):
        geitp=point(x-1,y,xar,nosxro+1)
        geitk=point(x+1,y,xar,nosxro+1)
        geitd=point(x,y+1,xar,nosxro+1)
        geita=point(x,y-1,xar,nosxro+1)
        if(x==0 and self.N==1 and y==0 and not self.exw_mpei(geitd)):
            self.enqueue(geitd)
        elif (x==0 and self.N==1 and y==self.M-1 and not self.exw_mpei(geita)):
            self.enqueue(geita)
        elif (x==0 and self.N==1 and y>0 and y<self.M-1):
            if (not self.exw_mpei(geitd)):
                self.enqueue(geitd)
            if (not self.exw_mpei(geita)):
                self.enqueue(geita)
        elif (x==0 and y==0):
            if (not self.exw_mpei(geitd)):
                self.enqueue(geitd)
            if (not self.exw_mpei(geitk)):
                self.enqueue(geitk)
        elif (x==0 and y<self.M-1):
            if (not self.exw_mpei(geitk)):
                self.enqueue(geitk)
            if (not self.exw_mpei(geitd)):
                self.enqueue(geitd)
            if (not self.exw_mpei(geita)):
                self.enqueue(geita)
        elif (x==0 and y==self.M-1):
            if (not self.exw_mpei(geitk)):
                self.enqueue(geitk)
            if (not self.exw_mpei(geita)):
                self.enqueue(geita)
        elif (x<self.N-1 and y==0):
            if (not self.exw_mpei(geitd)):
                self.enqueue(geitd)
            if (not self.exw_mpei(geitp)):
                self.enqueue(geitp)
            if (not self.exw_mpei(geitk)):
                self.enqueue(geitk)
        elif (x<self.N-1 and y<self.M-1):
            if (not self.exw_mpei(geita)):
                self.enqueue(geita)
            if (not self.exw_mpei(geitk)):
                self.enqueue(geitk)
            if (not self.exw_mpei(geitd)):
                self.enqueue(geitd)
            if (not self.exw_mpei(geitp)):
                self.enqueue(geitp)
        elif (x<self.N-1 and y==self.M-1):
            if (not self.exw_mpei(geita)):
                self.enqueue(geita)
            if (not self.exw_mpei(geitp)):
                self.enqueue(geitp)
            if (not self.exw_mpei(geitk)):
                self.enqueue(geitk)
        elif (x==self.N-1 and y==0):
            if (not self.exw_mpei(geitp)):
                self.enqueue(geitp)
            if (not self.exw_mpei(geitd)):
                self.enqueue(geitd)
        elif (x==self.N-1 and y<self.M-1):
            if (not self.exw_mpei(geitp)):
                self.enqueue(geitp)
            if (not self.exw_mpei(geita)):
                self.enqueue(geita)
            if (not self.exw_mpei(geitd)):
                self.enqueue(geitd)
        else:
            if (not self.exw_mpei(geita)):
                self.enqueue(geita)
            if (not self.exw_mpei(geitp)):
                self.enqueue(geitp) 
    def solve(self):
        doom=0
        doomtime=-1
        while(1):
            try:
                stoixeio=self.oura.popleft()
            except IndexError:
                break;
            x=stoixeio.x
            y=stoixeio.y
            mellon=stoixeio.change(self.xartis[0][y][x])
            if (doom==0 or (doom==1 and stoixeio.time<=doomtime)):
                if (mellon !=self.xartis[0][y][x]):
                    self.xartis[0][y][x]=mellon
                if (self.xartis[0][y][x]=='*' and doom==0):
                    doom=1
                    doomtime=stoixeio.time
                elif (self.xartis[0][y][x]=='+' or self.xartis[0][y][x]=='-'):
                    self.vale_geitones(x,y,self.xartis[0][y][x],stoixeio.time)
        return doomtime
    def print_map(self):
        for i in range(self.N):
            for j in range(self.M):
                print(self.xartis[0][j][i],end="")
            print()
if __name__ =="__main__":
    import sys
    with open(sys.argv[1],"rt") as f:
        xartis=map(f)
        telos=xartis.solve()
        if (telos==-1): 
            print("the world is saved")
        else:
            print(telos)
        xartis.print_map()
        
            
            