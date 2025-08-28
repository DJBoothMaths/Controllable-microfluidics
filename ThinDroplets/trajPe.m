[cPe10,ubotPe10,utopPe10,f10] = advdiff(N, L, H, Abot, Atop,100, 10,cPe10);
%%
L=10;
H=3;
N=51;
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
[xtrajPe3,ytrajPe3] = trajectory1(N,L,H, 5.2,1, f10, ubotPe10, utopPe10, tend, dt);
%%
tend = 250;
dt = 0.02;
[xtrajPe4,ytrajPe4] = trajectory1(N,L,H, 4.8,1, f10, ubotPe10, utopPe10, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtrajPe5,ytrajPe5] = trajectory1(N,L,H, 5.9,1, f10, ubotPe10, utopPe10, tend, dt);
%%
tend = 50;
dt = 0.01;
[xtrajPe6,ytrajPe6] = trajectory1(N,L,H, 4.1,1, f10, ubotPe10, utopPe10, tend, dt);
%%
[xtrajPe,ytrajPe]= cleandata(xtrajPe,ytrajPe,0.01);
[xtrajPe2,ytrajPe2]= cleandata(xtrajPe2,ytrajPe2,0.01);
[xtrajPe3,ytrajPe3]= cleandata(xtrajPe3,ytrajPe3,0.01);
[xtrajPe4,ytrajPe4]= cleandata(xtrajPe4,ytrajPe4,0.01);
[xtrajPe5,ytrajPe5]= cleandata(xtrajPe5,ytrajPe5,0.01);
[xtrajPe6,ytrajPe6]= cleandata(xtrajPe6,ytrajPe6,0.01);
%%
figure
% plot3(xtrajPe,ytrajPe,50*ones(length(xtrajPe),1),'k','LineWidth',1.3)
% hold on 
% plot3(xtrajPe2,ytrajPe2,50*ones(length(xtrajPe2),1),'k','LineWidth',1.3)
% plot3(xtrajPe3,ytrajPe3,50*ones(length(xtrajPe3),1),'k','LineWidth',1.3)
% plot3(xtrajPe4,ytrajPe4,50*ones(length(xtrajPe4),1),'k','LineWidth',1.3)
% plot3(xtrajPe5,ytrajPe5,50*ones(length(xtrajPe5),1),'k','LineWidth',1.3)
% plot3(xtrajPe6,ytrajPe6,50*ones(length(xtrajPe6),1),'k','LineWidth',1.3)
surf(linspace(0,L,N),linspace(0,H,N),cPe10,'edgecolor','none')
%hold off
view(2)
shading interp
daspect([1 1 1])
axis off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/Pe10.png', 'Resolution', 600)
%%
figure
plot(xtrajPe,ytrajPe,'k','LineWidth',1.3)
hold on 
plot(xtrajPe2,ytrajPe2,'k','LineWidth',1.3)
plot(xtrajPe3,ytrajPe3,'k','LineWidth',1.3)
plot(xtrajPe4,ytrajPe4,'k','LineWidth',1.3)
plot(xtrajPe5,ytrajPe5,'k','LineWidth',1.3)
plot(xtrajPe6,ytrajPe6,'k','LineWidth',1.3)
%surf(linspace(0,L,N),linspace(0,H,N),cPe10,'edgecolor','none')
%hold off
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/Pe10.tex')
