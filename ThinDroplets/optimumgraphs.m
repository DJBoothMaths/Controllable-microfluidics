%%
N=51;
L=10;
H=3;
drop_centre = 2;
Nint = 2001;
Opt=1;
%[U,V] = interpolateflow(N,L,H, drop_centre, Nint,Opt);


%%
filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/dropbot-%d.mat', 2);
%%
save(filename, 'U','V') 
%%
surf(linspace(0,L,2001),linspace(0,H,2001),U,'EdgeColor','none')
%% bot drops
N=201;
L=10;
H=3;
Nint = 2001;
Opt=1;

for i = 3:L-3
    filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/dropbot-%d.mat', i);
   drop_centre = i;
   [U,V] = interpolateflow(N,L,H, drop_centre, Nint,Opt);
   save(filename, 'U','V')
end
%% top drops
N=201;
L=10;
H=3;
Nint = 2001;
Opt=2;

for i = 3:L-3
    filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/droptop-%d.mat', i);
   drop_centre = i;
   [U,V] = interpolateflow(N,L,H, drop_centre, Nint,Opt);
   save(filename, 'U','V')
end
%% 3 drops
N=201;
L=10;
H=3;
Nint = 2001;


for i = 3:4
    filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/3drop-%d.mat', i-2);
   drop_centre = i;
   [U,V] = interpolateflow(N,L,H, drop_centre, Nint,i);
   save(filename, 'U','V')
end

%%
[time, xtraj_test, ytraj_test] = particle_trans_opt(1,1,6, 10, 3,0.05,2001,-0.1);


%%
figure
plot(xtraj_test,ytraj_test,'k')
hold on
%plot(xtraj_test2,ytraj_test2,'r')
%plot(xtraj_test3,ytraj_test3,'b')
xlim([1 6])
pbaspect([1.618 1 1])
print('trajs','-depsc')
%%
times = traversal_time_inter(1,1,6, 2001, L, H, 0.01,101, 23,19,2);
times1 = traversal_time_inter(1,0.5,6, 2001, L, H, 0.01,101, 23,19,2);
%%
times2 = traversal_time_inter(1,2,6, 2001, L, H, 0.01,101, 70,55,2);
%%
times3 = traversal_time_inter(1,1.2,6, 2001, L, H, 0.01,101, 27,20);
%%
figure
plot(linspace(19,23,101),times,'k')
hold on
plot(linspace(19,23,101),times1,'k--')
xlim([19 23])
ylim([60 100])
pbaspect([1.618 1 1])
%print('travtime','-depsc')
%%
figure
plot(linspace(20,27,101),times3)
xlim([21 26])
%%
[opt_time, opt_tsep] = optimums_inter(1,6, 2001, L, H, 0.01,81, 100,13, 29,1);

%%
figure
plot(linspace(0.1,2,39),opt_time,'k-o')
pbaspect([1.618 1 1])
print('opt_time_2','-depsc')
%%
figure
plot(linspace(0.1,2,39),opt_tsep,'k-o')
pbaspect([1.618 1 1])
print('opt_tsep_2','-depsc')
%%
times3 = traversal_time_inter(1,0.1,6, 2001, L, H, 0.01,101, 50,80,1);
%%
[m,i]=min(times3)
%%
plot(times3)
%%
filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/dropbot-%d.mat', 3);
load(filename, 'U','V')
%%
surf(linspace(0,L,2001),linspace(0,H,2001),U,'EdgeColor','none')