clear all
clc
A = [2,3,-1,4;1,-2,6,7]
B = [8;-3]
C = [2,3,4,7]

m = size(A,1)
n = size(A,2)

if n>=m

ncm = nchoosek(n,m)
t = nchoosek(1:n,2)

sol = []

for i = 1:ncm
    y=zeros(n,1)
    x=A(:,t(i,:))\B
    if all(x>=0 & x~=inf & x~=-inf)
    y(t(i,:))=x
    sol =[sol y]
    end  
end

else
    Error("Number of constraints are more than number of varaibles")
end

z = C*sol

[zmax,zind]= max(z)
BFS=sol(:,zind)

optval = [BFS' zmax]
optimal_bfs=array2table(optval)
optimal_bfs.Properties.VariableNames(1:size(optimal_bfs,2))={'x1','x2','x3','x4','zmax'}
