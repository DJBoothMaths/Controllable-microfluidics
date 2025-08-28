function [elmx,elmy,midx,midy] = disc_one_drop(N,L,H, drop_centre,theta)

elmx = zeros(4*N,2);
elmy = zeros(4*N,2);
midx = zeros(4*N,1);
midy = zeros(4*N,1);

dx = L/N;
dy= H/N;

% bottom

for k = 1:N
    if abs((k-1)*dx-drop_centre)<1
       elmx(k,1) = (k-1)*dx;
       elmy(k,1) = -cot(theta)+sqrt(csc(theta)^2-((k-1)*dx-drop_centre)^2);
    else
    elmx(k,1) = (k-1)*dx;
    elmy(k,1) = 0;
    end
end
for k = 1:N
    if abs((k)*dx-drop_centre)<1 
        elmx(k,2) = (k)*dx;
       elmy(k,2) = -cot(theta)+sqrt(csc(theta)^2-((k)*dx-drop_centre)^2);
    else
    elmx(k,2) = k*dx;
    elmy(k,2) = 0;
    end
end
% Right hand side

for k = N+1:2*N
    k2 = k-N;
    elmx(k,1) = L;
    elmx(k,2) = L;
    elmy(k,1) = (k2-1)*dy;
    elmy(k,2) = k2*dy;
end

% top

for k = 2*N+1:3*N
    k2 = k-2*N;
    elmx(k,1) = L-(k2-1)*dx;
    elmx(k,2) = L-k2*dx;
    elmy(k,1) = H;
    elmy(k,2) = H;
end

% Left hand side

for k = 3*N+1:4*N
    k2 = k-3*N;
    elmx(k,1) = 0;
    elmx(k,2) = 0;
    elmy(k,1) = H-(k2-1)*dy;
    elmy(k,2) = H-k2*dy;
end

% Find midpoints
midx = zeros(N*4,1);
midy = zeros(N*4,1);

for i=1:N*4
    midx(i) = 0.5*(elmx(i,2)+elmx(i,1));
    midy(i) = 0.5*(elmy(i,2)+elmy(i,1));
end

end