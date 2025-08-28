function [xtraj,ytraj] = trajectory(N,L,H, xst,yst, f, ubot, utop, tend, dt)

Nt = tend/dt;


xtraj = zeros(Nt+1,1);
ytraj = zeros(Nt+1,1);

xtraj(1) = xst;
ytraj(1) = yst;
[elmx, elmy, ~] = disc_rect(N,L,H);

U = [ubot; zeros(N,1); flip(utop); zeros(N,1)];


for i=2:Nt+1
    [ux,uy]=
    xtraj(i) = xtraj(i-1) + ux*dt;
    ytraj(i) = ytraj(i-1) + uy*dt;
end





end
