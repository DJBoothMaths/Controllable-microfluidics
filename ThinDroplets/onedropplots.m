%% Test BEM Solver
N = 201; % points per edge
L = 10; % length of domain
H = 3; % height of domain

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);
%[c2, dcdn2] = laplace_BEM_2d(N,L,H,Abot,Atop,20);

%max(abs(c1-c2))
%% Interior points
int = conc_interior(c,dcdn,N,L,H);

%%
[ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 0);
%[ubot, utop] = u_slip(c,N,L,  [1 1], 0);
figure
plot(linspace(-L/2,L/2,N),ubot)
hold on 
xlim([-1 1])
%plot(linspace(0,L,N),utop)
hold off
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/uthin.tex')
%%
f = stokes_BEM_2d(N,L,H,ubot,utop);
%%
tend = 100;
dt = 0.01;
[xtraj,ytraj] = trajectory1(N,L,H, 5.3,1, f, ubot, utop, tend, dt);
%%
tend = 100;
dt = 0.01;
[xtraj2,ytraj2] = trajectory1(N,L,H, 4.7,1, f, ubot, utop, tend, dt);
%%
tend = 250;
dt = 0.02;
[xtraj3,ytraj3] = trajectory1(N,L,H, 5.1,1, f, ubot, utop, tend, dt);
%%
tend = 250;
dt = 0.02;
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

[xtraj,ytraj] = cleandata(xtraj,ytraj,0.01);
[xtraj2,ytraj2] = cleandata(xtraj2,ytraj2,0.01);
[xtraj3,ytraj3] = cleandata(xtraj3,ytraj3,0.01);
[xtraj4,ytraj4] = cleandata(xtraj4,ytraj4,0.01);
[xtraj5,ytraj5] = cleandata(xtraj5,ytraj5,0.01);
[xtraj6,ytraj6] = cleandata(xtraj6,ytraj6,0.01);
%%
figure
% plot3(xtraj,ytraj,50*ones(length(xtraj),1),'k','LineWidth',1.3)
% hold on 
% plot3(xtraj2,ytraj2,50*ones(length(xtraj),1),'k','LineWidth',1.3)
% plot3(xtraj3,ytraj3,50*ones(length(xtraj3),1),'k','LineWidth',1.3)
% plot3(xtraj4,ytraj4,50*ones(length(xtraj4),1),'k','LineWidth',1.3)
% plot3(xtraj5,ytraj5,50*ones(length(xtraj5),1),'k','LineWidth',1.3)
% plot3(xtraj6,ytraj6,50*ones(length(xtraj6),1),'k','LineWidth',1.3)
 surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')
 view(2)
% shading interp
% daspect([1 1 1])
% %colorbar
% hold off
axis off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/onedrop.png', 'Resolution', 600)
%%
plot(xtraj,ytraj,'k')
hold on 
plot(xtraj2,ytraj2,'k')
plot(xtraj3,ytraj3,'k')
plot(xtraj4,ytraj4,'k')
plot(xtraj5,ytraj5,'k')
plot(xtraj6,ytraj6,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/onedrop.tex')
