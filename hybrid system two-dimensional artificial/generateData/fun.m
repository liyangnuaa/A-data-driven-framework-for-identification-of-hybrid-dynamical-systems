function y=fun(~,x)

y=zeros(size(x));
y(1)=-0.2-1/(sqrt(x(1))+1)-2/(exp(0.2*x(1))+1);
y(2)=0.2*(0.5+log(x(1)^2+1));

