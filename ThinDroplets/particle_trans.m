function [time, xtraj, ytraj] = particle_trans(xst,yst, xend, N, L, H, dt)

time = 0;
xtraj(1) = xst;
ytraj(1) = yst;

drop_centre = xst + 0.9;


for i=1:10000
    Abot = zeros(N,1);
    Abot(floor(drop_centre*(N-1)/L)+1-(N-1)/L:floor(drop_centre*(N-1)/L)+1+(N-1)/L)=-1;
    Atop = zeros(N,1);

    % solve BEM equations
    c = laplace_BEM_2d(N,L,H,Abot,Atop,8);
    [ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 0);
    f = stokes_BEM_2d(N,L,H,ubot,utop);
    %compute movement of particle
    [ux,uy] = flow_point(xtraj(i), ytraj(i), N,L,H, f, ubot, utop);
    xtraj(i+1) = xtraj(i) + ux*dt;
    ytraj(i+1) = ytraj(i) + uy*dt;
    if drop_centre < L-1.1
        drop_centre = drop_centre + ux*dt;
    else 
        drop_centre = L-1.1;
    end
    time = time+dt;
    if xtraj(i+1)>xend
        break
    end
end


end