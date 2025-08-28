%% Initialise
L=5;
H=2;
dx=0.1;
Nx = L/dx+1;
Ny = H/dx+1;
dt4 = 10*0.75*dx^2;
dt10 = 5*0.75*10/4*dx^2;
N=Nx-1;
Abot = zeros(Nx,1);
Abot(floor(0.5*(Nx))-floor((Nx)/L)+1:ceil(0.5*(Nx))+floor((Nx)/L))=1;

load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/DepleteDa1.mat','crec4','crec10')
load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/DepleteDa2.mat','crec42','crec102')
load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/DepleteFF.mat','crec41','crec101')

%%
 figure
 plot(linspace(0,5,Nx),crec4(1,:,inter1))
 hold on
 plot(linspace(0,5,Nx),crec4(1,:,inter5))
 plot(linspace(0,5,Nx),crec4(1,:,inter10))
 plot(linspace(0,5,Nx),crec4(1,:,inter20))
 plot(linspace(0,5,Nx),crec4(1,:,inter50))
 axis off
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/sim1.tex')
  %%
 figure
 plot(linspace(0,5,Nx),crec4(1,:,inter1)/max(crec4(1,:,inter1)))
 hold on
 plot(linspace(0,5,Nx),crec4(1,:,inter5)/max(crec4(1,:,inter5)))
 plot(linspace(0,5,Nx),crec4(1,:,inter10)/max(crec4(1,:,inter10)))
 plot(linspace(0,5,Nx),crec4(1,:,inter20)/max(crec4(1,:,inter20)))
 plot(linspace(0,5,Nx),crec4(1,:,inter50)/max(crec4(1,:,inter50)))
 axis off
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/sim2.tex')
 %%
 inter = round(1/dt4);
 [x,y] = traj(2.7,1,0.05,200,crec4,inter,L,H,Nx,Abot);
 [x2,y2] = traj(2.3,1,0.05,200,crec4,inter,L,H,Nx,Abot);
 [x3,y3] = traj(2.9,1,0.05,200,crec4,inter,L,H,Nx,Abot);
 [x4,y4] = traj(2.1,1,0.05,200,crec4,inter,L,H,Nx,Abot);
 [x5,y5] = traj(1.9,1,0.05,200,crec4,inter,L,H,Nx,Abot);
 [x6,y6] = traj(3.1,1,0.05,200,crec4,inter,L,H,Nx,Abot);
 %%
 [x,y]=cleandata(x,y,0.01);
 [x2,y2]=cleandata(x2,y2,0.01);
 [x3,y3]=cleandata(x3,y3,0.01);
 [x4,y4]=cleandata(x4,y4,0.01);
 [x5,y5]=cleandata(x5,y5,0.01);
 [x6,y6]=cleandata(x6,y6,0.01);
 %%
 figure
 plot(x,y,'k')
 hold on
 plot(x2,y2,'k')
 plot(x3,y3,'k')
 plot(x4,y4,'k')
 plot(x5,y5,'k')
 plot(x6,y6,'k')
 axis off 
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/traj1.tex')
 
 %%
 figure
 inter = round(1/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec4(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
  colormap(colorcet('Gouldian'))
clim([0 1])
axis off
%colorbar
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete1.png','Resolution',600)
  %%
   figure
 inter = round(5/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec4(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
 clim([0 1])
colormap(colorcet('Gouldian'))
 axis off
 
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete5.png','Resolution',600)
 
%%
 figure
 inter = round(10/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec4(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
 clim([0 1])
 axis off
 colormap(colorcet('Gouldian'))
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete10.png','Resolution',600)
 
 %%
 figure
 inter = round(20/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec4(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
  clim([0 1])
  axis off
  colormap(colorcet('Gouldian'))
 %clim([0 1])
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete20.png','Resolution',600)
 
 %%
  figure
 inter = round(50/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec4(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
  clim([0 1])
  axis off
  colormap(colorcet('Gouldian'))
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete50.png','Resolution',600)
 

