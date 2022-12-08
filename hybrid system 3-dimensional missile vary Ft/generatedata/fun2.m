function y=fun2(~,x)

Vsc=500;
ssc=5000;
m0=500;
m1=225;
m=m1;
F=100000;
d=0.278;
S=pi*d^2/4;
tau_on=288.34;
rou_on=1.225;
g_on=9.806;
rou=rou_on*(1-2.0323e-5*ssc*x(1))^4.83;
R=6371000;
g=g_on*(1-2*ssc*x(1)/R);
soundspeed=20.046*sqrt(tau_on-5.86e-3*ssc*x(1));
Ma=Vsc*x(2)/soundspeed;

M1=0.6;
M2=0.8;
M3=0.9;
M4=1;
M5=1.1;
% C1=0.14942;
% C2=0.15754;
% C3=0.17140;
% C4=0.28832;
% C5=0.34312;
C1=0.1423;
C2=0.1556;
C3=0.1687;
C4=0.2771;
C5=0.3365;
if Ma<M1
    Cx0=C1;
elseif Ma<M2
    Cx0=C1*(Ma-M1)/(M2-M1)+C2*(M2-Ma)/(M2-M1);
elseif Ma<M3
    Cx0=C2*(Ma-M2)/(M3-M2)+C3*(M3-Ma)/(M3-M2);
elseif Ma<M4
    Cx0=C3*(Ma-M3)/(M4-M3)+C4*(M4-Ma)/(M4-M3);
elseif Ma<M5
    Cx0=C4*(Ma-M4)/(M5-M4)+C5*(M5-Ma)/(M5-M4);
else
    Cx0=C5;
end

y=zeros(size(x));
y(1)=Vsc/ssc*x(2)*sin(x(3));
y(2)=(-Cx0*1/2*rou*Vsc^2*S*x(2)^2-m*g*sin(x(3)))/(m*Vsc);
y(3)=-g*cos(x(3))/(Vsc*x(2));
y(4)=1;

