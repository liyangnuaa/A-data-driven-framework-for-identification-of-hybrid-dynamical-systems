clear;
clc;

% h=0.02;
% N=2000;
h=0.001;
N0=40000;
n0=50;
N=N0/n0;
t=h*((1:N0)-1);
n1=10;
x02=linspace(0.2,1,n1);
x03=linspace(pi/6,5*pi/12,n1);
[X02,X03]=meshgrid(x02,x03);
x001=zeros(1,n1^2);
x002=reshape(X02,1,n1^2);
x003=reshape(X03,1,n1^2);
x0=[x001;x002;x003];
sigma=0.00001;

xdata=[];
ydata=[];
zdata=[];
iptdata=[];

for j=1:n1^2
    S=2;
    t0=0;
    xv=zeros(3,N0);
    xv(:,1)=x0(:,j);
    for i=1:N0-1
        if (xv(1,i)>0.4)&&(S==2)
            S=1;
        end
        
        if S==2
            xv(:,i+1)=rk4(t0,h,xv(:,i))+sqrt(sigma*h)*randn(3,1);
        else
            xv(:,i+1)=rk4_2(t0,h,xv(:,i))+sqrt(sigma*h)*randn(3,1);
        end
    end
    
%     figure;
%     plot(xv(1,:),xv(2,:));
%     
%     figure;
%     plot(t,xv(2,:));
    
    xv1=xv(:,1:n0:end);
    x=xv1(2,:);
    xdt=(x(3:end)-x(1:end-2))/(2*h);
    ipt=findchangepts(xdt,'MaxNumChanges',1);
%     figure;
%     findchangepts(xdt,'MaxNumChanges',1);
    
    xdata=[xdata xv1(1,:)];
    ydata=[ydata xv1(2,:)];
    zdata=[zdata xv1(3,:)];
    iptdata=[iptdata 0 ipt N-2];
end

figure;
for i=1:n1^2
    plot3(xdata(((i-1)*N+1):i*N),ydata(((i-1)*N+1):i*N),zdata(((i-1)*N+1):i*N));
    hold on
end
hold off

J=1:3:3*n1^2;
L=[iptdata(J+1)-iptdata(J);iptdata(J+2)-iptdata(J+1)];
L=reshape(L,[1,2*n1^2]);
Ldata=L;

path = sprintf('xdata.mat');
save(path,'xdata');
path = sprintf('ydata.mat');
save(path,'ydata');
path = sprintf('zdata.mat');
save(path,'zdata');
path = sprintf('iptdata.mat');
save(path,'iptdata');
path = sprintf('Ldata.mat');
save(path,'Ldata');

% figure;
% plot(xv(1,:),xv(2,:));
% 
% figure;
% plot(t,xv(2,:));

% t1=[t,20];
% figure;
% plot(t1,X);

% figure;
% plot(t(464:667),y1);

% %%% one order derivative
% x=xv(2,:);
% xdt=(x(3:end)-x(1:end-2))/(2*h);
% figure;
% plot(t(2:end-1),xdt);
% 
% ipt=findchangepts(xdt,'MaxNumChanges',3);
% figure;
% findchangepts(xdt,'MaxNumChanges',3);
% 


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

% %%% two order derivative
% xdtdt=(x(3:end)+x(1:end-2)-2*x(2:end-1))/(h^2);
% figure;
% plot(t(2:end-1),xdtdt);

% xdtdt2=filter(b,1,xdtdt);
% figure;
% plot(t(2:end-1),xdtdt2);

% xdtdt3= filtfilt(d1,xdtdt);
% figure;
% plot(t(2:end-1),xdtdt3);

% figure;
% plot([0,0.5],[-1,-1]);
% figure;
% plot([0,0.5],[1,1]);
