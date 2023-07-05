format short
clear all
clc
A=[1,2;1,1,;0,1]
B=[2000;1500;600]
C=[3,5]

IneqSign=[1 1 2]

S=eye(size(A,1))
inq = find(IneqSign>1)
S(inq,:)=-S(inq,:)

Mat = [A S B]
constraint=array2table(Mat)
constraint.Properties.VariableNames(1:size(constraint,2))={'x1','x2','s1','s2','s3','sol'}

newA=[1,2,1,0,0;1,1,0,1,0;0,1,0,0,-1]
newB=[2000;1500;600]
newC=[3,5,0,0,0]

m=size(newA,1)
n=size(newA,2)
if n>m
    ncm=nchoosek(n,m)
    t=nchoosek(1:n,m)

    sol=[]
    for i=1:ncm
        y=zeros(n,1)
        x=newA(:,t(i,:))\newB
        if all(x>=0 & x~=inf & x~=-inf)
            y(t(i,:))=x
            sol = [sol y]
        end
    end
else
    error('number of constraints are greater than number of variables')
end
Z=newC*sol

[zmax,zind]=max(Z)
BFS=sol(:,zind)

optval=[BFS' zmax]
optimal_BFS=array2table(optval)
optimal_BFS.Properties.VariableNames(1:size(optimal_BFS,2))={'x1','x2','s1','s2','s3','value_of_z'}
