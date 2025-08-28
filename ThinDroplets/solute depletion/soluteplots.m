%%
load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/Pe4.mat','crec','frec')
%save('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/solute depletion/MAT/Pe10.mat','crec10','frec10')

%%
surf(linspace(0,5,Nx),linspace(0,2,Ny),crec(:,:,16),'EdgeColor','none')
shading interp
view(2)
axis equal off
clim([0.6878 1])
exportgraphics(gca,"/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/deplete3.png", 'Resolution', 600)

%%
surf(linspace(0,5,Nx),linspace(0,2,Ny),crec(:,:,32),'EdgeColor','none')
shading interp
view(2)
axis equal off
clim([0.6878 1])
exportgraphics(gca,"/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/deplete6.png", 'Resolution', 600)

%%
surf(linspace(0,5,Nx),linspace(0,2,Ny),crec(:,:,48),'EdgeColor','none')
shading interp
view(2)
axis equal off
clim([0.6878 1])
exportgraphics(gca,"/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/deplete9.png", 'Resolution', 600)
%%
ubot = u_slip_alt(crec(:,:,16),N,L,Abot);
%%
[xtraj,ytraj] = trajectory1(N,L,H, 2.7,0.5, frec(:,:,16), ubot, 1000, 0.05);
[xtraj2,ytraj2] = trajectory1(N,L,H, 2.3,0.5, frec(:,:,16), ubot, 1000, 0.05);
[xtraj3,ytraj3] = trajectory1(N,L,H, 2.9,0.5, frec(:,:,16), ubot, 1000, 0.05);
[xtraj4,ytraj4] = trajectory1(N,L,H, 2.1,0.5, frec(:,:,16), ubot, 1000, 0.05);
[xtraj5,ytraj5] = trajectory1(N,L,H, 2.6,0.5, frec(:,:,16), ubot, 1000, 0.05);
[xtraj6,ytraj6] = trajectory1(N,L,H, 2.4,0.5, frec(:,:,16), ubot, 1000, 0.05);
%%
[xtraj,ytraj] = cleandata(xtraj,ytraj,0.01);
[xtraj2,ytraj2] = cleandata(xtraj2,ytraj2,0.01);
[xtraj3,ytraj3] = cleandata(xtraj3,ytraj3,0.01);
[xtraj4,ytraj4] = cleandata(xtraj4,ytraj4,0.01);
[xtraj5,ytraj5] = cleandata(xtraj5,ytraj5,0.01);
[xtraj6,ytraj6] = cleandata(xtraj6,ytraj6,0.01);
%%
plot(xtraj,ytraj,'k')
hold on 
plot(xtraj2,ytraj2,'k')
plot(xtraj3,ytraj3,'k')
plot(xtraj4,ytraj4,'k')
plot(xtraj5,ytraj5,'k')
plot(xtraj6,ytraj6,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/deplete3.tex')
%%
ubot = u_slip_alt(crec(:,:,32),N,L,Abot);
%%
[xtraj,ytraj] = trajectory1(N,L,H, 2.7,0.5, frec(:,:,32), ubot, 1000, 0.05);
[xtraj2,ytraj2] = trajectory1(N,L,H, 2.3,0.5, frec(:,:,32), ubot, 1000, 0.05);
[xtraj3,ytraj3] = trajectory1(N,L,H, 2.9,0.5, frec(:,:,32), ubot, 1000, 0.05);
[xtraj4,ytraj4] = trajectory1(N,L,H, 2.1,0.5, frec(:,:,32), ubot, 1000, 0.05);
[xtraj5,ytraj5] = trajectory1(N,L,H, 2.6,0.5, frec(:,:,32), ubot, 1000, 0.05);
[xtraj6,ytraj6] = trajectory1(N,L,H, 2.4,0.5, frec(:,:,32), ubot, 1000, 0.05);
%%
[xtraj,ytraj] = cleandata(xtraj,ytraj,0.01);
[xtraj2,ytraj2] = cleandata(xtraj2,ytraj2,0.01);
[xtraj3,ytraj3] = cleandata(xtraj3,ytraj3,0.01);
[xtraj4,ytraj4] = cleandata(xtraj4,ytraj4,0.01);
[xtraj5,ytraj5] = cleandata(xtraj5,ytraj5,0.01);
[xtraj6,ytraj6] = cleandata(xtraj6,ytraj6,0.01);
%%
figure
plot(xtraj,ytraj,'k')
hold on 
plot(xtraj2,ytraj2,'k')
plot(xtraj3,ytraj3,'k')
plot(xtraj4,ytraj4,'k')
plot(xtraj5,ytraj5,'k')
plot(xtraj6,ytraj6,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/deplete6.tex')
%%
ubot = u_slip_alt(crec(:,:,48),N,L,Abot);
%%
[xtraj,ytraj] = trajectory1(N,L,H, 2.7,0.5, frec(:,:,48), ubot, 1000, 0.05);
[xtraj2,ytraj2] = trajectory1(N,L,H, 2.3,0.5, frec(:,:,48), ubot, 1000, 0.05);
[xtraj3,ytraj3] = trajectory1(N,L,H, 2.9,0.5, frec(:,:,48), ubot, 1000, 0.05);
[xtraj4,ytraj4] = trajectory1(N,L,H, 2.1,0.5, frec(:,:,48), ubot, 1000, 0.05);
[xtraj5,ytraj5] = trajectory1(N,L,H, 2.6,0.5, frec(:,:,48), ubot, 1000, 0.05);
[xtraj6,ytraj6] = trajectory1(N,L,H, 2.4,0.5, frec(:,:,48), ubot, 1000, 0.05);
%%
[xtraj,ytraj] = cleandata(xtraj,ytraj,0.01);
[xtraj2,ytraj2] = cleandata(xtraj2,ytraj2,0.01);
[xtraj3,ytraj3] = cleandata(xtraj3,ytraj3,0.01);
[xtraj4,ytraj4] = cleandata(xtraj4,ytraj4,0.01);
[xtraj5,ytraj5] = cleandata(xtraj5,ytraj5,0.01);
[xtraj6,ytraj6] = cleandata(xtraj6,ytraj6,0.01);
%%
figure
plot(xtraj,ytraj,'k')
hold on 
plot(xtraj2,ytraj2,'k')
plot(xtraj3,ytraj3,'k')
plot(xtraj4,ytraj4,'k')
plot(xtraj5,ytraj5,'k')
plot(xtraj6,ytraj6,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/deplete9.tex')


