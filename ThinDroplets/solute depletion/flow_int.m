function [U,V] = flow_int(dx,L,H, f, ubot)

Nx = floor(L/dx)+1;
Ny = floor(H/dx)+1;
N=Nx-1;

U = zeros(Ny,Nx);
V= zeros(Ny,Nx);


[elmx, elmy, ~] = disc_rect(N,L,H);

Ubound = [ubot; zeros(3*N,1)];


for i=2:Ny-1
    for j=2:Nx-1
    ux=0;
    uy=0;
    for k = 1:4*N
        [slxx,slxy,slyx,slyy,dlxx,~,dlyx,~] = stokes_sdlp(dx*(j-1), dx*(i-1), elmx(k,1), elmy(k,1), elmx(k,2), elmy(k,2), 12, 0);
       ux = ux - (1/(4*pi))*(slxx*f(k,1)+slxy*f(k,2)) + (1/(4*pi))*Ubound(k)*dlxx;
       uy = uy - (1/(4*pi))*(slyx*f(k,1)+slyy*f(k,2)) + (1/(4*pi))*Ubound(k)*dlyx;
    end
    U(i,j)=ux;
    V(i,j)=uy;
    end
end

end
