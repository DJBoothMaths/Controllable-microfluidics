Nint=2001;
L=10;
H=3;
%%
load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/3drop-1.mat','U','V');
U1=U;
V1=V;
%%
load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/3drop-2.mat','U','V');
U2=U;
V2=V;
%%
T=6;
lambda = Lyapunov(2.5,1.5, 0.000000001, T*1000,Nint,L,H, 0.01,T,U1,V1,U2,V2);
%%
[strobex6,strobey6] = poincare_alt(Nint,L,H, 5,1.5, 12000, 0.01,6,U1,V1,U2,V2,101);
%%
[strobex2,strobey2] = poincare_alt(Nint,L,H, 5,1.5, 24000, 0.01,12,U1,V1,U2,V2,101);
%%
[strobex5,strobey5] = poincare_alt(Nint,L,H, 5,1.5, 2000, 0.01,1,U1,V1,U2,V2,101);

%%
figure
plot(strobex6,strobey6, 'k.','MarkerSize',0.3)
hold on
% plot(strobex62,strobey62, 'ko')
% plot(strobex63,strobey63, 'ko')
% plot(strobex64,strobey64, 'ko')
plot(10,3, 'k.','MarkerSize',0.03)
plot(0, 0, 'k.','MarkerSize',0.03)
%pbaspect([10 3 1])
axis off
exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/mixone6.png', 'Resolution', 600)
%%
figure
plot(strobex2,strobey2, 'k.','MarkerSize',0.3)
hold on
plot(10,3, 'k.','MarkerSize',0.03)
plot(0, 0, 'k.','MarkerSize',0.03)
pbaspect([10 3 1])
 axis off
 exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/mixone2.png', 'Resolution', 600)
 %%
figure
plot(strobex5,strobey5, 'k.','MarkerSize',0.3)
hold on
plot(10,3, 'k.','MarkerSize',0.03)
plot(0, 0, 'k.','MarkerSize',0.03)
%pbaspect([10 3 1])
 axis equal off
 exportgraphics(gca, '/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/mixone5.png', 'Resolution', 600)
%%
Ntt=2000;
%%
for i=1:100
    d(i)=0;
    for j =92:101
    d(i) = d(i)+sqrt((strobex5(Ntt*(j-1)+i)-strobex5(Ntt*(j-2)+i))^2+...
        (strobey5(Ntt*(j-1)+i)-strobey5(Ntt*(j-2)+i))^2);
    end
end
%%
Ntime = 108/12;
for i=1:Ntime
    d2(i)=0;
    for j =92:101
    d2(i) = d2(i)+sqrt((strobex2(Ntt*(j-1)+i)-strobex2(Ntt*(j-2)+i))^2+...
        (strobey2(Ntt*(j-1)+i)-strobey2(Ntt*(j-2)+i))^2);
    end
end
%%
Ntime = 102/6;
for i=1:Ntime
    d6(i)=0;
    for j =92:101
    d6(i) = d6(i)+sqrt((strobex6(Ntt*(j-1)+i)-strobex6(Ntt*(j-2)+i))^2+...
        (strobey6(Ntt*(j-1)+i)-strobey6(Ntt*(j-2)+i))^2);
    end
end
%%
figure
plot(linspace(0,100,101),[0.618 d])
hold on 
plot(linspace(0,108,length(d2)+1),[0.618 d2])
plot(linspace(0,102,length(d6)+1),[0.618 d6])
xlim([0 70])
  %axis off
  matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/quant1.tex')
%%
cycles =20;
%%
for i=1:cycles
    dc(i)=0;
    for j =92:101
    dc(i) = dc(i)+sqrt((strobex5(Ntt*(j-1)+i)-strobex5(Ntt*(j-2)+i))^2+...
        (strobey5(Ntt*(j-1)+i)-strobey5(Ntt*(j-2)+i))^2);
    end
end

%%

for i=1:cycles
    dc2(i)=0;
    for j =92:101
    dc2(i) = dc2(i)+sqrt((strobex2(Ntt*(j-1)+i)-strobex2(Ntt*(j-2)+i))^2+...
        (strobey2(Ntt*(j-1)+i)-strobey2(Ntt*(j-2)+i))^2);
    end
end
%%
for i=1:cycles
    dc6(i)=0;
    for j =92:101
    dc6(i) = dc6(i)+sqrt((strobex6(Ntt*(j-1)+i)-strobex6(Ntt*(j-2)+i))^2+...
        (strobey6(Ntt*(j-1)+i)-strobey6(Ntt*(j-2)+i))^2);
    end
end
%%
figure
plot(linspace(0,20,21),[0.618 dc])
hold on 
plot(linspace(0,20,21),[0.618 dc2])
plot(linspace(0,20,21),[0.618 dc6])
xlim([0 20])
axis off
matlab2tikz('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/tikz/quant1vsT.tex')