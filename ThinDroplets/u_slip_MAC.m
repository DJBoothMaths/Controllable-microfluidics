function ubot = u_slip_MAC(c,N,L,Abot)
    ubot = zeros(N,1);
   
    dx = L/N;
    for i = 2:N-1
        if Abot(i)~=0
        ubot(i) = (c(i+1)-c(i-1))/(2*dx);
        end
    end
    

end
