%%
 [x,y] = traj(2.7,1,0.05,200,crec10,331,L,H,Nx,Abot,1);
 [x2,y2] = traj(2.3,1,0.05,200,crec10,331,L,H,Nx,Abot,1);
 [x3,y3] = traj(2.9,1,0.05,200,crec10,331,L,H,Nx,Abot,1);
 [x4,y4] = traj(2.1,1,0.05,200,crec10,331,L,H,Nx,Abot,1);
 [x5,y5] = traj(1.9,1,0.05,200,crec10,331,L,H,Nx,Abot,1);
 [x6,y6] = traj(3.1,1,0.05,200,crec10,331,L,H,Nx,Abot,1);
 %%
 [x,y]=cleandata(x,y,0.01);
 [x2,y2]=cleandata(x2,y2,0.01);
 [x3,y3]=cleandata(x3,y3,0.01);
 [x4,y4]=cleandata(x4,y4,0.01);
 [x5,y5]=cleandata(x5,y5,0.01);
 [x6,y6]=cleandata(x6,y6,0.01);
 %%
 figure
 plot(x(1:400),y(1:400),'k')
 hold on
 plot(x2(1:400),y2(1:400),'k')
 plot(x3(1:400),y3(1:400),'k')
 plot(x4(1:400),y4(1:400),'k')
 plot(x5(1:400),y5(1:400),'k')
 plot(x6(1:400),y6(1:400),'k')
 axis off 
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/trajPe10.tex')
 
%%
 [x,y] = traj(2.7,1,0.05,200,crec,226,L,H,Nx,Abot,1);
 [x2,y2] = traj(2.3,1,0.05,200,crec,226,L,H,Nx,Abot,1);
 [x3,y3] = traj(2.9,1,0.05,200,crec,226,L,H,Nx,Abot,1);
 [x4,y4] = traj(2.1,1,0.05,200,crec,226,L,H,Nx,Abot,1);
 [x5,y5] = traj(1.9,1,0.05,200,crec,226,L,H,Nx,Abot,1);
 [x6,y6] = traj(3.1,1,0.05,200,crec,226,L,H,Nx,Abot,1);
 %%
 [x,y]=cleandata(x,y,0.01);
 [x2,y2]=cleandata(x2,y2,0.01);
 [x3,y3]=cleandata(x3,y3,0.01);
 [x4,y4]=cleandata(x4,y4,0.01);
 [x5,y5]=cleandata(x5,y5,0.01);
 [x6,y6]=cleandata(x6,y6,0.01);
 %%
 figure
 plot(x(1:400),y(1:400),'k')
 hold on
 plot(x2(1:400),y2(1:400),'k')
 plot(x3(1:400),y3(1:400),'k')
 plot(x4(1:400),y4(1:400),'k')
 plot(x5(1:400),y5(1:400),'k')
 plot(x6(1:400),y6(1:400),'k')
 axis off 
 matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/trajPe4.tex')
 %%
 figure
 surf(linspace(0,5,51),linspace(0,2,21),crec10(:,:,end),'EdgeColor','none')
 view(2)
 shading interp
 colormap(colorcet('Gouldian'))
 axis off 
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/Pe10.png','Resolution',600)
  