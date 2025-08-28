function [uint,vint] = MAC_Stokes(dx, L, H,ubot)

Nx = floor(L/dx)+1;
Ny = floor(H/dx)+1;

p = zeros(Ny-1,Nx-1);
u = zeros(Ny-1,Nx);
v = zeros(Ny,Nx-1);
A = zeros((Ny-1)*Nx+Ny*(Nx-1)+(Ny-1)*(Nx-1));


% u eqs
for i=2:Ny-2
    for j = 2:Nx-1
        % u eq
        A((Ny-1)*(j-1)+i,(Ny-1)*(j-1)+i) = 4;
        A((Ny-1)*(j-1)+i,(Ny-1)*(j-2)+i) = -1;
        A((Ny-1)*(j-1)+i,(Ny-1)*(j)+i) = -1;
        A((Ny-1)*(j-1)+i,(Ny-1)*(j-1)+i-1) = -1;
        A((Ny-1)*(j-1)+i,(Ny-1)*(j-1)+i+1) = -1;
        A((Ny-1)*(j-1)+i,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(j-1)+i) = 1*dx;
        A((Ny-1)*(j-1)+i,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(j-2)+i) = -1*dx;     
    end
end
for i=1:Ny-1
    A(i,i) = 1;
    A((Ny-1)*(Nx-1)+i,(Ny-1)*(Nx-1)+i) = 1;
end
for j =2:Nx-1
    A((Ny-1)*(j-1)+1,(Ny-1)*(j-1)+1) = 5;
    A((Ny-1)*(j-1)+1,(Ny-1)*(j-2)+1) = -1;
    A((Ny-1)*(j-1)+1,(Ny-1)*(j)+1) = -1;
    A((Ny-1)*(j-1)+1,(Ny-1)*(j-1)+2) = -1;
    A((Ny-1)*(j-1)+1,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(j-1)+1) = 1*dx;
    A((Ny-1)*(j-1)+1,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(j-2)+1) = -1*dx;
    A((Ny-1)*(j-1)+Ny-1,(Ny-1)*(j-1)+Ny-1) = 5;
    A((Ny-1)*(j-1)+Ny-1,(Ny-1)*(j-2)+Ny-1) = -1;
    A((Ny-1)*(j-1)+Ny-1,(Ny-1)*(j)+Ny-1) = -1;
    A((Ny-1)*(j-1)+Ny-1,(Ny-1)*(j-1)+Ny-2) = -1;
    A((Ny-1)*(j-1)+Ny-1,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(j-1)+Ny-1) = 1*dx;
    A((Ny-1)*(j-1)+Ny-1,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(j-2)+Ny-1) = -1*dx;
end

%v eqs
for i=2:Ny-1
    for j = 2:Nx-2
        A(Nx*(Ny-1)+(Ny)*(j-1)+i,Nx*(Ny-1)+(Ny)*(j-1)+i) = 4;
        A(Nx*(Ny-1)+(Ny)*(j-1)+i,Nx*(Ny-1)+(Ny)*(j-2)+i) = -1;
        A(Nx*(Ny-1)+(Ny)*(j-1)+i,Nx*(Ny-1)+(Ny)*(j)+i) = -1;
        A(Nx*(Ny-1)+(Ny)*(j-1)+i,Nx*(Ny-1)+(Ny)*(j-1)+i-1) = -1;
        A(Nx*(Ny-1)+(Ny)*(j-1)+i,Nx*(Ny-1)+(Ny)*(j-1)+i+1) = -1;
        A(Nx*(Ny-1)+(Ny)*(j-1)+i,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(j-1)+i) = 1*dx;
        A(Nx*(Ny-1)+(Ny)*(j-1)+i,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(j-1)+i-1) = -1*dx;     
    end
end
for j=1:Nx-1
    A(Nx*(Ny-1)+(Ny)*(j-1)+1,Nx*(Ny-1)+(Ny)*(j-1)+1) = 1;
    A(Nx*(Ny-1)+(Ny)*(j-1)+Ny,Nx*(Ny-1)+(Ny)*(j-1)+Ny) = 1;
