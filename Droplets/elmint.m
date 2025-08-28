
%%%%%%%%%%%%%%%%%%%%%%%%
% elmint.m
%
% Integrate the free space Green's function
%
% over an element on the cavity wall
%
% M G Blyth September 2010
%%%%%%%%%%%%%%%%%%%%%%%%

function [eint] = elmint(ielm,x1,x2,y1,y2,x0,y0)


%%%%
% Map element domain y1<y<y2 
% or x1<x<x2 to 
% canonical domain -1<t<1
% using t = am*y + bm
%%%%

if ielm == 0      % horizontal element

    am = -2/(x1-x2);
    bm = (x1+x2)/(x1-x2);

    y = y1;
    a = x1;
    b = x2;
    
end

if ielm == 1      % vertical element
    
    am = -2/(y1-y2);
    bm = (y1+y2)/(y1-y2);

    x = x1;
    a = y1;
    b = y2;

end


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

integral11 = 0.0;
integral12 = 0.0;
integral21 = 0.0;
integral22 = 0.0;


for q=1:NQ

    if ielm == 0 
        x = xm+xd*Z(q);
    end
    if ielm == 1
        y = xm+xd*Z(q);
    end
        
    r   = sqrt( (x-x0)^2 + (y-y0)^2 );
    xh1 = x-x0;
    xh2 = y-y0;
    
    f11 = -log(r) + xh1*xh1/r^2;
    f12 =           xh1*xh2/r^2;
    f21 =           xh2*xh1/r^2;
    f22 = -log(r) + xh2*xh2/r^2;
    
    integral11 = integral11 + f11*W(q);
    integral12 = integral12 + f12*W(q);
    integral21 = integral21 + f21*W(q);
    integral22 = integral22 + f22*W(q);
end

integral11 = integral11*abs(xd);
integral12 = integral12*abs(xd);
integral21 = integral21*abs(xd);
integral22 = integral22*abs(xd);

eint(1,1) = integral11;
eint(1,2) = integral12;
eint(2,1) = integral21;
eint(2,2) = integral22;

return