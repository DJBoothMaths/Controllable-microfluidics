function [ux,uy] = flow_point(x, y, N,L,H, f, ubot, vbot,drop_centre,theta)
Ubound = [ubot; zeros(3*N,1)];
Vbound = [vbot; zeros(3*N,1)];

[elmx, elmy, ~] = disc_one_drop(N,L,H,drop_centre,theta);
ux = 0;
uy = 0;

    for k = 1:4*N
            [slxx,slxy,slyx,slyy,dlxx,dlxy,dlyx,dlyy] = stokes_sdlp(x, y, elmx(k,1), elmy(k,1), elmx(k,2), elmy(k,2), 20, 0);
           ux = ux - (1/(4*pi))*(slxx*f(k,1)+slxy*f(k,2)) + (1/(4*pi))*(Ubound(k)*dlxx+Vbound(k)*dlxy);
           uy = uy - (1/(4*pi))*(slyx*f(k,1)+slyy*f(k,2)) + (1/(4*pi))*(Ubound(k)*dlyx+Vbound(k)*dlyy);
    end
end
   

