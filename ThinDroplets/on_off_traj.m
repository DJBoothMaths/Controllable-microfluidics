function [xtraj,ytraj] = on_off_traj(N,L,H, xst,yst, tend, dt,D,tsep)

Nt = tend/dt;
Ntsep = tsep/dt;

Abot = zeros(N,1);
Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

xtraj(1) = xst;
ytraj(1) = yst;

[c, ~] = laplace_BEM_2d(N,L,H,Abot,Atop);
[ubot, utop] = u_slip(c,N,L,  [1 1], 0);
f = stokes_BEM_2d(N,L,H,ubot,utop);

switches = Nt/Ntsep;
% First iteration Forward-Euler
for i=2:Nt+1
    if mod(floor(i/Ntsep),2) == 0
        [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f, ubot, utop);
        xtraj(i) = xtraj(i-1) + (ux1)*dt+ sqrt(2*D)*randn(1)*dt;
        ytraj(i) = ytraj(i-1) + (uy1)*dt+ sqrt(2*D)*randn(1)*dt;
    else
        xtraj(i) = xtraj(i-1) + sqrt(2*D)*randn(1)*dt;
        ytraj(i) = ytraj(i-1) +sqrt(2*D)*randn(1)*dt;
    end
    if (ytraj(i)<0)
        break
    end
    if (ytraj(i)>H)
        break
    end
    if (xtraj(i)<0)
        break
    end
    if (xtraj(i)>L)
        break
    end

end

end
