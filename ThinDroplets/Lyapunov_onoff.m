function lambda = Lyapunov_onoff(x0, deltax0, T,N,L,H, dt,D,tsep)

[xtraj,ytraj] = on_off_traj(N,L,H, x0(1),x0(2),T, dt,D,tsep);
[xtraj1,ytraj1] = on_off_traj(N,L,H,  x0(1)+deltax0(1),x0(2)+deltax0(2), T, dt,D,tsep);

deltaxtraj = xtraj(end)-xtraj1(end);
deltaytraj = ytraj(end)-ytraj1(end);

lambda = (1/T)*log(norm([deltaxtraj deltaytraj])/norm(deltax0));

end 