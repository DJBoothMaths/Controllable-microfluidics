function [xtraj,ytraj] = trajectory1(N,L,H, xst,yst, f, ubot, tend, dt)

Nt = tend/dt;
% AdamsBashforth


xtraj(1) = xst;
ytraj(1) = yst;

% First iteration Forward-Euler
[ux,uy] = flow_point(xtraj(1), ytraj(1), N,L,H, f, ubot);
    xtraj(2) = xtraj(1) + ux*dt;
    ytraj(2) = ytraj(1) + uy*dt;
% 2nd order AdamsBashforth
for i=3:Nt+1
    [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f, ubot);
    [ux2,uy2] = flow_point(xtraj(i-2), ytraj(i-2), N,L,H, f, ubot);
    xtraj(i) = xtraj(i-1) + (3*ux1-ux2)*dt/2;
    ytraj(i) = ytraj(i-1) + (3*uy1-uy2)*dt/2;
    if norm([xtraj(i)-xtraj(1),ytraj(i)-ytraj(1)])<10^(-4)
        break
    end
end

end