end
for i =2:Ny-1
    A(Nx*(Ny-1)+(Ny)*(Nx-2)+i,Nx*(Ny-1)+(Ny)*(Nx-2)+i) = 5;
    A(Nx*(Ny-1)+(Ny)*(Nx-2)+i,Nx*(Ny-1)+(Ny)*(Nx-3)+i) = -1;
    A(Nx*(Ny-1)+(Ny)*(Nx-2)+i,Nx*(Ny-1)+(Ny)*(Nx-2)+i-1) = -1;
    A(Nx*(Ny-1)+(Ny)*(Nx-2)+i,Nx*(Ny-1)+(Ny)*(Nx-2)+i+1) = -1;
    A(Nx*(Ny-1)+(Ny)*(Nx-2)+i,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(Nx-2)+i) = 1*dx;
    A(Nx*(Ny-1)+(Ny)*(Nx-2)+i,Nx*(Ny-1)+Ny*(Nx-1)+(Ny-1)*(Nx-2)+i-1) = -1*dx;
    A(Nx*(Ny-1)+i,Nx*(Ny-1)+i) = 5;
    A(Nx*(Ny-1)+i,Nx*(Ny-1)+(Ny)*(1)+i) = -1;
    A(Nx*(Ny-1)+i,Nx*(Ny-1)+i-1) = -1;
    A(Nx*(Ny-1)+i,Nx*(Ny-1)+i+1) = -1;
    A(Nx*(Ny-1)+i,Nx*(Ny-1)+Ny*(Nx-1)+i) = 1*dx;
    A(Nx*(Ny-1)+i,Nx*(Ny-1)+Ny*(Nx-1)+i-1) = -1*dx;
end
% mass conserve
for i=1:Ny-1
    for j=1:Nx-1
        A(Ny*(Nx-1)+Nx*(Ny-1)+(Ny-1)*(j-1)+i,(Ny-1)*(j-1)+i) = 1;
        A(Ny*(Nx-1)+Nx*(Ny-1)+(Ny-1)*(j-1)+i,(Ny-1)*(j)+i) = -1;
        A(Ny*(Nx-1)+Nx*(Ny-1)+(Ny-1)*(j-1)+i,Nx*(Ny-1)+(Ny)*(j-1)+i) = 1;
        A(Ny*(Nx-1)+Nx*(Ny-1)+(Ny-1)*(j-1)+i,Nx*(Ny-1)+(Ny)*(j-1)+i+1) = -1;
    end
end
b = zeros((Ny-1)*Nx+Ny*(Nx-1)+(Ny-1)*(Nx-1),1);
for j=1:Nx
    b((Ny-1)*(j-1)+1)=2*ubot(j);
end
x = A\b;

for i=1:Nx*(Ny-1)-1
    k = floor(i/(Ny-1))+1;
    if mod(i,Ny-1)==0
        l=Ny-1;
    else
    l = mod(i,(Ny-1));
    end
    u(l,k) = x(i);
end
u(Ny-1,Nx) = x(Nx*(Ny-1));

for i=1:Ny*(Nx-1)-1
    k = floor(i/(Ny))+1;
    if mod(i,Ny)== 0
       l=Ny;
    else
    l = mod(i,(Ny));
    end
    v(l,k) = x(Nx*(Ny-1)+i);
end
v(Ny,Nx-1) = x(Nx*(Ny-1)+Ny*(Nx-1));

uint = zeros(Ny,Nx);
vint = zeros(Ny,Nx);
ii=2:Ny-1;
jj=2:Nx-1;
uint(ii,jj) = (u(ii-1,jj)+u(ii,jj))/2;
uint(1,jj) = ubot(jj);
vint(ii,jj) = (v(ii,jj-1)+v(ii,jj))/2;
end