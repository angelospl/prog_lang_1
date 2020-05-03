structure M=BinaryMapFn(struct
        type ord_key=int*int
        fun compare ((x1,y1),(x2,y2))=
        if x1>x2 orelse (x1=x2 andalso y1>y2) then GREATER else if (x1<x2 orelse (x1=x2 andalso y1<y2)) then LESS else EQUAL

        end)
fun parse file=
    let
        fun readc input=
            Option.valOf(TextIO.input1 input) 
            handle Option => #"e"
        val inStream=TextIO.openIn file
        val xarti=M.empty
        fun diavasma xarti (x,y) n m=
            let 
                val stoixeio=readc inStream
            in
                if stoixeio= #"." then diavasma (M.insert (xarti,(x,y),".")) (x,y+1) n (m+1) 
                else if stoixeio= #"+" then diavasma (M.insert (xarti,(x,y),"+")) (x,y+1) n (m+1)
                else if stoixeio= #"-" then diavasma (M.insert (xarti,(x,y),"-")) (x,y+1) n (m+1)
                else if stoixeio= #"X" then diavasma (M.insert (xarti,(x,y),"X")) (x,y+1) n (m+1) 
                else if stoixeio = #"\n" then diavasma xarti (x+1,0) (n+1) m
                else (xarti,n,m div n) 
            end
        in
            diavasma xarti (0,0) 0 0    
        end
fun find (a,b)=Option.valOf(M.find (a,b)) 
val qu:(string*(int*int)*int*int) Queue.queue=Queue.mkQueue ()
fun vale a=Queue.enqueue (qu,a)
val pinakas=Array2.array (1000,1000,"e")
fun gemisma xarti=
    let
        fun eisagogi (key,x)=
            if x = "+"orelse x= "-"  then vale (x,key,0,0)
            else ()
    in
        M.appi eisagogi xarti
    end
fun pr (n,_,_)=n
fun typwse xarti m t f=
    let
        val a= if (f = 0) then ("the world is saved") else (Int.toString t)
        fun typ ((x,y),v)=
            if y=(m-1) then print(v^"\n") else print(v)
    in
        print (a^"\n");
        M.appi typ xarti 
    end
fun pare ()=Queue.dequeue qu
fun solve xarti (n,m) time telos 1=typwse xarti m time telos
|solve xarti (n,m) time telos el=
    let
        fun allagi (v,key,t,f) xarti (n,m)=
            let
                fun mellon v2=
                    if telos=0 andalso (v="+" andalso (v2="." orelse v2="-")) then "+"
                    else if telos=0 andalso (v="-" andalso (v2="." orelse v2="+")) then "-"
                    else "X"
                fun value v2=
                    if v2="." orelse v=v2 then v
                    else "*"
                fun geitones (x,y)=
                    let
                        val geitp=((x-1),y)
                        val geitk=((x+1),y)
                        val geitd=(x,y+1)
                        val geita=(x,y-1)
                    in
                        if x=0 andalso n=1 andalso y=0 then [geitd]
                        else if x=0 andalso (n=1 andalso y=(m-1)) then [geita]
                        else if x=0 andalso n=1 andalso y>0 andalso y<(m-1) then [geita,geitd]
                        else if x=0 andalso y=0 then [geitk,geitd]
                        else if x=0 andalso y<(m-1) then [geitk,geitd,geita]
                        else if x=0 andalso y=(m-1) then [geitk,geita]
                        else if x<(n-1) andalso y=0 then [geitd,geitp,geitk]
                        else if x<(n-1) andalso y<(m-1) then [geita,geitd,geitp,geitk]
                        else if x<(n-1) andalso y=(m-1) then [geita,geitp,geitk]
                        else if x=(n-1) andalso y=0 then [geitp,geitd]
                        else if x=(n-1) andalso y<(m-1) then [geitp,geita,geitd]
                        else [geita,geitp]
                    end
                fun xroma xarti [] ()=()
                |xroma xarti (a::tl) ()=
                let
                    val grps=mellon (find (xarti,a))
                    val (tetm,tetag)=a
                in
                    if (grps="+" orelse grps="-") andalso grps<>(Array2.sub (pinakas,tetm,tetag)) then xroma xarti tl (vale (grps,a,t+1,0);Array2.update (pinakas,tetm,tetag,grps)) 
                    else xroma xarti tl ()
                end
                val timi=value (find (xarti,key))
                val neos=if telos=1 andalso t>time then xarti else M.insert (xarti,key,timi) 
                val c= if timi="*" orelse f=1 orelse telos=1 then 1 else 0
                val kat=if timi= "*" andalso time=0 then t else time
            in
                if c=0 then (xroma neos (geitones key) (),neos,kat,c)
                else ((),neos,kat,c)
            end
        val ((un,neos,xronos,doom),el)= ((allagi (pare ()) xarti (n,m)),0)
        handle Dequeue => (((),xarti,time,telos),1)
    in
        solve neos (n,m) xronos doom el
    end
fun doomsday file=
    let
        val (xarti,n,m)=parse file
    in
        gemisma xarti;
        solve xarti (n,m) 0 0 0
    end
