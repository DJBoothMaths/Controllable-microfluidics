addpath('/Users/danielbooth/Documents/Warwick/MATLAB/matlab2tikz-matlab2tikz-806c97d/src')
%%
load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/opt.mat', "opt_tsep_1","opt_time-1")
%%
load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/opt2.mat', "opt_tsep","opt_time")
%% optimum graphs
figure
plot(linspace(0.1,1.5,29),opt_time,'b-o')
hold on 
plot(linspace(0.1,1.5,29),opt_time_1,'r-o')
ylim([50 150])
xlim([0 1.5])

pbaspect([1.618 1 1])
%print('opt_time_2','-depsc')
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/opt_time.tex')
%% bottop transport
figure
plot3(xt1,yt1, 50*ones(length(xt1),1),'k','LineWidth',1.5)
hold on
surf(linspace(0,L,N),linspace(0,H,N),int1,'edgecolor','none')
view(2)
daspect([1 1 1])
axis off
hold off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop1.png', 'Resolution', 600)
%%
figure
plot3(xt1,yt1, 50*ones(length(xt1),1),'r','LineWidth',1.5)
hold on
plot3(xt2,yt2, 50*ones(length(xt2),1),'k','LineWidth',1.5)
surf(linspace(0,L,N),linspace(0,H,N),int2,'edgecolor','none')
view(2)
daspect([1 1 1])
axis off
hold off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop2.png', 'Resolution', 600)
%%
figure
plot3(xt1,yt1, 50*ones(length(xt1),1),'r','LineWidth',1.5)
hold on 
plot3(xt2,yt2, 50*ones(length(xt2),1),'r','LineWidth',1.5)
plot3(xt3,yt3, 50*ones(length(xt3),1),'k','LineWidth',1.5)
surf(linspace(0,L,N),linspace(0,H,N),int3,'edgecolor','none')
view(2)
daspect([1 1 1])
axis off
hold off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/bottop3.png', 'Resolution', 600)