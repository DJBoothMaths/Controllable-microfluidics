function conc = conc_interior_one(c, dcdn, N, L, H, drop_centre, theta)
 conc = zeros(N);
 


[elmx, elmy, ~] = disc_one_drop(N,L,H, drop_centre,theta);
poly = polyshape(elmx(:,1),elmy(:,1)); % use to check if point is in domian 
dx = L/(N-1);
dy = H/(N-1);

for j=1:N
    conc(N,j) = c(3*N+1-j);
end

for j = 1:0.5*(N-1)+1-(N-1)/L-1
    conc(1,j) = c(j);
end
for j = 0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L-1
    xn = j;
    yn = round((-cot(theta) + sqrt(csc(theta)^2-(xn*dx-drop_centre)^2))/dy)+1;
    conc(yn,xn)=c(j);
end
for j = 0.5*(N-1)+1+(N-1)/L:N
    conc(1,j) = c(j);
end

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
    for i=1:4*N
        [slp, dlp] = rect_sdlp(x, y, elmx(i,1),elmy(i,1), elmx(i,2),elmy(i,2), 20, 0);
        cint = cint + c(i)*dlp - dcdn(i)*slp;
    end

end
end