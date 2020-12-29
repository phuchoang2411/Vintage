Const
        fi='BFS.inp';
        go='BFS.out';
        maxn=100000;
        maxm=1000000;
Type
        canh=record
        u,v:LongInt;
End;
Var
        f,g:Text;
        n,m,s,t,first,last,max:LongInt;
        V:Array[1..maxn] of Boolean;
        Queue,P,Res:Array[1..maxn] of LongInt;
        e:Array[1..maxm] of canh;
        ke:Array[1..2*maxm] of LongInt;
        vt:Array[1..maxn+1] of LongInt;
Procedure qsort(l,r:LongInt);
Var
        u,v,x,t:LongInt;
Begin
        u:=l;
        v:=r;
        x:=ke[random(r-l+1)+l];
        Repeat
        While ke[u]<x do inc(u);
        While ke[v]>x do dec(v);
        If u<=v then
        Begin
                t:=ke[u];
                ke[u]:=ke[v];
                ke[v]:=t;
                inc(u);
                dec(v);
        End;
        Until u>v;
        If l<v then qsort(l,v);
        If u<r then qsort(u,r);
End;
Procedure buildgraph;
Var
        u,v,i:LongInt;
Begin
        Assign(f,fi);
        Reset(f);
        Fillchar(vt,sizeof(vt),0);
        Readln(f,n,m,s,t);
        For i:=1 to m do
        Begin
                Readln(f,e[i].u,e[i].v);
                inc(vt[e[i].u]);
        End;
        For i:=2 to n do vt[i]:=vt[i-1]+vt[i];
        For i:=1 to m do
        Begin
                u:=e[i].u;
                v:=e[i].v;
                ke[vt[u]]:=v;
                dec(vt[u]);
        End;
        randomize;
        For i:=1 to n do inc(vt[i]);
        vt[n+1]:=m+1;
        For i:=1 to n-1 do qsort(vt[i],vt[i+1]-1);
        close(f);
End;
Procedure emptyQueue;
Begin
        first:=1;
        last:=0;
End;
Procedure push(i:LongInt);
Begin
        inc(last);
        Queue[last]:=i;
End;
Procedure BFS(x:LongInt);
Var i,u,j:LongInt;
Begin
        emptyQueue;
        push(x);
        V[x]:=True;
        While last>=first do
        Begin
                i:=Queue[first];
                inc(first);
                If i=t then exit;
                For j:=vt[i] to vt[i+1]-1 do
                Begin
                        u:=ke[j];
                        If V[u]=False then
                        Begin
                                V[u]:=True;
                                P[u]:=i;
                                push(u);
                        End;
                End;
        End;
End;
Procedure trace;
Var i,c:LongInt;
Begin
        i:=1;
        c:=t;
        While c<>s do
        Begin
                res[i]:=c;
                inc(i);
                c:=P[c];
        End;
        res[i]:=s;
        max:=i;
End;
Procedure process;
Var i:LongInt;
Begin
        Assign(g,go);
        Rewrite(g);
        For i:=1 to n do V[i]:=False;
        BFS(s);
        Trace;
        For i:=max downto 1 do write(g,res[i],' ');
        Close(g);
End;
Begin
        buildgraph;
        process;
End.
