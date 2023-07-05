clc
clear all
c=[6 4 1 5;8 9 2 7;4 3 6 4]
a=[14; 16; 5];
b=[6 10 15 4];
m=size(c,1);
n=size(c,2);
z=0;
if sum(a)==sum(b)
    fprintf('Given transportation problem is Balanced \n');
else
     fprintf('Given transportation problem is Unbalanced \n');
     if sum(a)<sum(b)
         c(end+1,:)=zeros(1,length(b))
         a(end+1)=sum(b)-sum(a)
     else
         c(:,end+1)=zeros(length(a),1)
         b(end+1)=sum(a)-sum(b)
     end
end
X=zeros(m,n)
InitialC=c
   for i=1:size(c,1)
       for j=1:size(c,2)
    cpq=min(c(:))
    if cpq==Inf
    break
       end
[p1,q1]=find(cpq==c)
xpq=min(a(p1),b(q1))
[X1,ind]=max(xpq) 
p=p1(ind)
q=q1(ind)
X(p,q)=min(a(p),b(q))
if min(a(p),b(q))==a(p)
b(q)=b(q)-a(p)
a(p)=a(p)-X(p,q)
c(p,:)=Inf
else
    a(p)=a(p)-b(q)
    b(q)=b(q)-X(p,q)
    c(:,q)=Inf
end
       end
   end
for i=1:size(c,1)
    for j=1:size(c,2)
z=z+InitialC(i,j)*X(i,j)
    end
end
%fprintf('Initial BFS \n')
array2table(X)
fprintf('Transportation cost is %f \n',z);
