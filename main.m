clear;
clc;

global a
a=1;
h=0.01;
N=3e3;
t=h*((1:N)-1);
x=zeros(1,N);
x(1)=8;
S=1;
t0=0;
sigma=0;

for i=1:N-1
    if x(i)>=9
        S=1;
    else
        if x(i)<=3
            S=2;
        else
            if (x(i)>6)&&(S==2)
                S=3;
            end
        end
    end
    
    if S==1
        x(i+1)=rk4(t0,h,x(i))+sqrt(sigma*h)*randn(1);
    elseif S==2
        x(i+1)=rk4_2(t0,h,x(i))+sqrt(sigma*h)*randn(1);
    else
        x(i+1)=rk4_3(t0,h,x(i))+sqrt(sigma*h)*randn(1);
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

ipt=findchangepts(xdt,'MaxNumChanges',11);
figure;
findchangepts(xdt,'MaxNumChanges',11);

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
% plot([0,30],[6,6]);
% figure;
% plot([0,30],[3,3]);
% figure;
% plot([0,30],[9,9]);
