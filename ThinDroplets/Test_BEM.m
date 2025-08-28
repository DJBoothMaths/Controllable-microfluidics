%% Test BEM Solver
N = 200; % points per edge
L = 10; % length of domain
H = 3; % height of domain

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*N-N/L:0.5*N+N/L)=-1;
Atop = zeros(N,1);
%Atop(.3*N-N/L:0.3*N+N/L)=-1;
%Atop(0.7*N-N/L:0.7*N+N/L)=-1;

[elmx,elmy,midx,midy] = disc_rect(N,L,H)
plot(elmx(:,1),elmy(:,1),'-o')
 hold on
 plot(elmx(:,2),elmy(:,2),'-o')
 
 plot(midx(:,1),midy(:,1),'-x')
 axis([-0.5 L+0.5 -0.5 H+0.5])
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
figure
surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')
shading interp
view(2)
daspect([1 1 1])
colorbar
%%
[ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 0);
%[ubot, utop] = u_slip(c,N,L,  [1 1], 0);
figure
plot(linspace(0,L,N),ubot)
hold on 
plot(linspace(0,L,N),utop)
hold off
%%
[f] = stokes_BEM_2d(N,L,H,ubot,utop);
%%
figure
plot(linspace(0,L,N),f(1:N,1))
figure
plot(linspace(0,H,N),flip(f(N+1:2*N,1)))
%%
tend = 100;
dt = 0.01;
[xtraj,ytraj] = trajectory1(N,L,H, 5.3,1, f, ubot, utop, tend, dt);
%%
tend = 100;
dt = 0.01;
[xtraj2,ytraj2] = trajectory1(N,L,H, 4.7,1, f, ubot, utop, tend, dt);
%%
tend = 100;
dt = 0.01;
[xtraj3,ytraj3] = trajectory1(N,L,H, 5.1,1, f, ubot, utop, tend, dt);
%%
tend = 100;
dt = 0.01;
[xtraj4,ytraj4] = trajectory1(N,L,H, 4.9,1, f, ubot, utop, tend, dt);
%%
tend = 100;
dt = 0.01;
[xtraj5,ytraj5] = trajectory1(N,L,H, 5.9,1, f, ubot, utop, tend, dt);
%%
tend = 100;
dt = 0.01;
[xtraj6,ytraj6] = trajectory1(N,L,H, 4.1,1, f, ubot, utop, tend, dt);
%%
figure
plot3(xtraj,ytraj,50*ones(length(xtraj),1),'k')
hold on 
plot3(xtraj2,ytraj2,50*ones(length(xtraj2),1),'k')
plot3(xtraj3,ytraj3,50*ones(length(xtraj3),1),'k')
plot3(xtraj4,ytraj4,50*ones(length(xtraj4),1),'k')
plot3(xtraj5,ytraj5,50*ones(length(xtraj5),1),'k')
plot3(xtraj6,ytraj6,50*ones(length(xtraj6),1),'k')
surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colorbar
hold off

%%
figure
plot(xtraj,ytraj,'k--')