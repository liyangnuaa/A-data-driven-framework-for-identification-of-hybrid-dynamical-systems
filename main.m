clear;
clc;

global a
a=1;
h=0.001;
N=1e3;
t=h*((1:N)-1);
x=zeros(1,N);
x(1)=18;
S=1;
t0=0;
sigma=0;

for i=1:N-1
    if x(i)>=21
        S=1;
    else
        if x(i)<=19
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

ipt=findchangepts(xdt,'MaxNumChanges',5);
figure;
findchangepts(xdt,'MaxNumChanges',5);

xdata=x;
iptdata=ipt;
path = sprintf('xdata.mat');
save(path,'xdata');
path = sprintf('iptdata.mat');
save(path,'iptdata');

% w=5;
% b=1/w*ones(1,w);
% xdt2=filter(b,1,xdt);
% figure;
% plot(t(2:end-1),xdt2);

% d1 = designfilt('lowpassiir','FilterOrder',12, ...
%     'HalfPowerFrequency',0.5,'DesignMethod','butter');
% xdt3= filtfilt(d1,xdt);
% figure;
% plot(t(2:end-1),xdt3);

%%% two order derivative
xdtdt=(x(3:end)+x(1:end-2)-2*x(2:end-1))/(h^2);
figure;
plot(t(2:end-1),xdtdt);

% xdtdt2=filter(b,1,xdtdt);
% figure;
% plot(t(2:end-1),xdtdt2);

% xdtdt3= filtfilt(d1,xdtdt);
% figure;
% plot(t(2:end-1),xdtdt3);


% figure;
% plot(t(1:(ipt(1)+1)),x(1:(ipt(1)+1)));
% figure;
% plot(t((ipt(1)+1):(ipt(2)+1)),x((ipt(1)+1):(ipt(2)+1)));
% figure;
% plot(t((ipt(2)+1):(ipt(3)+1)),x((ipt(2)+1):(ipt(3)+1)));
% figure;
% plot(t((ipt(3)+1):(ipt(4)+1)),x((ipt(3)+1):(ipt(4)+1)));
% figure;
% plot(t((ipt(4)+1):(ipt(5)+1)),x((ipt(4)+1):(ipt(5)+1)));
% figure;
% plot(t((ipt(5)+1):N),x((ipt(5)+1):N));

% figure;
% plot([0,1],[21,21]);
% figure;
% plot([0,1],[19,19]);
