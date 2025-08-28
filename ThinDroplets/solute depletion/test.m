dx=0.1;
L=5;
H=2;
Nx=L/dx+1;
Ny=H/dx+1;
ubot = zeros(L/dx+1,1);
ubot(6:30)=1;
%%
tic
[u,v,uint,vint] = MAC_Stokes(dx, L, H, ubot);
toc
%%
A(Nx*(Ny-1):Nx*(Ny-1)+1,Nx*(Ny-1):Nx*(Ny-1)+1)
%%
figure
surf(linspace(0,5,Nx),linspace(0,2,Ny),uint)
clim([-1 1])
%shading interp
%%
figure
surf(linspace(0.025,5-0.025,100),linspace(0.,2,41),v)
%shading interp
view(2)
clim([-0.4 0.4])
%%
ubot = zeros(L/dx,1);
ubot(6:29)=1;
%f = stokes_BEM_2d(L/dx,L,H,ubot);
%%
tic
f = stokes_BEM_2d(L/dx,L,H,ubot);
[U,V] = flow_int(dx,L,H, f, ubot);
toc
%%
figure
surf(linspace(0,5,51),linspace(0,2,21),U-uint)
clim([-.1 .1])
%%
figure
surf(linspace(0,5,101),linspace(0,2,41),V)
clim([-0.4 0.4])
%%
L=5;
H=2;
dx=0.1;
Nx = L/dx+1;
Ny = H/dx+1;
N=Nx-1;
Abot = zeros(Nx,1);
Abot(floor(0.5*(Nx))-floor((Nx)/L)+1:ceil(0.5*(Nx))+floor((Nx)/L))=-1;
Abot1 = zeros(4*N,1);
Abot1(floor(0.5*(4*N-1))+1-floor((4*N-1)/L):ceil(0.5*(4*N-1))+1+floor((4*N-1)/L))=-1;
%%
crec4 = Deplete(dx, L, H,Abot, 300, 4,10,1,10,1);
crec10 = Deplete(dx, L, H,Abot, 300, 10,1,5,1);
%crec1 = Deplete(dx, L, H,Abot, 30, 1,5);
%%
surf(linspace(0,5,Nx),linspace(0,2,Ny),crec10(:,:,end),'EdgeColor','none')
shading interp
view(2)
%clim([0 1])
colorbar
%%
ubot = u_slip_alt(crec10(1,:,end),Nx,L,Abot);
[u,v]=MAC_Stokes(dx,L,H,ubot);
%%
cbound =zeros(N,1);
ii = 1:N;
cbound(ii)= (crec10(1,ii,100)+crec10(1,ii+1,100))/2;
cinter = interp1(0.05:0.1:4.95,cbound,0.0125:0.025:4.9875,'cubic');
ubot1 = u_slip_alt(cinter,4*N,L,Abot1);
f=stokes_BEM_2d(4*N,L,H,ubot1);
[U,V] = flow_int(0.05,L,H, f, ubot1);
%jj=1:2*N;
%U(1,jj)=ubot(jj);
%%
surf(linspace(0,5,2*N+1),linspace(0,2,41),U,'EdgeColor','none')
shading interp
%%
plot(crec10(1,:,100))
%%
save('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/Deplete.mat','crec4','crec10')
%%
figure
plot(linspace(0,5,Nx),ubot)
hold on 
plot(linspace(0.0125,4.9875,4*N),ubot1)
%%
figure
plot(linspace(0.05,4.95,N),cbound)
hold on 
plot(linspace(0.0125,4.9875,4*N),cinter)