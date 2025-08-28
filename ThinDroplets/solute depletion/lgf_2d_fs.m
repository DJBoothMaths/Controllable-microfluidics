 function [G,Gx,Gy] = lgf_2d_fs(x,y,x0,y0,Iopt)
% initialize
G = 0;
Gx = 0;
Gy = 0;

% Green's function
dx = x-x0;
dy = y-y0;
rs = dx*dx+dy*dy;
G  = -log(rs)/(4*pi);

% gradient
if(Iopt>1)
 den = rs*2*pi;
 Gx =  -dx/den;
 Gy =  -dy/den;
end

