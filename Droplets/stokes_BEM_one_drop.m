function f = stokes_BEM_one_drop(N,L,H,ubot,vbot, drop_centre,theta)

f = zeros(4*N,2); % tractions


[elmx,elmy,midx,midy] = disc_one_drop(N,L,H, drop_centre,theta);

%Form RHS matrix, this is formed of the slp

SLxx = zeros(4*N);
SLxy = zeros(4*N);
SLyx = zeros(4*N);
SLyy = zeros(4*N);
DLxx = zeros(4*N);
DLxy = zeros(4*N);
DLyx = zeros(4*N);
DLyy = zeros(4*N);

for i=1:4*N
    for j =1:4*N
        if i==j
            [SLxx(i,j),SLxy(i,j),SLyx(i,j),SLyy(i,j),DLxx(i,j),DLxy(i,j),DLyx(i,j),DLyy(i,j)] = stokes_sdlp(midx(i), midy(i), elmx(j,1), elmy(j,1), elmx(j,2), elmy(j,2), 8, 1);
        else
            [SLxx(i,j),SLxy(i,j),SLyx(i,j),SLyy(i,j),DLxx(i,j),DLxy(i,j),DLyx(i,j),DLyy(i,j)] = stokes_sdlp(midx(i), midy(i), elmx(j,1), elmy(j,1), elmx(j,2), elmy(j,2), 8, 0);
        end
    end
end

Mat = [SLxx, SLxy; SLyx, SLyy]/(2*pi);
%Form vector
% We know U so this is formed of the dlp

b = zeros(8*N,1);
 
for i=1:N
    b(i) =ubot(i);
    b(4*N+i) = vbot(i);
end 

Matrhs = [DLxx- 2*pi*eye(4*N), DLxy; DLyx, DLyy- 2*pi*eye(4*N)]/(2*pi);



rhsstokes = Matrhs*b;


F = Mat\rhsstokes;


for i=1:4*N
    f(i,1) = F(i);
    f(i,2) = F(4*N+i);
end
end