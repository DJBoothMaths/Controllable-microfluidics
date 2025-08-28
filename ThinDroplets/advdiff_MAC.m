function crec = advdiff_MAC(dx, L, H, Abot, Tend, Pe, int,record)

% U, V are NxN matrices of the x and y velocities
% forward Euler solver of advection diffision eq.



Nx = floor(L/dx)+1;
Ny = floor(H/dx)+1;

cnew=int;


dt = min(0.75*(Pe/4)*dx^2,0.05);

Nt = floor(Tend/dt);
count =1;


for t=1:Nt
    c = cnew;
    ubot = u_slip_MAC(c(1,:),Nx,L,Abot);
    [U,V] = MAC_Stokes(dx, L, H,ubot);
    for i=2:Ny-1
        for j=2:Nx-1
            cnew(i,j) = c(i,j) + dt*((1/Pe)*((c(i+1,j)-2*c(i,j)+c(i-1,j))/(dx^2) + (c(i,j+1)-2*c(i,j)+c(i,j-1))/(dx^2)) ...
                -V(i,j)*(c(i+1,j)-c(i-1,j))/(2*dx)-U(i,j)*(c(i,j+1)-c(i,j-1))/(2*dx));
        end
    end
%Deal with BCs
    for k=1:Nx
        cnew(1,k) = c(2,k) - dx*Abot(k); 
        cnew(Ny,k) = c(Ny-1,k);
    end
    
    if max(abs(cnew-c),[],"all")<10^(-4)
        disp('steady state reached')
        c=cnew;
        break
    end
    if mod(t,record)==0
        for i=1:Ny
            for j=1:Nx
                crec(i,j,count) = cnew(i,j);
            end
        end
        count=count+1;
    end
end
    







end