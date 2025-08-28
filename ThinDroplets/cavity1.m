%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cavity.m
%
% To solve the driven cavity problem
% discussed in lectures
%
% M G Blyth September 2010
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all


%%%%%
% Discretise domain 
% boundary
%%%%%

Ni = 16;       % Number of elements per side
N  = 4*Ni;    % Total number of elements

L = 10.0;   % square box size

h = L/Ni;  % element length

mu = 1.0;  % Fluid viscosity
U(1,1:Ni)  = 0.0; 
U(1,floor(0.375*L/h):floor(0.625*L/h))=5;% Lid velocity

%%%%
% Number elements starting from
% left end of lid, and assign 
% coordinates
%
% elmx(k,1/2) : x coord of start (0) or end (1) 
%                 of element k
%
% elmy(k,1/2) : y coord of start (0) or end (1) 
%                 of element k
%%%%

% Lid

for k = 1:Ni
    elmx(k,1) = (k-1)*h;
    elmx(k,2) = k*h;
    elmy(k,1) = L;
    elmy(k,2) = L;
end

% Right hand side

for k = Ni+1:2*Ni
    k2 = k-Ni;
    elmx(k,1) = L;
    elmx(k,2) = L;
    elmy(k,1) = L-(k2-1)*h;
    elmy(k,2) = L-k2*h;
end

% Bottom

for k = 2*Ni+1:3*Ni
    k2 = k-2*Ni;
    elmx(k,1) = L-(k2-1)*h;
    elmx(k,2) = L-k2*h;
    elmy(k,1) = 0;
    elmy(k,2) = 0;
end

% Left hand side

for k = 3*Ni+1:4*Ni
    k2 = k-3*Ni;
    elmx(k,1) = 0;
    elmx(k,2) = 0;
    elmy(k,1) = (k2-1)*h;
    elmy(k,2) = k2*h;
end

% Plot elements

plot(elmx(:,1),elmy(:,1),'-o')
hold on
plot(elmx(:,2),elmy(:,2),'-o')
axis([-0.5 L+0.5 -0.5 L+0.5])

%print -depsc boxelms.eps
%%
%%%%%%
% Loop over mid-point 
% locations for singular point
%%%%%%

for ik=1:N

    x0(ik) = 0.5*(elmx(ik,1)+elmx(ik,2));
    y0(ik) = 0.5*(elmy(ik,1)+elmy(ik,2));

%%%%%%%%
% Compute integrals
% of Green's function over
% elements for present
% location of (x0,y0)
%%%%%%%%

    for k=1:N

        x1 = elmx(k,1);
        x2 = elmx(k,2);
        y1 = elmy(k,1);
        y2 = elmy(k,2);

        if k<=Ni                  ielm = 0;  end   % horizontal element
        if (k>Ni)   && (k<=2*Ni)  ielm = 1;  end   % vertical element
        if (k>2*Ni) && (k<=3*Ni)  ielm = 0;  end
        if (k>3*Ni) && (k<=4*Ni)  ielm = 1;  end

        [eint] = elmint(ielm,x1,x2,y1,y2,x0(ik),y0(ik));


        for i=1:2
            for j=1:2
                   minf(ik,k,i,j) = eint(i,j)/(4*pi*mu);
            end
        end
    
    end


%%%%
% Compute DLP term
%%%%

    dlpsum(1) = 0;
    dlpsum(2) = 0;
    for k=1:Ni
        x1 = elmx(k,1);
        x2 = elmx(k,2);
        y1 = elmy(k,1);
        y2 = elmy(k,2);

        [dlp] = dlpint(x1,x2,y1,y2,x0(ik),y0(ik));
        dlpsum(1) = dlpsum(1) + (1/(4*pi))*U(k)*dlp(1);
        dlpsum(2) = dlpsum(2) + (1/(4*pi))*U(k)*dlp(2);
    end

    ik2 = 2*ik-1;
    dd(ik2)   = dlpsum(1);
    dd(ik2+1) = dlpsum(2);

end


plot(x0,y0,'or')
%%
%%%
% Build the linear system Ax=b
%%%

for ik=1:N
    ik2 = 2*ik-1;
    for k=1:N
        k2 = 2*k-1;
        A(ik2,k2)     = minf(ik,k,1,1);
        A(ik2,k2+1)   = minf(ik,k,1,2);
        A(ik2+1,k2)   = minf(ik,k,2,1);
        A(ik2+1,k2+1) = minf(ik,k,2,2);
    end
end

%%%%
% Construct the RHS
%%%%

for ik=1:N/4
    ik2 = 2*ik-1;
    c1(ik2)   = 1;
    c1(ik2+1) = 0;
end
for ik=1:3*N/4
    ik2 = 2*ik-1;
    c2(ik2)   = 0;
    c2(ik2+1) = 0;
end

b = dd' - 0.5.*U.*[c1 c2]';

x = A\b;

%%%%%
% Back out the element
% tractions
%%%%%

fx = x(1:2:2*N);        % Contains x component of traction at each element
fy = x(2:2:2*N+1);      % Contains y component of traction at each element


%%%%
% Plot the tractions
% against arc length around
% boundary
%%%%

s(1) = x0(1);
for i=2:N
    s(i) = s(i-1)+h;    % Arc length
end

