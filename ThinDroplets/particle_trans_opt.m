function [time, xtraj, ytraj] = particle_trans_opt(xst,yst,xend, L, H, dt,Nint,diff)
%opt==1 fully discrete droplet positions 2<x<4,4<x<6,... 
xtraj(1) = xst;
ytraj(1) = yst;


total =2;

for j=1:(L-2)/2-1
    %drop setup
    drop_centre = 2*j+1;
    filename = sprintf('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/dropbot-%d.mat', drop_centre);
    load(filename,'U','V')
        ux= U(round(ytraj(total-1)*Nint/H), round(xtraj(total-1)*Nint/L));
        uy= V(round(ytraj(total-1)*Nint/H), round(xtraj(total-1)*Nint/L));
        xtraj(total) = xtraj(total-1) + (ux)*dt;
        ytraj(total) = ytraj(total-1) + (uy)*dt;
            
    for i=1:10000
        if xtraj(total+i-1)<drop_centre-diff
            %compute movement of particle
        ux1 = U(round(ytraj(total+i-1)*Nint/H), round(xtraj(total+i-1)*Nint/L));
        uy1 = V(round(ytraj(total+i-1)*Nint/H), round(xtraj(total+i-1)*Nint/L));
        ux2 = U(round(ytraj(total+i-2)*Nint/H), round(xtraj(total+i-2)*Nint/L));
        uy2 = V(round(ytraj(total+i-2)*Nint/H), round(xtraj(total+i-2)*Nint/L));
        xtraj(total+i) = xtraj(total+i-1) + (3*ux1-ux2)*dt/2;
        ytraj(total+i) = ytraj(total+i-1) + (3*uy1-uy2)*dt/2;
        else 
            total = total+i;
            break
        end
    end
end
if xtraj(total)<xend
    for i=1:50000   
        %compute movement of particle
        ux1 = U(round(ytraj(total+i-1)*Nint/H), round(xtraj(total+i-1)*Nint/L));
        uy1 = V(round(ytraj(total+i-1)*Nint/H), round(xtraj(total+i-1)*Nint/L));
        ux2 = U(round(ytraj(total+i-2)*Nint/H), round(xtraj(total+i-2)*Nint/L));
        uy2 = V(round(ytraj(total+i-2)*Nint/H), round(xtraj(total+i-2)*Nint/L));
        xtraj(total+i) = xtraj(total+i-1) + (3*ux1-ux2)*dt/2;
        ytraj(total+i) = ytraj(total+i-1) + (3*uy1-uy2)*dt/2;
        if xtraj(total+i)>xend
            break
        end
    end
    time = (total+i)*dt;
end


end