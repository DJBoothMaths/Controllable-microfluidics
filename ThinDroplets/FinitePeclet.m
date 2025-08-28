%% Test BEM Solver
N = 51; % points per edge
L = 10; % length of domain
H = 3; % height of domain

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
%[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,20);

plot(linspace(0,L,N),Abot)
%% Interior points
int = conc_interior(c,dcdn,N,L,H);
%%
[ubot, utop] = u_slip(c,N,L,  [1 1], 0);
f = stokes_BEM_2d(N,L,H,ubot,utop);
%%
[U,V] = flow_int(N,L,H, f, ubot, utop,N);
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
[cPe1,ubotPe1,utopPe1,f1] = advdiff(N, L, H, Abot, Atop, 1, 1, int);
%%
[cPe101,ubotPe10,utopPe10,f10] = advdiff(N, L, H, Abot, Atop,5, 10, cPe10);
%%
[cPe4,ubotPe4,utopPe4,f4] = advdiff(N, L, H, Abot, Atop, 1, 4, int);
%%
figure
surf(linspace(0,L,N),linspace(0,H,N),cPe1,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colorbar
%%
figure
surf(linspace(0,L,N),linspace(0,H,N),cPe4,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colorbar

%%
figure
surf(linspace(0,L,N),linspace(0,H,N),cPe10,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colorbar

%%
tend = 100;
dt = 0.01;
[xtrajPe,ytrajPe] = trajectory1(N,L,H, 5.3,1, f10, ubotPe10, utopPe10, tend, dt);
%%
tend = 100;
dt = 0.01;
[xtrajPe2,ytrajPe2] = trajectory1(N,L,H, 4.7,1, f10, ubotPe10, utopPe10, tend, dt);
%%
tend = 250;
dt = 0.02;
[xtrajPe3,ytrajPe3] = trajectory1(N,L,H, 5.1,1, f10, ubotPe10, utopPe10, tend, dt);
%%
tend = 250;
dt = 0.02;
[xtrajPe4,ytrajPe4] = trajectory1(N,L,H, 4.9,1, f10, ubotPe10, utopPe10, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtrajPe5,ytrajPe5] = trajectory1(N,L,H, 5.9,1, f10, ubotPe10, utopPe10, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtrajPe6,ytrajPe6] = trajectory1(N,L,H, 4.1,1, f10, ubotPe10, utopPe10, tend, dt);
%%
figure
tiledlayout(2,1)
nexttile
plot3(xtraj,ytraj,50*ones(length(xtraj),1),'k')
hold on 
plot3(xtraj2,ytraj2,50*ones(length(xtraj),1),'k')
plot3(xtraj3,ytraj3,50*ones(length(xtraj3),1),'k')
plot3(xtraj4,ytraj4,50*ones(length(xtraj4),1),'k')
plot3(xtraj5,ytraj5,50*ones(length(xtraj5),1),'k')
plot3(xtraj6,ytraj6,50*ones(length(xtraj6),1),'k')
surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')
hold off
view(2)
shading interp
daspect([1 1 1])
colorbar
nexttile
plot3(xtrajPe,ytrajPe,50*ones(length(xtrajPe),1),'k')
hold on 
plot3(xtrajPe2,ytrajPe2,50*ones(length(xtrajPe2),1),'k')
plot3(xtrajPe3,ytrajPe3,50*ones(length(xtrajPe3),1),'k')
plot3(xtrajPe4,ytrajPe4,50*ones(length(xtrajPe4),1),'k')
plot3(xtrajPe5,ytrajPe5,50*ones(length(xtrajPe5),1),'k')
plot3(xtrajPe6,ytrajPe6,50*ones(length(xtrajPe6),1),'k')
surf(linspace(0,L,N),linspace(0,H,N),cPe10,'edgecolor','none')
hold off
view(2)
shading interp
daspect([1 1 1])
colorbar
%%
figure
surf(linspace(0,L,N),linspace(0,H,N),log(abs(cPe10-int)),'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colorbar
%%
figure
plot3(xtrajPe,ytrajPe,50*ones(length(xtrajPe),1),'k')
hold on 
plot3(xtrajPe2,ytrajPe2,50*ones(length(xtrajPe2),1),'k')
plot3(xtrajPe3,ytrajPe3,50*ones(length(xtrajPe3),1),'k')
plot3(xtrajPe4,ytrajPe4,50*ones(length(xtrajPe4),1),'k')
plot3(xtrajPe5,ytrajPe5,50*ones(length(xtrajPe5),1),'k')
plot3(xtrajPe6,ytrajPe6,50*ones(length(xtrajPe6),1),'k')
surf(linspace(0,L,N),linspace(0,H,N),cPe10,'edgecolor','none')
hold off
view(2)
shading interp
daspect([1 1 1])
colorbar
print('FinitePe10','-depsc','-painters')
%%
figure
plot(linspace(0,L,N),ubotPe10)
hold on 
plot(linspace(0,L,N),ubot,'k')
plot(linspace(0,L,N),ubotPe1,'r')
plot(linspace(0,L,N),ubotPe4,'b')

%% Test BEM Solver
N = 51; % points per edge
L = 10; % length of domain
H = 3; % height of domain


% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop);

int = conc_interior(c,dcdn,N,L,H);
%%

[cPe101,ubotPe101,utopPe101,f101] = advdiff(N, L, H, Abot, Atop,0.1, 10, cPe10);
%%
figure
surf(linspace(0,L,N),linspace(0,H,N),cPe101,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
colorbar
%% Check solution Pe = 10
[UPe10,VPe10]=flow_int(N,L,H, f101, ubotPe101, utopPe101);
Pe =10;
%%
M=zeros(N);
dx = L/(N-1);
dy = H/(N-1);
%%
cPe10=cPe101;
for i=2:N-1
        for j=2:N-1
           M(i,j) = ((1/10)*((cPe10(i+1,j)-2*cPe10(i,j)+cPe10(i-1,j))/(dy^2) + (cPe10(i,j+1)-2*cPe10(i,j)+cPe10(i,j-1))/(dx^2))...
               -VPe10(i,j)*(cPe10(i+1,j)-cPe10(i-1,j))/(2*dy)-UPe10(i,j)*(cPe10(i,j+1)-cPe10(i,j-1))/(2*dx));
        end
end
%%
max(abs(M),[],"all")