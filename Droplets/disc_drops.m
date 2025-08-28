function [elmx,elmy,midx,midy] = disc_drops(N,L,H, bot, top)

% Discretise domain boundary
% N number of points per wall
% L x length
% h y height
% bot centre of droplets along bottom and contact angles listed left to
% right
% top ^ along top and contact angles listed right to left

if length(top)==0
    Ntot  = (2*length(bot(:,1))+4)*N;
else
Ntot  = (2*length(bot(:,1))+2*length(top(:,1))+4)*N;    % Total number of elements
end

dy= H/(N); %element length in y

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
elmx = zeros(Ntot,2);
elmy = zeros(Ntot,2); 

%bottom
for j = 1:2*length(bot(:,1))+1
    if mod(j,2) == 1
        if j==1
            dx = (bot((j-1)/2 +1) -1 )/(N);
            for k = 1:N %straight elements
                elmx(k,1) = (k-1)*dx;
                elmx(k,2) = k*dx;
            end
        elseif j<2*length(bot(:,1))+1
            dx=(bot((j-1)/2 +1,1) -bot((j-1)/2,1) -2 )/(N);
            for k = (j-1)*N+1:j*N %straight elements
                k1 = k-(j-1)*N;
                elmx(k,1) = bot((j-1)/2 ,1)+1+(k1-1)*dx;
                elmx(k,2) = bot((j-1)/2 ,1)+1+k1*dx;
            end
        else
            dx=(L -bot((j-1)/2,1) -1 )/(N);
            for k = (j-1)*N+1:j*N %straight elements
                k1 = k-(j-1)*N;
                elmx(k,1) = bot((j-1)/2 ,1)+1+(k1-1)*dx;
                elmx(k,2) = bot((j-1)/2 ,1)+1+k1*dx;
            end
        end  
        
    else 
        dx = 2/(N);
        for k = (j-1)*N+1:j*N %circular elements
            k1 = k-(j-1)*N;
            elmx(k,1) = bot(j/2,1)-1+(k1-1)*dx;
            elmx(k,2) = bot(j/2,1)-1+(k1)*dx;
            elmy(k,1) = -cot(bot(j/2,2))+sqrt(csc(bot(j/2,2))^2-(-1+(k1-1)*dx)^2);
            elmy(k,2) = -cot(bot(j/2,2))+sqrt(csc(bot(j/2,2))^2-(-1+(k1)*dx)^2);

        end
    end
end


% Right hand side

for k = (2*length(bot(:,1))+1)*N+1:(2*length(bot(:,1))+2)*N
    k2 = k-(2*length(bot(:,1))+1)*N;
    elmx(k,1) = L;
    elmx(k,2) = L;
    elmy(k,1) = (k2-1)*dy;
    elmy(k,2) = k2*dy;
end

% top


if length(top)==0
    dx = L/(N);
    for k = (2*length(bot(:,1))+2)*N+1:(2*length(bot(:,1))+3)*N
        k3 = k-(2*length(bot(:,1))+2)*N;
        elmx(k,1) = L-(k3-1)*dx;
        elmx(k,2) = L-(k3)*dx;
        elmy(k,1) = H;
        elmy(k,2) = H;
    end

else
    for j = 1:2*length(top(:,1))+1
    if mod(j,2) == 1
        if j==1
            dx = (L-(top((j-1)/2 +1) +1))/(N-1);
            for k = (2*length(bot(:,1))+2)*N+1:(2*length(bot(:,1))+3)*N
                k3 = k-(2*length(bot(:,1))+2)*N;
                elmx(k,1) = L-(k3-1)*dx;
                elmx(k,2) = L-k3*dx;
                elmy(k,1) = H;
                elmy(k,2) = H;
            end
        elseif j<2*length(top(:,1))+1
            dx=(top((j-1)/2 ,1) -top((j-1)/2 +1,1) -2 )/(N-1);
            for k = (2*length(bot(:,1))+2+j-1)*N+1:(2*length(bot(:,1))+2+j)*N
                k3 = k-(2*length(bot(:,1))+2+j-1)*N;
                elmx(k,1) = top((j-1)/2 ,1)-1-(k3-1)*dx;
                elmx(k,2) = top((j-1)/2 ,1)-1-(k3)*dx;
                elmy(k,1) = H;
                elmy(k,2) = H;
            end
        else
            dx=(top((j-1)/2,1) -1)/(N-1);
            for k = (2*length(bot(:,1))+2+j-1)*N+1:(2*length(bot(:,1))+2+j)*N
                k3 = k-(2*length(bot(:,1))+2+j-1)*N;
                elmx(k,1) = top((j-1)/2,1)-1-(k3-1)*dx;
                elmx(k,2) = top((j-1)/2,1)-1-(k3)*dx;
                elmy(k,1) = H;
                elmy(k,2) = H;
            end
        end  
        
    else 
        dx=2/(N-1);
        for k = (2*length(bot(:,1))+2+j-1)*N+1:(2*length(bot(:,1))+2+j)*N
            k3 = k-(2*length(bot(:,1))+2+j-1)*N;
            elmx(k,1) = top((j)/2,1)+1-(k3-1)*dx;
            elmx(k,2) = top((j)/2,1)+1-(k3)*dx;
            elmy(k,1) = H+cot(top(j/2,2))-sqrt(csc(top(j/2,2))^2-(1-(k3-1)*dx)^2);
            elmy(k,2) = H+cot(top(j/2,2))-sqrt(csc(top(j/2,2))^2-(1-(k3)*dx)^2);
        end
    end
    end
end

% Left hand side

for k = Ntot-N+1:Ntot
    k2 = k-Ntot+N;
    elmx(k,1) = 0;
    elmx(k,2) = 0;
    elmy(k,1) = H-(k2-1)*dy;
    elmy(k,2) = H-k2*dy;
end

% Find midpoints
midx = zeros(Ntot,1);
midy = zeros(Ntot,1);

for i=1:Ntot
    midx(i) = 0.5*(elmx(i,2)+elmx(i,1));
    midy(i) = 0.5*(elmy(i,2)+elmy(i,1));
end

 %Plot elements

 plot(elmx(:,1),elmy(:,1),'-o')
  hold on
 plot(elmx(:,2),elmy(:,2),'-o')
 
 plot(midx(:,1),midy(:,1),'-x')
 axis([-0.5 L+0.5 -0.5 H+0.5])
end