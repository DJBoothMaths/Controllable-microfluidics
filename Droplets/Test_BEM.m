%% Test BEM Solver
N = 301; % points per edge
L = 10; % length of domain
H = 3; % height of domain
drop_centre =L/2;


% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

% solve BEM equations
[c8, dcdn8] = laplace_BEM_one_drop(N,L,H,Abot,Atop, drop_centre, pi/8,8);
[c3, dcdn3] = laplace_BEM_one_drop(N,L,H,Abot,Atop, drop_centre, pi/3,8);
%[c2, dcdn2] = laplace_BEM_one_drop(N,L,H,Abot,Atop, drop_centre, pi/2,8);
%%
[ubot,vbot] = u_slip_one_drop(c8,N,L,H,1, drop_centre, pi/8,Abot);
[ubot2,vbot2] = u_slip_one_drop(c8,N,L,H,1, drop_centre, pi/2,Abot);
[ubot3,vbot3] = u_slip_one_drop(c8,N,L,H,1, drop_centre, pi/3,Abot);
%%
[elmx,elmy,midx,midy] = disc_one_drop(N,L,H, drop_centre,pi/8);
%%
ii=121:181;
midx(ii) = midx(ii)-drop_centre;
%%
figure
plot(midx(121:181),ubot(121:181))
hold on 
%plot(midx(121:181),vbot(121:181))
plot(midx(121:181),ubot3(121:181))
%plot(midx(121:181),vbot3(121:181))
plot(midx(121:181),ubot2(121:181))
%plot(midx(121:181),vbot2(121:181))
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/udrop.tex')

%%
figure
%plot(midx(121:181),ubot(121:181))
hold on 
plot(midx(121:181),vbot(121:181))
%plot(midx(121:181),ubot3(121:181))
plot(midx(121:181),vbot3(121:181))
%plot(midx(121:181),ubot2(121:181))
plot(midx(121:181),vbot2(121:181))
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/vdrop.tex')

%%
plot(midx(121:181),c8(121:181))
hold on 
plot(midx(121:181),c2(121:181))
plot(midx(121:181),c3(121:181))
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/finitedropC.tex')

%% Interior points
%int = conc_interior_one(c, dcdn, N, L, H, drop_centre, pi/2);
%%
f= stokes_BEM_one_drop(N,L,H,ubot,vbot, drop_centre,pi/2);
%%
tend = 500;
dt = 0.05;
[xtraj,ytraj] = trajectory1(N,L,H, drop_centre+.3,1.5, f, ubot,vbot,drop_centre,pi/2, tend, dt);
%%
tend = 500;
dt = 0.05;
[xtraj2,ytraj2] = trajectory1(N,L,H, drop_centre-0.3,1.5, f, ubot,vbot,drop_centre,pi/2, tend, dt);
%%
tend = 200;
dt = 0.05;
[xtraj3,ytraj3] = trajectory1(N,L,H, drop_centre+0.6,1.5, f, ubot,vbot,drop_centre,pi/2, tend, dt);
%%
tend = 200;
dt = 0.05;
[xtraj4,ytraj4] = trajectory1(N,L,H, drop_centre-0.6,1.5, f, ubot,vbot,drop_centre,pi/2, tend, dt);
%%
tend = 500;
dt = 0.05;
[xtraj5,ytraj5] = trajectory1(N,L,H, drop_centre+.2,1.5, f, ubot,vbot,drop_centre,pi/2, tend, dt);
%%
tend = 500;
dt = 0.05;
[xtraj6,ytraj6] = trajectory1(N,L,H, drop_centre-.2,1.5, f, ubot,vbot,drop_centre,pi/2, tend, dt);
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
 plot([xtraj5 xtraj5(1)],[ytraj5 ytraj5(1)],'k')
 plot([xtraj6 xtraj6(1)],[ytraj6 ytraj6(1)],'k')
%surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')
% view(2)
% shading interp
% daspect([1 1 1])

axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/finitedroppi2.tex')
%%
%%
[T,P,z] = surfaceplot(N,L,H,c3,dcdn3,drop_centre,pi/3);
IO = isInterior(T);
%%
figure
trisurf(T(IO,:),P(:,1),P(:,2),z, 'EdgeColor','none')
hold on
view(2)
shading interp
pbaspect([1 1 1])
axis equal off
colormap(colorcet('Gouldian'))
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/finitedroppi3.png', 'Resolution', 600)









% %%
% bot = [5 pi/2 ];
% top = [];
% N = 200; % points per edge
% L = 10; % length of domain
% H = 3; % height of domain
% [elmx,elmy,midx,midy]=disc_drops(N,L,H, bot, top);
% %%
% Abot = zeros((2*length(bot(:,1))+1)*N,1);
% for i=1:length(bot(:,1))
%     Abot((2*i-1)*N:2*i*N)=-1;
% end
% Atop = zeros(N,1);
% 
% 
% [M, rhs, x, c, dcdn] = laplace_BEM_one_drop(N,L,H,bot,[],Abot,Atop);
% %%
% [elmx,elmy,midx,midy] = disc_drops(N,L,H, bot, top)
% %%
% poly = polyshape(elmx(:,1),elmy(:,1));
% plot(poly)
% %% Interior points
% int = conc_interior(c,dcdn,N,300,L,H, bot, []);
% %%
% figure
% surf(linspace(L/301,L-L/301,300),linspace(H/301,H-H/301,300),int,'edgecolor','none')
% view(2)
% daspect([1 1 1])
% colorbar
% hold on
% plot(elmx(:,1),elmy(:,1),'-k', LineWidth=2)
% %%
% [ubot, utop,vbot,vtop] = u_slip(c,N,L,H,bot,top, M);
% %%
% figure
% plot(linspace(0,L,3*N),vbot(1:3*N))
% figure
% plot(linspace(0,L,3*N),c(1:3*N))
% %%
% f = stokes_BEM_drops(N,L,H,bot, top,ubot,utop,vbot,vtop)

