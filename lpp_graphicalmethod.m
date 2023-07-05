format short
clear all
clc
A=[1,2;1,1;0,1]
B=[2000;1500;600]
C=[3 5]

y1=0:1:max(B)
x21=(B(1)-A(1,1)*y1)/A(1,2)
x22=(B(2)-A(2,1)*y1)/A(2,2)
x23=(B(3)-A(3,1)*y1)/A(3,2)

x21=max(0,x21)
x22=max(0,x22)
x23=max(0,x23)

plot(y1,x21,'r')
hold on
plot(y1,x22,'k')
hold on
plot(y1,x23,'b')

xlabel('x axis')
ylabel('y axis')
title('X1 vs X2')
legend('x1+2x2=2000','x1+x2=1500','x2=600')
grid on

cx1=find(y1==0)
c1=find(x21==0)
c2=find(x22==0)
c3=find(x23==0)

line1=[y1(:,[c1,cx1]);x21(:,[c1,cx1])]'
line2=[y1(:,[c2,cx1]);x22(:,[c2,cx1])]'
line3=[y1(:,[c3,cx1]);x23(:,[c3,cx1])]'

corpt=unique([line1;line2;line3],'rows')

pt=[0 0]
for i=1:size(A,1)
    for j=i+1:size(A,1)
        A1=A([i,j],:)
        B1=B([i,j],:)
        X=A1\B1
        pt=[pt;X']
    end
end

allpt=[pt;corpt]
points=unique(allpt,'rows')

for i=1:size(points,1)
    const1(i)=A(1,1)*points(i,1)+A(1,2)*points(i,2)-B(1)
    const2(i)=A(2,1)*points(i,1)+A(2,2)*points(i,2)-B(2)
    const3(i)=A(3,1)*points(i,1)+A(3,2)*points(i,2)-B(3)
end
S1=find(const1>0)
S2=find(const2>0)
S3=find(const3>0)

S=unique([S1,S2,S3])
points(S,:)=[]

Z=points*C'
[zmax,zind]=max(Z)
optimal=points(zind,:)

optval=[optimal zmax]
optimal_sol=array2table(optval)
optimal_sol.Properties.VariableNames(1:size(optimal_sol,2))={'x1','x2','Value_of_z'}





