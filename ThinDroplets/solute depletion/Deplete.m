function crec = Deplete(dx, L, H,Abot, Tend, Pe,Da,record,opt)

% U, V are NxN matrices of the x and y velocities
% forward Euler solver of advection diffision eq.
Nx = floor(L/dx)+1;
Ny = floor(H/dx)+1;

cnew=ones(Ny,Nx);

dt = min(0.75*(Pe/4)*dx^2,0.05);

Nt = floor(Tend/dt);
count =1;

for t=1:Nt
    c = cnew;
    ubot = u_slip_alt(c(1,:),Nx,L,Abot);
    [U,V] = MAC_Stokes(dx, L, H,ubot);
    for i=2:Ny-1
        for j=2:Nx-1
            cnew(i,j) = c(i,j) + dt*((1/Pe)*((c(i+1,j)-2*c(i,j)+c(i-1,j))/(dx^2) + (c(i,j+1)-2*c(i,j)+c(i,j-1))/(dx^2)) ...
                -V(i,j)*(c(i+1,j)-c(i-1,j))/(2*dx)-U(i,j)*(c(i,j+1)-c(i,j-1))/(2*dx));
        end
    end
%Deal with BCs
if opt==1
    for k=1:Nx
        if Abot(k)~=0
        cnew(1,k) = (1/3)*(4*c(2,k)-c(3,k) - 2*Da*dx*c(1,k)); 
        else
            cnew(1,k) = (1/3)*(4*c(2,k)-c(3,k));
        end
        cnew(Ny,k) = 1/3*(4*c(Ny-1,k)-c(Ny-2,k));
    end  
elseif opt==2
    for k=1:Nx
        if Abot(k)~=0
        cnew(1,k) = (1/3)*(4*c(2,k)-c(3,k) - 2*dx*Abot(k)); 
        else
            cnew(1,k) = (1/3)*(4*c(2,k)-c(3,k));
        end
        cnew(Ny,k) = 1/3*(4*c(Ny-1,k)-c(Ny-2,k));
    end 
end
    for k=1:Ny
        cnew(k,1) = (1/3)*(4*c(k,2)-c(k,3)); 
        cnew(k,Nx) = 1/3*(4*c(k,Nx-1)-c(k,Nx-2));
    end
    if min(cnew,[],'all')<10^(-2)
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
    % if max(abs(cnew-c),[],"all")<10^(-5)
    %     disp('steady state reached')
    %     c=cnew;
    %     break
    % end
end
    







end