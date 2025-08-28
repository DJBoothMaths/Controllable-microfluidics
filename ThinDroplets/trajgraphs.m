%%
N=201;
L=10;
H=3;

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);

int1 = conc_interior(c,dcdn,N,L,H);
%%
% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);

int2 = conc_interior(c,dcdn,N,L,H);
%%

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);

int3 = conc_interior(c,dcdn,N,L,H);

%%
[time, xtraj_test, ytraj_test] =  particle_trans_discrete_inter(1,1,6, 10, 3,19,0.01,2001,1);

[xt1,yt1] = cleandata(xtraj_test(1:1900),ytraj_test(1:1900),0.01);
[xt2,yt2] = cleandata(xtraj_test(1901:3800),ytraj_test(1901:3800),0.01);
[xt3,yt3] = cleandata( xtraj_test(3800:end),ytraj_test(3800:end),0.01);

%%
figure
% plot3(xt1,yt1, 50*ones(length(xt1),1),'k','LineWidth',1.5)
% hold on
surf(linspace(0,L,N),linspace(0,H,N),int1,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colormap(colorcet('Gouldian'))
hold off
axis off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bot1.png', 'Resolution', 600)
%%

figure
% plot3(xt1,yt1, 50*ones(length(xt1),1),'r','LineWidth',1.5)
% hold on
%plot3(xt2,yt2, 50*ones(length(xt2),1),'k','LineWidth',1.5)
surf(linspace(0,L,N),linspace(0,H,N),int2,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colormap(colorcet('Gouldian'))
hold off
axis off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bot2.png', 'Resolution', 600)
%%
figure
% plot3(xt1,yt1, 50*ones(length(xt1),1),'r','LineWidth',1.5)
% hold on 
% plot3(xt2,yt2, 50*ones(length(xt2),1),'r','LineWidth',1.5)
%plot3(xt3(1:19*40),yt3(1:19*40), 50*ones(length(xt3(1:19*40)),1),'k','LineWidth',3)
surf(linspace(0,L,N),linspace(0,H,N),int3,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colormap(colorcet('Gouldian'))
hold off
axis off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bot3.png', 'Resolution', 600)
%%
figure
plot(xt1,yt1,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bot1.tex')
%%
figure
plot(xt1,yt1,'r')
hold on
plot(xt2,yt2,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bot2.tex')
%%
figure
plot(xt1,yt1,'r')
hold on
plot(xt2,yt2,'r')
plot(xt3,yt3,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bot3.tex')
