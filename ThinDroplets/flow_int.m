function [U,V] = flow_int(N,L,H, f, ubot, utop)

U = zeros(N);
V= zeros(N);

dx = L/(N-1);
dy = H/(N-1);

for i=1:N
    U(1,i) = ubot(i);
    U(N,i) = utop(i);
end

[elmx, elmy, ~] = disc_rect(N,L,H);

Ubound = [ubot; zeros(N,1); flip(utop); zeros(N,1)];


for i=2:N-1
    for j=2:N-1
    ux=0;
    uy=0;
    for k = 1:4*N
        [slxx,slxy,slyx,slyy,dlxx,~,dlyx,~] = stokes_sdlp(dx*(j-1), dy*(i-1), elmx(k,1), elmy(k,1), elmx(k,2), elmy(k,2), 8, 0);
       ux = ux - (1/(4*pi))*(slxx*f(k,1)+slxy*f(k,2)) + (1/(4*pi))*Ubound(k)*dlxx;
       uy = uy - (1/(4*pi))*(slyx*f(k,1)+slyy*f(k,2)) + (1/(4*pi))*Ubound(k)*dlyx;
    end
    U(i,j)=ux;
    V(i,j)=uy;
    end
end

end
