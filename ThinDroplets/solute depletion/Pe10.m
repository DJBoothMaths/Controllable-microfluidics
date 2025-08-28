%%
 figure
 inter = round(1/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec10(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
 clim([0 1])
  axis off
colormap(colorcet('Gouldian'))
%colorbar
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete101.png','Resolution',600)
  %%
   figure
 inter = round(5/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec10(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
 clim([0 1])
 axis off
 colormap(colorcet('Gouldian'))
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete105.png','Resolution',600)
 
%%
 figure
 inter = round(10/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec10(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
 clim([0 1])
 colormap(colorcet('Gouldian'))
 axis off
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete1010.png','Resolution',600)
 
 %%
 figure
 inter = round(20/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec10(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
 clim([0 1])
  axis off
 colormap(colorcet('Gouldian'))
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete1020.png','Resolution',600)
 
 %%
  figure
 inter = round(50/dt4);
 surf(linspace(0,5,Nx),linspace(0,2,Ny),crec10(:,:,inter),'EdgeColor','None')
 shading interp
 view(2)
 clim([0 1])
  axis off
  colormap(colorcet('Gouldian'))
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/deplete1050.png','Resolution',600)
 %%
 inter = round(10/dt4);
 [x,y] = traj(2.7,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x2,y2] = traj(2.3,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x3,y3] = traj(2.9,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x4,y4] = traj(2.1,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x5,y5] = traj(1.9,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x6,y6] = traj(3.1,1,0.05,200,crec10,inter,L,H,Nx,Abot);
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
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/traj101.tex')
 
%%
 inter = round(5/dt4);
 [x,y] = traj(2.7,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x2,y2] = traj(2.3,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x3,y3] = traj(2.9,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x4,y4] = traj(2.1,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x5,y5] = traj(1.9,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x6,y6] = traj(3.1,1,0.05,200,crec10,inter,L,H,Nx,Abot);
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
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/traj105.tex')
 %%
 inter = round(10/dt4);
 [x,y] = traj(2.7,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x2,y2] = traj(2.3,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x3,y3] = traj(2.9,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x4,y4] = traj(2.1,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x5,y5] = traj(1.9,1,0.05,200,crec10,inter,L,H,Nx,Abot);
 [x6,y6] = traj(3.1,1,0.05,200,crec10,inter,L,H,Nx,Abot);
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
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/traj1010.tex')
 %%
 inter = round(20/dt4);
 %%
 [x,y] = traj(2.7,1,0.05,500,crec10,inter,L,H,Nx,Abot);
 %%
 [x2,y2] = traj(2.3,1,0.05,500,crec10,inter,L,H,Nx,Abot);
 [x3,y3] = traj(2.9,1,0.05,500,crec10,inter,L,H,Nx,Abot);
 [x4,y4] = traj(2.1,1,0.05,500,crec10,inter,L,H,Nx,Abot);
 [x5,y5] = traj(1.9,1,0.05,500,crec10,inter,L,H,Nx,Abot);
 [x6,y6] = traj(3.1,1,0.05,500,crec10,inter,L,H,Nx,Abot);
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
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/traj1020.tex')
 %%
 inter = round(50/dt4);
 [x,y] = traj(2.7,1,0.05,700,crec10,inter,L,H,Nx,Abot);
 [x2,y2] = traj(2.3,1,0.05,700,crec10,inter,L,H,Nx,Abot);
 [x3,y3] = traj(2.9,1,0.05,500,crec10,inter,L,H,Nx,Abot);
 [x4,y4] = traj(2.1,1,0.05,500,crec10,inter,L,H,Nx,Abot);
 [x5,y5] = traj(1.9,1,0.05,500,crec10,inter,L,H,Nx,Abot);
 [x6,y6] = traj(3.1,1,0.05,500,crec10,inter,L,H,Nx,Abot);
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
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/tikz/traj1050.tex')
 %%
 inter1 = round(1/dt10);
 inter5 = round(5/dt10);
 inter10 = round(10/dt10);
 inter20 = round(20/dt10);
 inter50 = round(50/dt10);
 %%
 figure
 plot(linspace(0,5,Nx),crec10(1,:,inter1))
 hold on
 plot(linspace(0,5,Nx),crec10(1,:,inter5))
 plot(linspace(0,5,Nx),crec10(1,:,inter10))
 plot(linspace(0,5,Nx),crec10(1,:,inter20))
 plot(linspace(0,5,Nx),crec10(1,:,inter50))
  %%
 figure
 plot(linspace(0,5,Nx),crec10(1,:,inter1)/max(crec10(1,:,inter1)))
 hold on
 plot(linspace(0,5,Nx),crec10(1,:,inter5)/max(crec10(1,:,inter5)))
 plot(linspace(0,5,Nx),crec10(1,:,inter10)/max(crec10(1,:,inter10)))
 plot(linspace(0,5,Nx),crec10(1,:,inter20)/max(crec10(1,:,inter20)))
 plot(linspace(0,5,Nx),crec10(1,:,inter50)/max(crec10(1,:,inter50)))
