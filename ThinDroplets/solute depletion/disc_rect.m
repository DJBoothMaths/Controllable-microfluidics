function [elmx,elmy,midx,midy] = disc_rect(N,L,H)

% Discretise domain boundary
% N number of points per wall
% L x length
% h y height
N4  = 4*N;    % Total number of elements

dx = L/N;  % element length in x
dy= H/N; %element length in y

%%%%
% Number elements starting from
% bottom left end, and assign 
% coordinates
%
% elmx(k,1/2) : x coord of start (0) or end (1) 
%                 of element k
%
% elmy(k,1/2) : y coord of start (0) or end (1) 
%                 of element k
%%%%

% bottom
elmx = zeros(N4,2);
elmy = zeros(N4,2); 

for k = 1:N
    elmx(k,1) = (k-1)*dx;
    elmx(k,2) = k*dx;
    elmy(k,1) = 0;
    elmy(k,2) = 0;
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
midx = zeros(N4,1);
midy = zeros(N4,1);

for i=1:N4
    midx(i) = 0.5*(elmx(i,2)+elmx(i,1));
    midy(i) = 0.5*(elmy(i,2)+elmy(i,1));
end

% Plot elements

% plot(elmx(:,1),elmy(:,1),'-o')
% hold on
% plot(elmx(:,2),elmy(:,2),'-o')
% 
% plot(midx(:,1),midy(:,1),'-x')
% axis([-0.5 L+0.5 -0.5 H+0.5])
end