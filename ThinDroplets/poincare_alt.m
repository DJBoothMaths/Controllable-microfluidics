function [strobex,strobey] = poincare_alt(Nint,L,H, xst,yst, tend, dt,tsep,U1,V1,U2,V2,trajs)

Ntsep = tsep/dt;

Ntt =tend/tsep;






strobex = zeros(floor(Ntt)*trajs,1);
strobey = zeros(floor(Ntt)*trajs,1);

theta=0:2*pi/10:2*pi-2*pi/10;
r = 0.01:0.01:0.1;



for j =1:trajs
    if j==1
        x=xst;
        y=yst;
    elseif j==11
        x = xst+r(1)*cos(theta(1));
        y = yst+r(1)*sin(theta(1));
        elseif j==101
        x = xst+r(10)*cos(theta(10));
        y = yst+r(10)*sin(theta(10));
    else 
        l=j-1;
    x = xst+r(1+floor(l/10))*cos(theta(1+mod(l,10)));
    y = yst+r(1+floor(l/10))*sin(theta(1+mod(l,10)));
    end
for k=1:Ntt
    if mod(k,2)==1 
        ux1= U1(round(y*Nint/H), round(x*Nint/L));
        uy1= V1(round(y*Nint/H), round(x*Nint/L));
        x_1 = x;
        y_1 = y;
        x = x_1 + (ux1)*dt;
        y = y_1 + (uy1)*dt;
        for i =2:Ntsep
            ux1 = U1(round(y*Nint/H), round(x*Nint/L));
            uy1 = V1(round(y*Nint/H), round(x*Nint/L));
            ux2 = U1(round(y_1*Nint/H), round(x_1*Nint/L));
            uy2 = V1(round(y_1*Nint/H), round(x_1*Nint/L));
            x_1 = x;
            y_1 = y;
            x = x_1 + (3*ux1-ux2)*dt/2;
            y = y_1 + (3*uy1-uy2)*dt/2;
        end
    else
        
        ux1= U2(round(y*Nint/H), round(x*Nint/L));
        uy1= V2(round(y*Nint/H), round(x*Nint/L));
        x_1 = x;
        y_1 = y;
        x = x + (ux1)*dt;
        y = y + (uy1)*dt;
        for i =2:Ntsep
            ux1 = U2(round(y*Nint/H), round(x*Nint/L));
            uy1 = V2(round(y*Nint/H), round(x*Nint/L));
            ux2 = U2(round(y_1*Nint/H), round(x_1*Nint/L));
            uy2 = V2(round(y_1*Nint/H), round(x_1*Nint/L));
            x_1 = x;
            y_1 = y;
            x = x_1 + (3*ux1-ux2)*dt/2;
            y = y_1 + (3*uy1-uy2)*dt/2;
        end
    end
    strobex((j-1)*Ntt+k)=x;
    strobey((j-1)*Ntt+k)=y;
end
end


end
