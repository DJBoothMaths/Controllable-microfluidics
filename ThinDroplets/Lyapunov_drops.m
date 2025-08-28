function lambda = Lyapunov_drops(x0, deltax0, T,N,L,H, dt,D,Ndrops)
if Ndrops ==1
    [xtraj,ytraj] = traj_brown_one(N,L,H, x0(1),x0(2),T, dt,D);
    [xtraj1,ytraj1] = traj_brown_one(N,L,H,  x0(1)+deltax0(1),x0(2)+deltax0(2), T, dt,D);
elseif Ndrops ==2 
    [xtraj,ytraj] = traj_brown_two(N,L,H, x0(1),x0(2),T, dt,D);
    [xtraj1,ytraj1] = traj_brown_two(N,L,H,  x0(1)+deltax0(1),x0(2)+deltax0(2), T, dt,D);
end


deltaxtraj = xtraj(end)-xtraj1(end);
deltaytraj = ytraj(end)-ytraj1(end);

lambda = (1/T)*log(norm([deltaxtraj deltaytraj])/norm(deltax0));

end 