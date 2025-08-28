%% Test BEM Solver
N = 201; % points per edge
L = 10; % length of domain
H = 3; % height of domain

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);
Atop(.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
Atop(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1;

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);

%%
figure
plot(linspace(0,L,N),c(1:N))
hold on 
plot(linspace(0,L,N),flip(c(2*N+1:3*N)))
hold off
%% Interior points
int = conc_interior(c,dcdn,N,L,H);
%%
[ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 1);
%[ubot, utop] = u_slip(c,N,L,  [1 1], 1);
figure
plot(linspace(0,L,N),ubot)
hold on 
plot(linspace(0,L,N),utop)
hold off
%%
f = stokes_BEM_2d(N,L,H,ubot,utop);
%%
tend = 50;
dt = 0.01;
[xtraj,ytraj] = trajectory1(N,L,H, 5.3,1, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj2,ytraj2] = trajectory1(N,L,H, 4.7,1, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj3,ytraj3] = trajectory1(N,L,H, 5.1,1, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj4,ytraj4] = trajectory1(N,L,H, 4.9,1, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj5,ytraj5] = trajectory1(N,L,H, 5.9,1, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj6,ytraj6] = trajectory1(N,L,H, 4.1,1, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj7,ytraj7] = trajectory1(N,L,H, 7.1,2.9, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj8,ytraj8] = trajectory1(N,L,H, 2.9,2.9, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj9,ytraj9] = trajectory1(N,L,H, 7.1,2.6, f, ubot, utop, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtraj10,ytraj10] = trajectory1(N,L,H, 2.9,2.6, f, ubot, utop, tend, dt);
%%
tend = 250;
dt = 0.005;
[xtraj11,ytraj11] = trajectory1(N,L,H, 4.7,2.5, f, ubot, utop, tend, dt);
%%
tend = 250;
dt = 0.005;
[xtraj12,ytraj12] = trajectory1(N,L,H, 5.3,2.5, f, ubot, utop, tend, dt);
%%
[xtraj,ytraj] = cleandata(xtraj,ytraj,0.01);
[xtraj2,ytraj2] = cleandata(xtraj2,ytraj2,0.01);
[xtraj3,ytraj3] = cleandata(xtraj3,ytraj3,0.01);
[xtraj4,ytraj4] = cleandata(xtraj4,ytraj4,0.01);
[xtraj5,ytraj5] = cleandata(xtraj5,ytraj5,0.01);
[xtraj6,ytraj6] = cleandata(xtraj6,ytraj6,0.01);
[xtraj7,ytraj7] = cleandata(xtraj7,ytraj7,0.01);
[xtraj8,ytraj8] = cleandata(xtraj8,ytraj8,0.01);
[xtraj9,ytraj9] = cleandata(xtraj9,ytraj9,0.01);
[xtraj10,ytraj10] = cleandata(xtraj10,ytraj10,0.01);
[xtraj11,ytraj11] = cleandata(xtraj11,ytraj11,0.01);
[xtraj12,ytraj12] = cleandata(xtraj12,ytraj12,0.01);
%%
figure
surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
axis off
colormap(colorcet('Gouldian'))
colorbar
%exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/threedrop.png', 'Resolution', 600)
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/threedropcm.tex')
%%
figure
plot(xtraj,ytraj,'k','LineWidth',1.3)
hold on 
plot(xtraj2,ytraj2,'k','LineWidth',1.3)
plot(xtraj3,ytraj3,'k','LineWidth',1.3)
plot(xtraj4,ytraj4,'k','LineWidth',1.3)
plot(xtraj5,ytraj5,'k','LineWidth',1.3)
plot(xtraj6,ytraj6,'k','LineWidth',1.3)
plot(xtraj7,ytraj7,'k','LineWidth',1.3)
plot(xtraj8,ytraj8,'k','LineWidth',1.3)
plot(xtraj9,ytraj9,'k','LineWidth',1.3)
plot(xtraj10,ytraj10,'k','LineWidth',1.3)
plot(xtraj11,ytraj11,'k','LineWidth',1.3)
plot(xtraj12,ytraj12,'k','LineWidth',1.3)
%surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')

axis off
matlab2tikz( '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/threedrop.tex')

% %% Test BEM Solver
% N = 201; % points per edge
% L = 10; % length of domain
% H = 3; % height of domain
% 
% % construct top and bottom boundary conditions
% Atop = zeros(N,1);
% Atop(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
% Abot = zeros(N,1);
% Abot(.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
% Abot(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1;
% 
% % solve BEM equations
% [c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);
% 
% %%
% figure
% plot(linspace(0,L,N),c(1:N))
% hold on 
% plot(linspace(0,L,N),flip(c(2*N+1:3*N)))
% hold off
% %% Interior points
% int = conc_interior(c,dcdn,N,L,H);
% %%
% [ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 1);
% %[ubot, utop] = u_slip(c,N,L,  [1 1], 1);
% figure
% plot(linspace(0,L,N),ubot)
% hold on 
% plot(linspace(0,L,N),utop)
% hold off
% %%
% f = stokes_BEM_2d(N,L,H,ubot,utop);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj,ytraj] = trajectory1(N,L,H, 5.3,3-1, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj2,ytraj2] = trajectory1(N,L,H, 4.7,3-1, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj3,ytraj3] = trajectory1(N,L,H, 5.1,3-1, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj4,ytraj4] = trajectory1(N,L,H, 4.9,3-1, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj5,ytraj5] = trajectory1(N,L,H, 5.9,3-1, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj6,ytraj6] = trajectory1(N,L,H, 4.1,3-1, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj7,ytraj7] = trajectory1(N,L,H, 7.1,3-2.9, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj8,ytraj8] = trajectory1(N,L,H, 2.9,3-2.9, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj9,ytraj9] = trajectory1(N,L,H, 7.1,3-2.6, f, ubot, utop, tend, dt);
% %%
% tend = 50;
% dt = 0.01;
% [xtraj10,ytraj10] = trajectory1(N,L,H, 2.9,3-2.6, f, ubot, utop, tend, dt);
% %%
% tend = 250;
% dt = 0.005;
% [xtraj11,ytraj11] = trajectory1(N,L,H, 4.7,3-2.5, f, ubot, utop, tend, dt);
% %%
% tend = 250;
% dt = 0.005;
% [xtraj12,ytraj12] = trajectory1(N,L,H, 5.3,3-2.5, f, ubot, utop, tend, dt);
% %%
% figure
% plot3(xtraj,ytraj,50*ones(length(xtraj),1),'k')
% hold on 
% plot3(xtraj2,ytraj2,50*ones(length(xtraj),1),'k')
% plot3(xtraj3,ytraj3,50*ones(length(xtraj3),1),'k')
% plot3(xtraj4,ytraj4,50*ones(length(xtraj4),1),'k')
% plot3(xtraj5,ytraj5,50*ones(length(xtraj5),1),'k')
% plot3(xtraj6,ytraj6,50*ones(length(xtraj6),1),'k')
% plot3(xtraj7,ytraj7,50*ones(length(xtraj7),1),'k')
% plot3(xtraj8,ytraj8,50*ones(length(xtraj8),1),'k')
% plot3(xtraj9,ytraj9,50*ones(length(xtraj9),1),'k')
% plot3(xtraj10,ytraj10,50*ones(length(xtraj10),1),'k')
% plot3(xtraj11,ytraj11,50*ones(length(xtraj11),1),'k')
% plot3(xtraj12,ytraj12,50*ones(length(xtraj12),1),'k')
% surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')
% view(2)
% shading interp
% daspect([1 1 1])
% hold off
% print('threedropmix2','-depsc','-painters')
% 
