function [xtraj,ytraj] = two_drop_mix_traj_inter(N,L,H, xst,yst, tend, dt,tsep)

Nt = tend/dt;
Ntsep = tsep/dt;

Ntt =tend/tsep;




xtraj(1) = xst;
ytraj(1) = yst;




for j=1:Ntt
    if mod(j,2)==1
        load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/3drop-1.mat','U','V');
        ux= U(round(ytraj(Ntsep*(j-1)+1)*Nint/H), round(xtraj(Ntsep*(j-1)+1)*Nint/L));
        uy= V(round(ytraj(Ntsep*(j-1)+1)*Nint/H), round(xtraj(Ntsep*(j-1)+1)*Nint/L));
        xtraj(Ntsep*(j-1)+2) = xtraj(Ntsep*(j-1)+1) + (ux1)*dt;
        ytraj(Ntsep*(j-1)+2) = ytraj(Ntsep*(j-1)+1) + (uy1)*dt;
        for i =2:Ntsep
            ux1 = U(round(ytraj(Ntsep*(j-1)+i)*Nint/H), round(xtraj(Ntsep*(j-1)+i)*Nint/L));
            uy1 = V(round(ytraj(Ntsep*(j-1)+i)*Nint/H), round(xtraj(Ntsep*(j-1)+i)*Nint/L));
            ux2 = U(round(ytraj(Ntsep*(j-1)+i-1)*Nint/H), round(xtraj(Ntsep*(j-1)+i-1)*Nint/L));
            uy2 = V(round(ytraj(Ntsep*(j-1)+i-1)*Nint/H), round(xtraj(Ntsep*(j-1)+i-1)*Nint/L));
            xtraj(Ntsep*(j-1)+i+1) = xtraj(Ntsep*(j-1)+i) + (3*ux1-ux2)*dt/2;
            ytraj(Ntsep*(j-1)+i+1) = ytraj(Ntsep*(j-1)+i) + (3*uy1-uy2)*dt/2;
        end
    else
        load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/3drop-2.mat','U','V');
        ux= U(round(ytraj(Ntsep*(j-1)+1)*Nint/H), round(xtraj(Ntsep*(j-1)+1)*Nint/L));
        uy= V(round(ytraj(Ntsep*(j-1)+1)*Nint/H), round(xtraj(Ntsep*(j-1)+1)*Nint/L));
        xtraj(Ntsep*(j-1)+2) = xtraj(Ntsep*(j-1)+1) + (ux1)*dt;
        ytraj(Ntsep*(j-1)+2) = ytraj(Ntsep*(j-1)+1) + (uy1)*dt;
        for i =2:Ntsep
            ux1 = U(round(ytraj(Ntsep*(j-1)+i)*Nint/H), round(xtraj(Ntsep*(j-1)+i)*Nint/L));
            uy1 = V(round(ytraj(Ntsep*(j-1)+i)*Nint/H), round(xtraj(Ntsep*(j-1)+i)*Nint/L));
            ux2 = U(round(ytraj(Ntsep*(j-1)+i-1)*Nint/H), round(xtraj(Ntsep*(j-1)+i-1)*Nint/L));
            uy2 = V(round(ytraj(Ntsep*(j-1)+i-1)*Nint/H), round(xtraj(Ntsep*(j-1)+i-1)*Nint/L));
            xtraj(Ntsep*(j-1)+i+1) = xtraj(Ntsep*(j-1)+i) + (3*ux1-ux2)*dt/2;
            ytraj(Ntsep*(j-1)+i+1) = ytraj(Ntsep*(j-1)+i) + (3*uy1-uy2)*dt/2;
        end
    end
end


end
