function [ubot, utop] = u_slip_alt(c,N,L,Abot,Atop, M, Opt)
    ubot = zeros(N,1);
    utop = zeros(N,1);

    dx = L/N;
    if Opt == 1 % droplets along top
    
    for i = 2:N-1
        if Abot(i)~=0
        ubot(i) = (c(i+1)-c(i-1))/(2*dx);
        end
        if Atop(i)~=0
        utop(i) = (c(3*N+1-(i+1))-c(3*N+1-(i-1)))/(2*dx);
        end
    end
    ubot = M(1)*ubot;
    utop = M(2)*utop;
    else % no droplets along top 
    for i = 2:N-1
        if Abot(i)~=0
        ubot(i) = (c(i+1)-c(i-1))/(2*dx);
        end
    end
    end

end
