function [time, xtraj, ytraj] = particle_trans_discrete_inter(xst,yst,xend, L, H,tsep, dt,Nint,opt)
%opt==1 fully discrete droplet positions 2<x<4,4<x<6,... 
%opt==2 fully discrete droplet positions 1<x<3,3<x<5,... 

xtraj(1) = xst;
ytraj(1) = yst;



Nt = floor(tsep/dt);

for j=1:(L-2)/2-1
    %drop setup
    drop_centre = 2*j+1;
    if opt==1
    filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/dropbot-%d.mat', drop_centre);
    load(filename,'U','V')
    else
       filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/dropbottop-%d.mat', drop_centre);
    load(filename,'U','V') 
    U=-U;
    V=-V;
    end
        ux= U(round(ytraj(Nt*(j-1)+1)*Nint/H), round(xtraj(Nt*(j-1)+1)*Nint/L));
        uy= V(round(ytraj(Nt*(j-1)+1)*Nint/H), round(xtraj(Nt*(j-1)+1)*Nint/L));
        xtraj(Nt*(j-1)+2) = xtraj(Nt*(j-1)+1) + (ux)*dt;
        ytraj(Nt*(j-1)+2) = ytraj(Nt*(j-1)+1) + (uy)*dt;

    for i=2:Nt
    
        %compute movement of particle
        ux1 = U(round(ytraj(Nt*(j-1)+i)*Nint/H), round(xtraj(Nt*(j-1)+i)*Nint/L));
        uy1 = V(round(ytraj(Nt*(j-1)+i)*Nint/H), round(xtraj(Nt*(j-1)+i)*Nint/L));
        ux2 = U(round(ytraj(Nt*(j-1)+i-1)*Nint/H), round(xtraj(Nt*(j-1)+i-1)*Nint/L));
        uy2 = V(round(ytraj(Nt*(j-1)+i-1)*Nint/H), round(xtraj(Nt*(j-1)+i-1)*Nint/L));
        xtraj(Nt*(j-1)+i+1) = xtraj(Nt*(j-1)+i) + (3*ux1-ux2)*dt/2;
        ytraj(Nt*(j-1)+i+1) = ytraj(Nt*(j-1)+i) + (3*uy1-uy2)*dt/2;
        if xtraj(Nt*(j-1)+i+1)>xend
            break
        end
    end
end
if xtraj(Nt*(j-1)+i+1)<xend
    for i=1:50000   
        j=(L-2)/2;
        %compute movement of particle
        ux1 = U(round(ytraj(Nt*(j-1)+i)*Nint/H), round(xtraj(Nt*(j-1)+i)*Nint/L));
        uy1 = V(round(ytraj(Nt*(j-1)+i)*Nint/H), round(xtraj(Nt*(j-1)+i)*Nint/L));
        ux2 = U(round(ytraj(Nt*(j-1)+i-1)*Nint/H), round(xtraj(Nt*(j-1)+i-1)*Nint/L));
        uy2 = V(round(ytraj(Nt*(j-1)+i-1)*Nint/H), round(xtraj(Nt*(j-1)+i-1)*Nint/L));
        xtraj(Nt*(j-1)+i+1) = xtraj(Nt*(j-1)+i) + (3*ux1-ux2)*dt/2;
        ytraj(Nt*(j-1)+i+1) = ytraj(Nt*(j-1)+i) + (3*uy1-uy2)*dt/2;
        if xtraj(Nt*(j-1)+i+1)>xend
            break
        end
    end
end
time = (Nt*j+i)*dt;

end