function xout=rk4_2(t0,h,x0)
k1=h*fun2(t0,x0);
k2=h*fun2(t0+h/2,x0+0.5*k1);
k3=h*fun2(t0+h/2,x0+0.5*k2);
k4=h*fun2(t0+h,x0+k3);
xout=x0+(k1+2*k2+2*k3+k4)/6;