function [time, xtraj, ytraj] = phased(xst,yst,xend, L, H,tsep, dt,Nint)
%phased array transport

xtraj(1) = xst;
ytraj(1) = yst;



Nt = floor(tsep/dt);

for j=1:(L-5)
    %drop setup
    drop_centre = j+2;
    if mod(j,2)==1
        filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/dropbot-%d.mat', drop_centre);
    else
        filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/droptop-%d.mat', drop_centre);
    end
    load(filename,'U','V')

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
        j=L-4;
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