figure
plot(s,fx')
hold on
plot(s,fy','r')
xlabel('s')
ylabel('f')
legend('fx','fy','Location','NorthWest');

%print -depsc tracs.eps

%%%%%
% Compute the velocity along a line
% in the flow
%%%%%

x00 = 3*L/4;
eps = 0.05*L;
Ny0 = 20;
dy0 = (L-2*eps)/(Ny0-1);

for im=1:Ny0

    y00 = eps + (im-1)*dy0;
    y0v(im) = y00;
    
    ux = 0;
    uy = 0;
    cons(1) = 0;
    cons(2) = 0;
    for k=1:N
        x1 = elmx(k,1);
        x2 = elmx(k,2);
        y1 = elmy(k,1);
        y2 = elmy(k,2);

        if k<=Ni                  ielm = 0;  end   % horizontal element
        if (k>Ni)   && (k<=2*Ni)  ielm = 1;  end   % vertical element
        if (k>2*Ni) && (k<=3*Ni)  ielm = 0;  end
        if (k>3*Ni) && (k<=4*Ni)  ielm = 1;  end

        [eint] = elmint(ielm,x1,x2,y1,y2,x00,y00);

        ux = ux - (1/(4*pi*mu))*(eint(1,1)*fx(k) + eint(2,1)*fy(k));
        uy = uy - (1/(4*pi*mu))*(eint(1,2)*fx(k) + eint(2,2)*fy(k));
   
    % Check conservation of mass
    
        if k<=Ni                  cons(1) = cons(1) - eint(1,2); cons(2) = cons(2) - eint(2,2);  end 
        if (k>Ni)   && (k<=2*Ni)  cons(1) = cons(1) - eint(1,1); cons(2) = cons(2) - eint(2,1);  end
        if (k>2*Ni) && (k<=3*Ni)  cons(1) = cons(1) + eint(1,2); cons(2) = cons(2) + eint(2,2);  end
        if (k>3*Ni) && (k<=4*Ni)  cons(1) = cons(1) + eint(1,1); cons(2) = cons(2) + eint(2,1);  end
    
    end
    
%%%%
% Compute DLP term
%%%%

    dlpsum(1) = 0;
    dlpsum(2) = 0;
    for k=1:Ni
        x1 = elmx(k,1);
        x2 = elmx(k,2);
        y1 = elmy(k,1);
        y2 = elmy(k,2);

        [dlp] = dlpint(x1,x2,y1,y2,x00,y00);
        dlpsum(1) = dlpsum(1) + (1/(4*pi))*U(k)*dlp(1);
        dlpsum(2) = dlpsum(2) + (1/(4*pi))*U(k)*dlp(2);
    end

    ux = ux + dlpsum(1);
    uy = uy + dlpsum(2);
    
    uxv(im) = ux;
    uyv(im) = uy;

end

figure
plot(y0v,uxv,'-o')
hold on
plot(y0v,uyv,'-ro')
xlabel('y')
ylabel('u')
legend('ux','uy','Location','NorthWest');

%print -depsc vels.eps

%%%%%%%
% Compute a streamline
%%%%%%%

xst(1) = L/2;             % Starting point on streamline
yst(1) = 0.9*L;

tend = 50.0;
dt   = 0.01;
t    = 0.d0;
im   = 1;

while t < tend

        ux = 0;
        uy = 0;
        for k=1:N
            x1 = elmx(k,1);
            x2 = elmx(k,2);
            y1 = elmy(k,1);
            y2 = elmy(k,2);

            if k<=Ni                  ielm = 0;  end   % horizontal element
            if (k>Ni)   && (k<=2*Ni)  ielm = 1;  end   % vertical element
            if (k>2*Ni) && (k<=3*Ni)  ielm = 0;  end
            if (k>3*Ni) && (k<=4*Ni)  ielm = 1;  end

            [eint] = elmint(ielm,x1,x2,y1,y2,xst(im),yst(im));

            ux = ux - (1/(4*pi*mu))*(eint(1,1)*fx(k) + eint(2,1)*fy(k));
            uy = uy - (1/(4*pi*mu))*(eint(1,2)*fx(k) + eint(2,2)*fy(k));
        end
    
%%%%
% Compute DLP term
%%%%

        dlpsum(1) = 0;
        dlpsum(2) = 0;
        for k=1:Ni
            x1 = elmx(k,1);
            x2 = elmx(k,2);
            y1 = elmy(k,1);
            y2 = elmy(k,2);

            [dlp] = dlpint(x1,x2,y1,y2,xst(im),yst(im));
            dlpsum(1) = dlpsum(1) + (1/(4*pi))*U(k)*dlp(1);
            dlpsum(2) = dlpsum(2) + (1/(4*pi))*U(k)*dlp(2);
        end

        ux = ux + dlpsum(1);
        uy = uy + dlpsum(2);
   
% Step forward using Euler's method (NB: much better to do Runge Kutta 2)       
        
        xst(im+1) = xst(im) + dt*ux;
        yst(im+1) = yst(im) + dt*uy;
        
        t  = t + dt;
        im = im + 1;
end
    
    
figure
plot(elmx(:,1),elmy(:,1),'-')
hold on
plot(elmx(:,2),elmy(:,2),'-')
plot(xst,yst,'--')
axis([-0.5 L+0.5 -0.5 L+0.5])

%print -depsc strms.eps