clear;
clc;

global a
a=1;
h=0.01;
N=2e3;
t=h*((1:N)-1);
x=zeros(1,N);
x(1)=0.5;
S=2;
t0=0;
sigma=0;

for i=1:N-1
    if x(i)>=6
        S=1;
    else
        if x(i)<=3
            S=2;
        end
    end
    
    if S==1
        x(i+1)=rk4(t0,h,x(i))+sqrt(sigma*h)*randn(1);
    else
        x(i+1)=rk4_2(t0,h,x(i))+sqrt(sigma*h)*randn(1);
    end
end

figure;
plot(t,x);

% figure;
% plot(t,X);

% figure;
% plot(t(464:667),y1);

%%% one order derivative
xdt=(x(3:end)-x(1:end-2))/(2*h);
figure;
plot(t(2:end-1),xdt);

ipt=findchangepts(xdt,'MaxNumChanges',6);
figure;
findchangepts(xdt,'MaxNumChanges',6);

xdata=x;
iptdata=ipt;
path = sprintf('xdata.mat');
save(path,'xdata');
path = sprintf('iptdata.mat');
save(path,'iptdata');

%%% two order derivative
xdtdt=(x(3:end)+x(1:end-2)-2*x(2:end-1))/(h^2);
figure;
plot(t(2:end-1),xdtdt);

% figure;
% plot([0,20],[6,6]);
% figure;
% plot([0,20],[3,3]);
