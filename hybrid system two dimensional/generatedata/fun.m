function y=fun(~,x)

global gamma

y=zeros(size(x));
y(1)=-x(1);
y(2)=-gamma*(1+x(1)^2)*(x(2)-3);

