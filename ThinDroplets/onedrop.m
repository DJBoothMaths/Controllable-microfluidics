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
[c2, dcdn2] = laplace_BEM_2d(N,L,H,Abot,Atop,20);

max(abs(c1-c2))
%% Interior points
int = conc_interior(c,dcdn,N,L,H);
%%
figure
surf(linspace(0,L,N),linspace(0,H,N),int,'edgecolor','none')
view(2)
shading interp
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
colormap(colorcet('Gouldian'))
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/onedrop.png', 'Resolution', 1500)

%%
figure
plot(xtraj,ytraj,'k--')
%% quiver plot of flow
[U,V] = flow_int(N,L,H, f, ubot, utop,N);
%%
figure
plot(linspace(0,L,N),U(floor(0.1/3*(N-1))+1,1:N))

%%
% %% Test BEM Solver
% N = 201; % points per edge
% L = 10; % length of domain
% H = 3; % height of domain
% [time, xtraj, ytraj] = particle_trans(2,0.05, 0.7, L-2, N, L, H, 0.01);
% [time1, xtraj1, ytraj1] = particle_trans(2,0.05, 0.5, L-2, N, L, H, 0.01);
% %%
% [time2, xtraj2, ytraj2] = particle_trans(2,0.05, 0.6, L-2, N, L, H, 0.01);
% [time3, xtraj3, ytraj3] = particle_trans(2,0.05, 0.4, L-2, N, L, H, 0.01);
% %%
% figure
% plot(xtraj,ytraj,'b')
% hold on
% plot(xtraj2,ytraj2,'r')
% plot(xtraj1,ytraj1,'g')
% plot(xtraj3,ytraj3,'k')
% hold off
% %%
% drop_centre=2+0.8;
% Abot = zeros(N,1);
%     Abot(floor(drop_centre*(N-1)/L)+1-(N-1)/L:floor(drop_centre*(N-1)/L)+1+(N-1)/L)=-1;
%     Atop = zeros(N,1);
% 
%     % solve BEM equations
%     c = laplace_BEM_2d(N,L,H,Abot,Atop);
%     [ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 0);
%     f = stokes_BEM_2d(N,L,H,ubot,utop);
%     %compute movement of particle
%     [ux,uy] = flow_point(2, 0.05, N,L,H, f, ubot, utop)
%     %%
%     figure
% plot(linspace(0,L,N),ubot)
%%
%% Test BEM Solver
N = 201; % points per edge
L = 10; % length of domain
H = 3; % height of domain
[time, xtrajdis, ytrajdis] = particle_trans_discrete(1,0.1, L-3, N, L, H,2, 0.01);
[time1, xtrajdis1, ytrajdis1] = particle_trans_discrete(1,0.1, L-3, N, L, H,3, 0.01);
%%
[time2, xtrajdis2, ytrajdis2] = particle_trans_discrete(1,0.1, L-3, N, L, H,1, 0.01);
[time3, xtrajdis3, ytrajdis3] = particle_trans_discrete(1,0.1, L-3, N, L, H,0.75, 0.01);
%%
figure
plot(xtrajdis,ytrajdis,'b')
hold on
plot(xtrajdis1,ytrajdis1,'r')
plot(xtrajdis2,ytrajdis2,'g')
plot(xtrajdis3,ytrajdis3,'k')
hold off
%%
times = zeros(21,1);
for i=1:21
    tsep = 0.2+0.1*(i-1);
    [time, ~] = particle_trans_discrete(1,0.1, L-3, N, L, H,tsep, 0.01);
    times(i)=time;
end
%%
times1 = zeros(21,1);
for i=1:21
    tsep = 0.2+0.1*(i-1);
    [time, ~] = particle_trans_discrete(1,0.15, L-3, N, L, H,tsep, 0.01);
    times1(i)=time;
end
%%
figure
plot(linspace(0.2,2.2,21),times)
hold on
plot(linspace(0.2,2.2,21),times1)
hold off

%%
times_disc = zeros(41,1);
for i=1:41
    tsep = 0.2+0.125*(i-1);
    [time, ~] = particle_trans_discrete_2(1,0.05, L-3, N, L, H,tsep, 0.005);
    times_disc(i)=time;
