function f = stokes_BEM_one_drop(N,L,H,ubot,utop)

f = zeros(4*N,2); % tractions


[elmx,elmy,midx,midy] = disc_rect(N,L,H);

%Form RHS matrix, this is formed of the slp

SLxx = zeros(4*N);
SLxy = zeros(4*N);
SLyx = zeros(4*N);
SLyy = zeros(4*N);
DLxx = zeros(4*N);
%DLxy = zeros(4*N);
DLyx = zeros(4*N);
%DLyy = zeros(4*N);

for i=1:4*N
    for j =1:4*N
        if i==j
            [SLxx(i,j),SLxy(i,j),SLyx(i,j),SLyy(i,j),DLxx(i,j),~,DLyx(i,j),~] = stokes_sdlp(midx(i), midy(i), elmx(j,1), elmy(j,1), elmx(j,2), elmy(j,2), 8, 1);
        else
            [SLxx(i,j),SLxy(i,j),SLyx(i,j),SLyy(i,j),DLxx(i,j),~,DLyx(i,j),~] = stokes_sdlp(midx(i), midy(i), elmx(j,1), elmy(j,1), elmx(j,2), elmy(j,2), 8, 0);
        end
    end
end

Mat = [SLxx, SLxy; SLyx, SLyy]/(2*pi);
%Form vector
% We know U so this is formed of the dlp

b = zeros(4*N,1);
 
for i=1:N
    b(i) =ubot(i);
    b(3*N+1-i) = utop(i);
end 

rhsu = (DLxx/(2*pi) - eye(4*N))*b;

rhsstokes = [rhsu; (DLyx/(2*pi))*b];


F = Mat\rhsstokes;

for i=1:4*N
    f(i,1) = F(i);
    f(i,2) = F(4*N+i);
end
end