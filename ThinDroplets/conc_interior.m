function conc = conc_interior(c, dcdn, N, L, H)
 conc = zeros(N);

[elmx, elmy, ~] = disc_rect(N,L,H);
for k=1:N
    conc(1,k) = c(k);
    conc(k,N) = c(N+k);
    conc(N,k) = c(3*N+1-k);
    conc(k,1) = c(4*N+1 - k);
end

dx = L/(N-1);
dy = H/(N-1);

for j = 2:N-1
    for l = 2:N-1
        conc(l,j) = conc_intp(dx*(j-1),dy*(l-1));
    end
end




function cint = conc_intp(x, y)
    cint = 0;
    for i=1:4*N
        [slp, dlp] = rect_sdlp(x, y, elmx(i,1),elmy(i,1), elmx(i,2),elmy(i,2), 8, 0);
        cint = cint + c(i)*dlp - dcdn(i)*slp;
    end

end
end