end
%%
times_disc1 = zeros(41,1);
for i=1:41
    tsep = 0.2+0.125*(i-1);
    [time, ~] = particle_trans_discrete_2(1,0.1, L-3, N, L, H,tsep, 0.005);
    times_disc1(i)=time;
end
%%
times_disc2 = zeros(41,1);
for i=1:41
    tsep = 0.2+0.125*(i-1);
    [time, ~] = particle_trans_discrete_2(1,0.5, L-3, N, L, H,tsep, 0.005);
    times_disc2(i)=time;
end
%%

times_disc3 = zeros(41,1);
for i=1:41
    tsep = 0.2+0.125*(i-1);
    [time, ~] = particle_trans_discrete_2(1,1, L-3, N, L, H,tsep, 0.005);
    times_disc3(i)=time;
end

%%
figure
plot(linspace(0.2,5.2,41),times_disc,'b')
hold on
plot(linspace(0.2,5.2,41),times_disc1,'r')
plot(linspace(0.2,5.2,41),times_disc2,'k')
%plot(linspace(0.2,5.2,41),times_disc3)
hold off
%% Test BEM Solver
N = 201; % points per edge
L = 10; % length of domain
H = 3; % height of domain
[time, xtraj_dis, ytraj_dis] = particle_trans_discrete_2(1,1, L-3, N, L, H,4.7, 0.05);
    

%%
figure
plot(xtraj_dis,ytraj_dis,'b')
pbaspect([1.618 1 1])
print('trajectory','-depsc')
%hold on
%plot(xtrajdis1,ytrajdis1,'r')
%%
times_disc22 = zeros(41,1);
for i=1:41
    tsep = 0.2+0.25*(i-1);
    [time, ~] = particle_trans_discrete_2(1,0.5, L-3, N, L, H,tsep, 0.05);
    times_disc22(i)=time;
end

%%
figure
plot(linspace(0.2,5.2,41),times_disc,'b')
hold on
plot(linspace(0.2,5.2,41),times_disc1,'r')
plot(linspace(0.2,10.2,41),times_disc22(1:41),'k')
%%
times_disc23 = zeros(21,1);
for i=1:21
    tsep = 4+0.05*(i-1);
    [time, ~] = particle_trans_discrete_2(1,1, L-3, N, L, H,tsep, 0.05);
    times_disc23(i)=time;
end
%%
figure
plot(linspace(0.2,10.2,41),times_disc22(1:41),'k')
hold on
plot(linspace(4,5,21),times_disc23,'k')
hold off

%%
time_disc1 = traversal_time(1,0.1, L-3, N, L, H, 0.05,41,10.2,0.2);
time_disc2 = traversal_time(1,0.5, L-3, N, L, H, 0.05,41,10.2,0.2);
time_disc3 = traversal_time(1,1, L-3, N, L, H, 0.05,41,10.2,0.2);
%%
time_disc4 = traversal_time(1,0.25, L-3, N, L, H, 0.05,41,10.2,0.2);
%%
time_disc11 = traversal_time(1,0.1, L-3, N, L, H, 0.05,21,15.2,10.2);
time_disc21 = traversal_time(1,0.5, L-3, N, L, H, 0.05,21,15.2,10.2);
time_disc31 = traversal_time(1,1, L-3, N, L, H, 0.05,21,15.2,10.2);
%%
figure
plot(linspace(0.2,10.2,41),time_disc1,'b')
hold on
plot(linspace(0.2,10.2,41),time_disc2,'r')
plot(linspace(0.2,10.2,41),time_disc3,'k')
plot(linspace(10.2,15.2,21),time_disc11,'b')
plot(linspace(10.2,15.2,21),time_disc21,'r')
plot(linspace(10.2,15.2,21),time_disc31,'k')
%%
figure
plot(linspace(0.2,10.2,41),time_disc1,'b')
hold on
plot(linspace(0.2,10.2,41),time_disc3,'r')
plot(linspace(0.2,10.2,41),time_disc2,'k')
xlim([0.2 10])
pbaspect([1.618 1 1])
print('timevstsep','-depsc')

%%
[opt_time, opt_tsep] = optimums(1,L-3, N, L, H, 0.05,81, 10.1,0.1, 10);
%%
figure
plot(linspace(0.1,1,10),opt_time,'k-o')
pbaspect([1.618 1 1])
print('opt_time','-depsc')
%figure
%plot(linspace(0.1,1,10),opt_tsep,'k-o')
