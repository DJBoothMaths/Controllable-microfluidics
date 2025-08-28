function [time, xtraj, ytraj] = particle_trans_discrete_2(xst,yst,xend, N, L, H,tsep, dt)
%fully discrete droplet positions 1<x<3,3<x<5,... 

xtraj(1) = xst;
ytraj(1) = yst;



Nt = floor(tsep/dt);

for j=1:(L-2)/2-1
    %drop setup
    drop_centre = 2*j+1;
    Abot = zeros(N,1);
    Abot(floor(drop_centre*(N-1)/L)+1-(N-1)/L:floor(drop_centre*(N-1)/L)+1+(N-1)/L)=-1;
    Atop = zeros(N,1);

    % solve BEM equations
    [c,~] = laplace_BEM_2d(N,L,H,Abot,Atop);
    [ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 0);
    f = stokes_BEM_2d(N,L,H,ubot,utop);

        [ux,uy] = flow_point(xtraj(Nt*(j-1)+1), ytraj(Nt*(j-1)+1), N,L,H, f, ubot, utop);
        xtraj(Nt*(j-1)+2) = xtraj(Nt*(j-1)+1) + (ux)*dt;
        ytraj(Nt*(j-1)+2) = ytraj(Nt*(j-1)+1) + (uy)*dt;

    for i=2:Nt
    
        %compute movement of particle
        [ux1,uy1] = flow_point(xtraj(Nt*(j-1)+i), ytraj(Nt*(j-1)+i), N,L,H, f, ubot, utop);
        [ux2,uy2] = flow_point(xtraj(Nt*(j-1)+i-1), ytraj(Nt*(j-1)+i-1), N,L,H, f, ubot, utop);
        xtraj(Nt*(j-1)+i+1) = xtraj(Nt*(j-1)+i) + (3*ux1-ux2)*dt/2;
        ytraj(Nt*(j-1)+i+1) = ytraj(Nt*(j-1)+i) + (3*uy1-uy2)*dt/2;
        if xtraj(Nt*(j-1)+i+1)>xend
            break
        end
    end
end
if xtraj(Nt*(j-1)+i+1)<xend
    for i=1:10000   
        j=(L-2)/2;
        %compute movement of particle
        [ux1,uy1] = flow_point(xtraj(Nt*(j-1)+i), ytraj(Nt*(j-1)+i), N,L,H, f, ubot, utop);
        [ux2,uy2] = flow_point(xtraj(Nt*(j-1)+i-1), ytraj(Nt*(j-1)+i-1), N,L,H, f, ubot, utop);
        xtraj(Nt*(j-1)+i+1) = xtraj(Nt*(j-1)+i) + (3*ux1-ux2)*dt/2;
        ytraj(Nt*(j-1)+i+1) = ytraj(Nt*(j-1)+i) + (3*uy1-uy2)*dt/2;
        if xtraj(Nt*(j-1)+i+1)>xend
            break
        end
    end
end
time = (Nt*j+i)*dt;

end