
%%
N=201;
L=10;
H=3;
drop_centre = 2;
Nint = 2001;
%%
% [opt_time, opt_tsep] = optimums_inter(1,6, 2001, L, H, 0.01,81, 100,13, 29,1.4);
% %%
% [opt_time_1, opt_tsep_1] = optimums_inter(1,6, 2001, L, H, 0.01,81, 100,13, 29,1);
% %%
% save('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/opt.mat', "opt_tsep_1","opt_time-1")
% %%
% save('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/opt2.mat', "opt_tsep","opt_time")
% %%
% figure
% plot(linspace(0.1,1.5,29),opt_time,'b-o')
% hold on 
% plot(linspace(0.1,1.5,29),opt_time_1,'r-o')
% ylim([50 150])
% xlim([0 1.5])
% fontsize(16,"points")
% pbaspect([1.618 1 1])
% print('opt_time_2','-depsc')
% %%
% timesend = traversal_time_inter(1,1.5,6, 2001, L, H, 0.01,101, 15,30,2);
% timesend_1 = traversal_time_inter(1,1.45,6, 2001, L, H, 0.01,101, 15,30,2);
% %%
% opt_time(28)=min(timesend_1);
% opt_time(29)=min(timesend);
% %%
N=201;
L=10;
H=3;

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);
Atop(0.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);

int1 = conc_interior(c,dcdn,N,L,H);
%%
% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);
Atop(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);

int2 = conc_interior(c,dcdn,N,L,H);
%%

% construct top and bottom boundary conditions
Abot = zeros(N,1);
Abot(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);
Atop(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1;

% solve BEM equations
[c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,8);

int3 = conc_interior(c,dcdn,N,L,H);

%%
[time, xtraj_test, ytraj_test] =  particle_trans_discrete_inter(1,1,6, 10, 3,22.5,0.01,2001,2);
%%
[xt1,yt1]=cleandata(xtraj_test(1:2250),ytraj_test(1:2250),0.01);
[xt2,yt2]=cleandata(xtraj_test(2251:4500),ytraj_test(2251:4500),0.01);
[xt3,yt3]=cleandata(xtraj_test(4500:end),ytraj_test(4500:end),0.01);


%%
figure
surf(linspace(0,L,N),linspace(0,H,N),int1,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
axis off
hold off
colormap(colorcet('Gouldian'))
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop1.png','Resolution',600)
%%
figure
surf(linspace(0,L,N),linspace(0,H,N),int2,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
hold off
axis off
colormap(colorcet('Gouldian'))
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop2.png','Resolution',600)
%%
figure
surf(linspace(0,L,N),linspace(0,H,N),int3,'edgecolor','none')
view(2)
shading interp
daspect([1 1 1])
hold off
axis off
colormap(colorcet('Gouldian'))
exportgraphics(gca,'/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop3.png','Resolution',600)
%%
%%
figure
plot(xt1,yt1,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop1.tex')
%%
figure
plot(xt1,yt1,'r')
hold on
plot(xt2,yt2,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop2.tex')
%%
figure
plot(xt1,yt1,'r')
hold on
plot(xt2,yt2,'r')
plot(xt3,yt3,'k')
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop3.tex')