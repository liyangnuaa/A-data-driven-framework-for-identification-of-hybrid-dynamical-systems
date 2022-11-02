clear;
clc;

global kapa
kapa=10;
h=0.005;
% N=400;
% x0=[1.25;0];
% sigma=0;
N=30000;
x0=[0.8;0];
sigma=0.0001;
t=h*((1:N)-1);

S=2;
t0=0;
xv=zeros(2,N);
xv(:,1)=x0;
for i=1:N-1
    if xv(1,i)<1
        S=2;
    else
        S=1;
    end
    
    if S==1
        xv(:,i+1)=rk4(t0,h,xv(:,i))+sqrt(sigma*h)*randn(2,1);
    else
        xv(:,i+1)=rk4_2(t0,h,xv(:,i))+sqrt(sigma*h)*randn(2,1);
    end
end

figure;
plot(xv(1,:),xv(2,:));

figure;
plot(t,xv(2,:));

x=xv(2,:);
xdt=(x(3:end)-x(1:end-2))/(2*h);
ipt=findchangepts(xdt,'MaxNumChanges',91);
figure;
findchangepts(xdt,'MaxNumChanges',91);

% figure;
% plot(t,Y);
% 
% figure;
% plot(X,Y);

xdata1=xv(1,:);
ydata1=xv(2,:);
iptdata1=[0 ipt N-2];
Ldata1=iptdata1(2:end)-iptdata1(1:end-1);

path = sprintf('xdata1.mat');
save(path,'xdata1');
path = sprintf('ydata1.mat');
save(path,'ydata1');
path = sprintf('iptdata1.mat');
save(path,'iptdata1');
path = sprintf('Ldata1.mat');
save(path,'Ldata1');

% xdata2=xv(1,:);
% ydata2=xv(2,:);
% iptdata2=[0 ipt N-2];
% Ldata2=iptdata2(2:end)-iptdata2(1:end-1);
% 
% path = sprintf('xdata2.mat');
% save(path,'xdata2');
% path = sprintf('ydata2.mat');
% save(path,'ydata2');
% path = sprintf('iptdata2.mat');
% save(path,'iptdata2');
% path = sprintf('Ldata2.mat');
% save(path,'Ldata2');

% 
% figure;
% plot([1,1],[-2,2]);
