function [elmbot,elmright,elmtop,elmleft] = disc_droplet(N,L,H, bot, top)

% Discretise domain boundary
% N number of points per wall
% L x length
% h y height
% bot centre of droplets along bottom and contact angles
% top ^ along top and contact angles


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
elmbot = zeros((2*length(bot(:,1))+1)*N,4);
elmtop = zeros((2*length(top(:,1))+1)*N,4); 
elmright = zeros(N,4);
elmleft = zeros(N,4); 

% Right hand side

for k = 1:N
    elmright(k,1) = L;
    elmright(k,2) = L;
    elmright(k,3) = (k-1)*dy;
    elmright(k,4) = k*dy;
end

% Left hand side

for k = 1:N
    elmleft(k,1) = 0;
    elmleft(k,2) = 0;
    elmleft(k,3) = (k-1)*dy;
    elmleft(k,4) = k*dy;
end

%bottom
for j = 1:2*length(bot(:,1))+1
    if mod(j,2) == 1
        if j==1
            dx = (bot((j-1)/2 +1) -1 )/N;
            for k = 1:N %straight elements
                elmbot(k,1) = (k-1)*dx;
                elmbot(k,2) = k*dx;
            end
        else
            dx=(bot((j-1)/2 +1,1) -bot((j-1)/2 -1,1) -2 )/N;
        end  
        for k = 1:N %straight elements
            elmbot(k,1) = bot((j-1)/2 -1,1)+1+(k-1)*dx;
            elmbot(k,2) = bot((j-1)/2 -1,1)+1+k*dx;
        end
    else 
        dt = -2*bot(j/2,2)/N;
        for k = 1:N %circular elements
            elmbot(k,1) = pi/2+bot(j/2,2)+(k-1)*dt;
            elmbot(k,2) = pi/2+bot(j/2,2)+(k)*dt;
        end
    end
end


% top

for j = 1:2*length(top(:,1))+1
    if isempty(top(:,1))
        dx = L/N;
        for k = 1:N
            elmtop(k,1) = (k-1)*dx;
            elmtop(k,2) = (k)*dx;
            elmtop(k,3) = H;
            elmtop(k,4) = H;
        end

    else
    if mod(j,2) == 1
        if j==1
            dx = (top((j-1)/2 +1) -1 )/N;
        else
            dx=(top((j-1)/2 +1,1) -top((j-1)/2 -1,1) -2 )/N;
        end  
        for k = 1:N
            elmtop(k,1) = top((j-1)/2 +1,1)+1+(k-1)*dx;
            elmtop(k,2) = top((j-1)/2 +1,1)+1+k*dx;
        end
    else 
        dt = 2*top(j/2,2)/N;
        for k = 1:N
            elmtop(k,1) = 3*pi/2-top(j/2,2)+(k-1)*dt;
            elmtop(k,2) = 3*pi/2-top(j/2,2)+(k)*dt;
        end
    end
    end
end


end
