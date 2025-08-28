function [xtraj,ytraj] = traj_brown_two(N,L,H, xst,yst, tend, dt,D)

Nt = tend/dt;
% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1;
Abot(0.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
[c, ~] = laplace_BEM_2d(N,L,H,Abot,Atop);
[ubot, utop] = u_slip(c,N,L,  [1 1], 0);
f = stokes_BEM_2d(N,L,H,ubot,utop);

xtraj(1) = xst;
ytraj(1) = yst;

% First iteration Forward-Euler
for i=2:Nt+1
    [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f, ubot, utop);

     x = xtraj(i-1) + (ux1)*dt+ sqrt(2*D)*randn(1)*dt;
    y = ytraj(i-1) + (uy1)*dt+ sqrt(2*D)*randn(1)*dt;
    if (y<0)
        break
    end
    if (x<0)
        break
    end
    if (x>L)
        break
    end
    if (y>H)
        break
    end
    xtraj(i) = x;
    ytraj(i) = y;
end

end
