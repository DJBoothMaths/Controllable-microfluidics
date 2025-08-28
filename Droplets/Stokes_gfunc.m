function [S, T] = Stokes_gfunc(x,y,x0,y0)

S=zeros(2);
T=zeros(2,2,2);

xhat = x-x0;
yhat = y-y0;
r2 = xhat^2 + yhat^2;

S(1,1) = -0.5*log(r2) + xhat^2/r2;
S(1,2) = xhat*yhat/r2;
S(2,1) = xhat*yhat/r2;
S(2,2) = -0.5*log(r2) + yhat^2/r2;


T(1,1,1) = - 4* xhat^3/(r2^2);
T(2,2,2) = - 4* (yhat^3)/(r2^2);
T(1,1,2) = - 4* yhat*xhat^2/(r2^2);
T(2,1,1) = T(1,1,2);
T(1,2,1) = T(1,1,2);
T(1,2,2) = - 4* yhat^2*xhat/(r2^2);
T(2,2,1) = T(1,2,2);
T(2,1,2) = T(1,2,2);
end
