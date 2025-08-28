function conc = conc_interior(c, dcdn, N, Nint, L, H, bot, top)
 conc = zeros(Nint);
 


[elmx, elmy, ~] = disc_drops(N,L,H, bot, top);
poly = polyshape(elmx(:,1),elmy(:,1)); % use to check if point is in domian 
dx = L/(Nint-1);
dy = H/(Nint-1);

for j = 2:N-1
    for l = 2:N-1
        if isinterior(poly,dx*(j-1),dy*(l-1))
            conc(l,j) = conc_intp(dx*(j-1),dy*(l-1));
        else
            conc(l,j) = NaN;
        end
    end
end




function cint = conc_intp(x, y)
    cint = 0;
    for i=1:Ntot
        [slp, dlp] = rect_sdlp(x, y, elmx(i,1),elmy(i,1), elmx(i,2),elmy(i,2), 8, 0);
        cint = cint + c(i)*dlp - dcdn(i)*slp;
    end

end
end