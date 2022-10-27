clear;
clc;

global gamma
gamma=1;
h=0.01;
N=365;
t=h*((1:N)-1);
n1=20;
x0=[linspace(-1,-0.4,n1),linspace(0.4,1,n1),linspace(-1,-0.4,n1),linspace(0.4,1,n1);
    -1*ones(1,2*n1),1*ones(1,2*n1)];
sigma=0.001;

xdata=[];
ydata=[];
iptdata=[];

for j=1:4*n1
    S=1;
    t0=0;
    xv=zeros(2,N);
    xv(:,1)=x0(:,j);
    for i=1:N-1
        if xv(2,i)<-1
            S=1;
        else
            if xv(2,i)>1
                S=2;
            end
        end
        
        if S==1
            xv(:,i+1)=rk4(t0,h,xv(:,i))+sqrt(sigma*h)*randn(2,1);
        else
            xv(:,i+1)=rk4_2(t0,h,xv(:,i))+sqrt(sigma*h)*randn(2,1);
        end
    end
    
%     figure;
%     plot(xv(1,:),xv(2,:));
%     
%     figure;
%     plot(t,xv(2,:));
    
    x=xv(2,:);
    xdt=(x(3:end)-x(1:end-2))/(2*h);
    ipt=findchangepts(xdt,'MaxNumChanges',5);
%     figure;
%     findchangepts(xdt,'MaxNumChanges',5);
    
    xdata=[xdata xv(1,:)];
    ydata=[ydata xv(2,:)];
    iptdata=[iptdata 0 ipt N-2];
end

figure;
for i=1:4*n1
    plot(xdata(((i-1)*N+1):i*N),ydata(((i-1)*N+1):i*N));
    hold on
end
hold off

J=1:7:560;
L=[iptdata(J+1)-iptdata(J);iptdata(J+2)-iptdata(J+1);iptdata(J+3)-iptdata(J+2);
    iptdata(J+4)-iptdata(J+3);iptdata(J+5)-iptdata(J+4);iptdata(J+6)-iptdata(J+5)];
L=reshape(L,[1,480]);
Ldata=L;

path = sprintf('xdata.mat');
save(path,'xdata');
path = sprintf('ydata.mat');
save(path,'ydata');
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
% plot([0,0.5],[-1,-1]);
% figure;
% plot([0,0.5],[1,1]);
