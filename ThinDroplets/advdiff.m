function [c,ubot,utop,f] = advdiff(N, L, H, Abot, Atop, Tend, Pe, int)

% U, V are NxN matrices of the x and y velocities
% forward Euler solver of advection diffision eq.


cnew=int;
c = zeros(N);

dx = L/(N-1);
dy = H/(N-1);

dt = 0.75*(Pe/4)*min([dx^2 dy^2]);

Nt = floor(Tend/dt);


for t=1:Nt
    c = cnew;
    cbound=zeros(4*N,1);
    for i=1:N
        cbound(i)=c(1,i);
        cbound(3*N+1-i)=c(N,i);
    end
    [ubot, utop] = u_slip_alt(cbound,N,L,Abot,Atop,  [1 1], 0);
    f = stokes_BEM_2d(N,L,H,ubot,utop);
    [U,V] = flow_int(N,L,H, f, ubot, utop);
    for i=2:N-1
        for j=2:N-1
            cnew(i,j) = c(i,j) + dt*((1/Pe)*((c(i+1,j)-2*c(i,j)+c(i-1,j))/(dy^2) + (c(i,j+1)-2*c(i,j)+c(i,j-1))/(dx^2)) ...
                -V(i,j)*(c(i+1,j)-c(i-1,j))/(2*dy)-U(i,j)*(c(i,j+1)-c(i,j-1))/(2*dx));
        end
    end
%Deal with BCs
    for k=1:N
        cnew(1,k) = c(2,k) - dy*Abot(k); 
        cnew(N,k) = c(N-1,k) - dy*Atop(k);
    end
    a=max(abs(cnew-c),[],"all");
    if max(abs(cnew-c),[],"all")<10^(-4)
        disp('steady state reached')
        c=cnew;
        break
    end
end
    







end