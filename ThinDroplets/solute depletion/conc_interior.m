function conc = conc_interior(c, dcdn, dx, L, H)

Nx = floor(L/dx)+1;
Ny = floor(H/dx)+1;
N=Nx-1;

conc = zeros(Ny,Nx);

[elmx, elmy, ~] = disc_rect(N,L,H);
for k=1:N
    conc(1,k+1) = (c(k)+c(k+1))/2;
    conc(Ny,k+1) = (c(3*N+1-k)+c(3*N+1-(k+1)))/2;
end


for j = 2:Nx-1
    for l = 2:Ny-1
        conc(l,j) = conc_intp(dx*(j-1),dx*(l-1));
    end
end




function cint = conc_intp(x, y)
    cint = 0;
    for i=1:4*(Nx-1)
        [slp, dlp] = rect_sdlp(x, y, elmx(i,1),elmy(i,1), elmx(i,2),elmy(i,2), 8, 0);
        cint = cint + c(i)*dlp - dcdn(i)*slp;
    end

end
end