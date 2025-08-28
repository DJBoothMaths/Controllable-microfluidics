function [T,P,z] = surfaceplot(N,L,H,c,dcdn,drop_centre,theta)

%boundary points
[elmx, elmy, midx,midy] = disc_one_drop(N,L,H, drop_centre,theta);
poly = polyshape(elmx(:,1),elmy(:,1));

 for k=1:4*N
    P(k,1) = midx(k);
    P(k,2) = midy(k);
     z(k) = c(k);
 end

%interior points
dx = L/(N-1);
dy = H/(N-1);

k=4*N;
for j = 1:N
    for l = 1:N        
        if isinterior(poly,-L+0.01+dx*(j-1),-L+0.01+dy*(l-1))
            P(k,1) = -L+dx*(j-1);
            P(k,2) = -L+dy*(l-1);
            z(k) = conc_intp(-L+dx*(j-1),-L+dy*(l-1));
            k=k+1;
        end
    end
end

C = [(1:4*N-1)' (2:4*N)'; 4*N 1;];

T = delaunayTriangulation(P,C);

function cint = conc_intp(x, y)
    cint = 0;
    for i=1:4*N
        [slp, dlp] = rect_sdlp(x, y, elmx(i,1),elmy(i,1), elmx(i,2),elmy(i,2), 12, 0);
        cint = cint + c(i)*dlp - dcdn(i)*slp;
    end

end
end