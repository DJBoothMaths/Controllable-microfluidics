%% Test BEM Solver
N = 101; % points per edge
L = 10; % length of domain
H = 3; % height of domain

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop);
%%
tic
[ubot, utop] = u_slip(c,N,L,  [1 1], 0);
f = stokes_BEM_2d(N,L,H,ubot,utop);
toc
%%
tic
[U,V] = flow_int(N,L,H, f, ubot, utop);
toc
