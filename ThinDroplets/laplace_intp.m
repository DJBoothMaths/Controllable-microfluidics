function cint = laplace_intp(x, y, c, dcdn, N, L, H)

cint = 0;

[elmx, elmy, ~] = disc_rect(N,L,H);

for i=1:4*N
    [slp, dlp] = rect_sdlp(x, y, elmx(i,1),elmy(i,1), elmx(i,2),elmy(i,2), 8, 0);
    cint = cint + c(i)*dlp + dcdn(i)*slp;
end

end