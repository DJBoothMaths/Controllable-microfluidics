
%%%%%%%%%%%%%%%%%%%%%%%%
% elmint.m
%
% Integrate the free space Green's function
% stress tensor 
%
% over the lid on the cavity wall
%
% M G Blyth September 2010
%%%%%%%%%%%%%%%%%%%%%%%%

function [dlp] = dlpint(x1,x2,y1,y2,x0,y0)


%%%%
% Map element domain y1<y<y2 
% or x1<x<x2 to 
% canonical domain -1<t<1
% using t = am*y + bm
%%%%

am = -2/(x1-x2);
bm = (x1+x2)/(x1-x2);

y = y1;
a = x1;
b = x2;

%=====
% Set number of Gauss-Legendre
% points NQ
%=====

NQ = 8;

%---
% Get Gauss-Legendre
% weights
%---

[Z,W] = gauss_leg(NQ);

xm = 0.5*(b+a);
xd = 0.5*(b-a);

%---
% Compute integrals
%---

dlpint1 = 0.0;
dlpint2 = 0.0;

for q=1:NQ

    x = xm+xd*Z(q);
        
    r   = sqrt( (x-x0)^2 + (y-y0)^2 );
    xh1 = x-x0;
    xh2 = y-y0;
    
    T112 = -4*xh1*xh1*xh2/r^4;
    T122 = -4*xh1*xh2*xh2/r^4;
    T212 = -4*xh2*xh1*xh2/r^4;
    T222 = -4*xh2*xh2*xh2/r^4;
    
    dlpint1 = dlpint1 - T112*W(q);   % Accounting for direction of normal vector
    dlpint2 = dlpint2 - T122*W(q);
    
end

dlpint1 = dlpint1*abs(xd);
dlpint2 = dlpint2*abs(xd);

dlp(1) = dlpint1;
dlp(2) = dlpint2;

return