N=201;
L=10;
H=3;
dt = 0.01;
%%
[time, xtraj, ytraj] = particle_trans(1,0.2, 6, N, L, H, dt);
%%
figure
plot(xtraj,ytraj)