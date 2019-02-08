(*function to read the input file
this function returns a tuple containing the number of elements read
and a list of those elemens
this list is reverted as a result of the way this function works*)
fun parse file=
    let
        fun readInt input=
            Option.valOf(TextIO.scanStream(Int64.scan StringCvt.DEC)input)

        val inStream=TextIO.openIn file
        val n=readInt inStream
        val _=TextIO.inputLine inStream
        fun readInts 0  acc=acc
         |readInts i acc=readInts (i-1) (readInt inStream::acc)   
    in
        (Int64.toInt n,readInts n [])
    end
(*function that computes the least common multiple
 of 2 numbers using their greatest common divider*)
fun lcm (a:Int64.int) (b:Int64.int)=
    let 
        fun gcd a 0=  a
         | gcd a b=gcd  b (a mod b)
    in
         a div (gcd a b)*b
    end
(*function that takes a list A and returns a list B using the relation
B[i]=lcm(A[i],B[i-1])*)
exception empty;
fun fill []=raise empty
    |fill [a]=[]
    |fill (a::b::xs)=
        let 
            val ekp=lcm a b
        in
            ekp::fill (ekp::xs)
        end
(*function that takes a list and returns the same list reverted*)
fun reverse xs=
    let
        fun rev (nil,z)=z
        | rev (y::ys,z)=rev (ys,y::z)
    in
        rev (xs,nil)
    end
(*takes a list,reverts it and calls the fill function on it 
if we think about the starting list of the problem,since our 
parse function returned a reverted list,we need to use reverse first
in order to have the same list given as input so its like calling
the fill function from left to right in the list given*)
fun fill_left []=[]
| fill_left a=
    let
        val c=reverse a;
        fun prwto []=raise empty
        | prwto [a]=a
        | prwto (a::xs)=a
    in
       ((prwto c)::(fill c))
    end
(*this functions take a list,uses fill on it and appends to the end of it
the first element of the list given as input
since the parse function returns the input function in reverse
in this function we start from left to right to the reverted list
so its like starting from right to left in the list given as input
for the problem*)
fun fill_right []=[]
| fill_right (a::xs)=
    (reverse (fill (a::xs)))@[a]
(*this function takes  the 2 lists(A,B) created by the fill functions
creates a 3rd list C with the formula C[i]=lcm(A[i-1],B[i+1])*)
fun mikrotero (a::bs::ys) (b::c::xs) n=
    let
        exception empty
        fun forlst [] b=raise empty
        |forlst (a::xs) []=[a]
        |forlst (hd::tl) (hd2::tl2)=
            let
                val ekp=lcm hd hd2
            in
                (ekp::forlst tl tl2)
            end
        val d=forlst (a::bs::ys) (xs)
        val d=(c::d) 
        fun mikr []=raise empty
        | mikr [a:Int64.int]=a
        | mikr (a::b::xs)= if a < b then mikr (a::xs) else mikr (b::xs)
        fun thesi min [] =raise empty
         | thesi min (x::xs)=
            if min = x then 0 else 1 + (thesi min xs)
        val min=mikr d
        val tmik=if min = b then 0 else (thesi min d)+1
    in
        print(Int64.toString min^" "^Int64.toString tmik^"\n")
    end
fun solve(n,lista)=mikrotero (fill_left lista) (fill_right lista) n
fun agora filename=solve(parse filename)
