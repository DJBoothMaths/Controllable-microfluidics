function [x,y] = traj(xst,yst,dt,Tend,c,inter,L,H,Nx,Abot,opt)
if opt==1
ubot = u_slip_alt(c(1,:,inter),Nx,L,Abot);
else 
    ubot = u_slip_alt(c(1,:),Nx,L,Abot);
end
uboti = interp1(0:0.1:5,ubot,0.0125:0.025:4.9875,'linear');
uboti(1:60)=0;
uboti(end-59:end)=0;
 f=stokes_BEM_2d(length(uboti),L,H,uboti);
[x,y] = trajectory1(length(uboti),L,H,xst,yst, f, uboti', Tend, dt);

end