function f = stokes_BEM_drops(N,L,H,bot, top,ubot,utop,vbot,vtop)

if length(top)==0
    Ntot  = (2*length(bot(:,1))+4)*N;
else
    Ntot  = (2*length(bot(:,1))+2*length(top(:,1))+4)*N;    % Total number of elements
end

f = zeros(4*Ntot,2); % tractions


[elmx,elmy,midx,midy] = disc_drops(N,L,H, bot, top);

%Form RHS matrix, this is formed of the slp

SLxx = zeros(Ntot);
SLxy = zeros(Ntot);
SLyx = zeros(Ntot);
SLyy = zeros(Ntot);
DLxx = zeros(Ntot);
DLxy = zeros(Ntot);
DLyx = zeros(Ntot);
DLyy = zeros(Ntot);

for i=1:Ntot
    for j =1:Ntot
        if i==j
            [SLxx(i,j),SLxy(i,j),SLyx(i,j),SLyy(i,j),DLxx(i,j),DLxy(i,j),DLyx(i,j),DLyy(i,j)] = stokes_sdlp(midx(i), midy(i), elmx(j,1), elmy(j,1), elmx(j,2), elmy(j,2), 20, 1);
        else
            [SLxx(i,j),SLxy(i,j),SLyx(i,j),SLyy(i,j),DLxx(i,j),DLxy(i,j),DLyx(i,j),DLyy(i,j)] = stokes_sdlp(midx(i), midy(i), elmx(j,1), elmy(j,1), elmx(j,2), elmy(j,2), 20, 0);
        end
    end
end

Mat = [SLxx, SLxy; SLyx, SLyy]/(2*pi);
%Form vector
% We know U so this is formed of the dlp



b = zeros(2*Ntot,1);
 
for i=1:(2*length(bot(:,1))+1)*N
    b(i) =ubot(i);
    b(Ntot+i)= vbot(i);
end 
for i=(2*length(bot(:,1))+2)*N+1:Ntot-N
    b(i) = utop(end-i+1);
    b(Ntot+i) = vtop(end-i+1);
end

Matrhs = [DLxx- 2*pi*eye(Ntot), DLxy; DLyx, DLyy- 2*pi*eye(Ntot)]/(2*pi);



rhsstokes = Matrhs*b;


F = Mat\rhsstokes;

for i=1:Ntot
    f(i,1) = F(i);
    f(i,2) = F(Ntot+i);
end
end