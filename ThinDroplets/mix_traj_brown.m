function [strobex,strobey] = strobe_brown(Nint,L,H, xst,yst, tend, dt,tsep,D)

Nt = tend/dt;
Ntsep = tsep/dt;

Ntt =tend/tsep;




xtraj(1) = xst;
ytraj(1) = yst;

strobex = zeros(floor(Ntt),1);
strobey = zeros(floor(Ntt),1);


for j=1:Ntt
    if mod(j,2)==1
        load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/3drop-1.mat','U','V');
        for i =1:Ntsep
            ux1 = U(round(ytraj(Ntsep*(j-1)+i)*Nint/H), round(xtraj(Ntsep*(j-1)+i)*Nint/L));
            uy1 = V(round(ytraj(Ntsep*(j-1)+i)*Nint/H), round(xtraj(Ntsep*(j-1)+i)*Nint/L));
            xtraj(Ntsep*(j-1)+i+1) = xtraj(Ntsep*(j-1)+i) + (ux1+sqrt(2*D)*randn(1))*dt;
            ytraj(Ntsep*(j-1)+i+1) = ytraj(Ntsep*(j-1)+i) + (uy1+sqrt(2*D)*randn(1))*dt;
        end
    else
        load('/Users/danielbooth/Documents/Warwick/MATLAB/BEM/ThinDroplets/MAT_files/3drop-2.mat','U','V');
        for i =1:Ntsep
            ux1 = U(round(ytraj(Ntsep*(j-1)+i)*Nint/H), round(xtraj(Ntsep*(j-1)+i)*Nint/L));
            uy1 = V(round(ytraj(Ntsep*(j-1)+i)*Nint/H), round(xtraj(Ntsep*(j-1)+i)*Nint/L));
            xtraj(Ntsep*(j-1)+i+1) = xtraj(Ntsep*(j-1)+i) + (ux1+sqrt(2*D)*randn(1))*dt;
            ytraj(Ntsep*(j-1)+i+1) = ytraj(Ntsep*(j-1)+i) + (uy1+sqrt(2*D)*randn(1))*dt;
        end
    end
end


end
