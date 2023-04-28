function y=fun2(~,x)

y=zeros(size(x));
y(1)=0.2+1/(x(1)^1.5+1)+exp(-0.1*x(1));
y(2)=0.2*(0.5+log(x(1)^2+1));

