L=10;
H=3;
%%
[opt_time_1, opt_tsep_1] = optimums_inter(1,6, 2001, L, H, 0.01,81, 100,13, 29,1);
%%
save('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/opt.mat', "opt_tsep_1","opt_time_1")
%%
load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/opt2.mat', "opt_tsep","opt_time")
%% optimum graphs
figure
plot(linspace(0.1,1.5,29),opt_time,'b-o')
hold on 
plot(linspace(0.1,1.5,29),opt_time_1,'r-o')
ylim([50 150])
xlim([0 1.5])
axis off
pbaspect([1.618 1 1])
%print('opt_time_2','-depsc')
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/opt_time.tex')