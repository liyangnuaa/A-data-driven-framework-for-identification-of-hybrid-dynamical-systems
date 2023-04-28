clear;
clc;

h=0.02;
N=19998;
t=h*((1:N)-1);
% x0=[0.5;0];
x0=[3;0];
% x0=[-1;-1];
sigma=0.00001;

S=1;
t0=0;
xv=zeros(2,N);
xv(:,1)=x0;
for i=1:N-1
    if xv(1,i)<0.5
        S=2;
    else
        if xv(1,i)^2*cos(xv(2,i))^2/9+xv(1,i)^2*sin(xv(2,i))^2/4>1
            S=1;
        end
    end
    
    if S==1
        xv(:,i+1)=rk4(t0,h,xv(:,i))+sqrt(sigma*h)*randn(2,1);
    else
        xv(:,i+1)=rk4_2(t0,h,xv(:,i))+sqrt(sigma*h)*randn(2,1);
    end
end

xv1=xv;
xv=[xv(1,:).*cos(xv(2,:)); xv(1,:).*sin(xv(2,:))];
    
figure;
plot(xv(1,:),xv(2,:));

figure;
plot(t,sqrt(xv(1,:).^2+xv(2,:).^2));

x=sqrt(xv(1,:).^2+xv(2,:).^2);
xdt=(x(3:end)-x(1:end-2))/(2*h);
ipt=findchangepts(xdt,'MaxNumChanges',312);
figure;
findchangepts(xdt,'MaxNumChanges',312);

xdata=xv(1,:);
ydata=xv(2,:);
iptdata=[0 ipt N-2];
Ldata=iptdata(2:end)-iptdata(1:end-1);
path = sprintf('xdata.mat');
save(path,'xdata');
path = sprintf('ydata.mat');
save(path,'ydata');
path = sprintf('iptdata.mat');
save(path,'iptdata');
path = sprintf('Ldata.mat');
save(path,'Ldata');

% figure;
% plot(X,Y);

% figure;
% plot(xdata,ydata);


