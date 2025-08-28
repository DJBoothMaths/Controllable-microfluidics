function [ux,uy] = flow_point(x, y, N,L,H, f, ubot, utop)
Ubound = [ubot; zeros(N,1); flip(utop); zeros(N,1)];

[elmx, elmy, ~] = disc_rect(N,L,H);
ux = 0;
uy = 0;
if or(y<0.1,y>2.9)
    for k = 1:4*N
            [slxx,slxy,slyx,slyy,dlxx,~,dlyx,~] = stokes_sdlp(x, y, elmx(k,1), elmy(k,1), elmx(k,2), elmy(k,2), 20, 0);
           ux = ux - (1/(4*pi))*(slxx*f(k,1)+slxy*f(k,2)) + (1/(4*pi))*Ubound(k)*dlxx;
           uy = uy - (1/(4*pi))*(slyx*f(k,1)+slyy*f(k,2)) + (1/(4*pi))*Ubound(k)*dlyx;
    end
else
    for k = 1:4*N
            [slxx,slxy,slyx,slyy,dlxx,~,dlyx,~] = stokes_sdlp(x, y, elmx(k,1), elmy(k,1), elmx(k,2), elmy(k,2), 8, 0);
           ux = ux - (1/(4*pi))*(slxx*f(k,1)+slxy*f(k,2)) + (1/(4*pi))*Ubound(k)*dlxx;
           uy = uy - (1/(4*pi))*(slyx*f(k,1)+slyy*f(k,2)) + (1/(4*pi))*Ubound(k)*dlyx;
    end
end
   
end
