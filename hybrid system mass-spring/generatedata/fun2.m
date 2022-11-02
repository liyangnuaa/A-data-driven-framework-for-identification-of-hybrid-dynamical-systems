function y=fun2(~,x)

global kapa

y=zeros(size(x));
y(1)=x(2);
y(2)=1-kapa*(x(1)-1);

