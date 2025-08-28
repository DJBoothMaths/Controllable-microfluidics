%%
L=5;
H=2;
dx=0.1;
Nx = L/dx+1;
Ny = H/dx+1;
N=Nx-1;
Abot = zeros(Nx,1);
Abot(floor(0.5*(Nx))-floor((Nx)/L)+1:ceil(0.5*(Nx))+floor((Nx)/L))=1;
Abot1 = zeros(4*N,1);
Abot1(floor(0.5*(4*N-1))+1-floor((4*N-1)/L):ceil(0.5*(4*N-1))+1+floor((4*N-1)/L))=-1;
%% Da = 1
crec4 = Deplete(dx, L, H,Abot, 100, 4,1,10,1);
crec10 = Deplete(dx, L, H,Abot, 100, 10,1,5,1);
%% Da = 2
crec42 = Deplete(dx, L, H,Abot, 100, 4,2,10,1);
crec102 = Deplete(dx, L, H,Abot, 100, 10,2,5,1);
%% Fixed flux
crec41 = Deplete(dx, L, H,Abot, 100, 4,2,10,2);
crec101 = Deplete(dx, L, H,Abot, 100, 10,2,5,2);
%%
save('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/DepleteDa1.mat','crec4','crec10')
save('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/DepleteDa2.mat','crec42','crec102')
%%
 save('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/DepleteFF.mat','crec41','crec101')
 %%
 figure
surf(linspace(0,5,Nx),linspace(0,2,Ny),crec41(:,:,end),'EdgeColor','none')
shading interp
view(2)
axis equal off
clim([0 1])
%exportgraphics(gca,"/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/deplete3.png", 'Resolution', 600)
%%
dt4 = 10*0.75*dx^2;
dt10 = 5*0.75*10/4*dx^2;