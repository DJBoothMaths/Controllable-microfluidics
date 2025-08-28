function [xtraj,ytraj] = traj_brown(N,L,H, xst,yst, f, ubot, utop, tend, dt,D)

Nt = tend/dt;

xtraj(1) = xst;
ytraj(1) = yst;

% First iteration Forward-Euler
for i=2:Nt+1
    [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f, ubot, utop);
    xtraj(i) = xtraj(i-1) + (ux1)*dt+ sqrt(2*D*dt)*randn(1);
    ytraj(i) = ytraj(i-1) + (uy1)*dt+ sqrt(2*D*dt)*randn(1);
    if (ytraj(i)<0)
        break
    end
    if (xtraj(i)<0)
        break
    end
    if (xtraj(i)>L)
        break
    end

end

end
