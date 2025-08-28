function [xtraj,ytraj] = two_drop_mix_traj(N,L,H, xst,yst, tend, dt,tsep)

Nt = tend/dt;
Ntsep = tsep/dt;

Ntt =tend/tsep;

Abot1 = zeros(N,1);
Abot1(0.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
Atop = zeros(N,1);

Abot2 = zeros(N,1);
Abot2(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1;


xtraj(1) = xst;
ytraj(1) = yst;

[c1, ~] = laplace_BEM_2d(N,L,H,Abot1,Atop);
[ubot1, utop1] = u_slip(c1,N,L,  [1 1], 0);
f1 = stokes_BEM_2d(N,L,H,ubot1,utop1);

[c2, ~] = laplace_BEM_2d(N,L,H,Abot2,Atop);
[ubot2, utop2] = u_slip(c2,N,L,  [1 1], 0);
f2 = stokes_BEM_2d(N,L,H,ubot2,utop2);


for j=1:Ntt
    if mod(j,2)==1
        [ux1,uy1] = flow_point(xtraj(Ntsep*(j-1)+1), ytraj(Ntsep*(j-1)+1), N,L,H, f1, ubot1, utop1);
        xtraj(Ntsep*(j-1)+2) = xtraj(Ntsep*(j-1)+1) + (ux1)*dt;
        ytraj(Ntsep*(j-1)+2) = ytraj(Ntsep*(j-1)+1) + (uy1)*dt;
        for i =2:Ntsep
            [ux1,uy1] = flow_point(xtraj(Ntsep*(j-1)+i), ytraj(Ntsep*(j-1)+i), N,L,H, f1, ubot1, utop1);
            [ux2,uy2] = flow_point(xtraj(Ntsep*(j-1)+i-1), ytraj(Ntsep*(j-1)+i-1), N,L,H, f1, ubot1, utop1);
            xtraj(Ntsep*(j-1)+i+1) = xtraj(Ntsep*(j-1)+i) + (3*ux1-ux2)*dt/2;
            ytraj(Ntsep*(j-1)+i+1) = ytraj(Ntsep*(j-1)+i) + (3*uy1-uy2)*dt/2;
        end
    else
        [ux1,uy1] = flow_point(xtraj(Ntsep*(j-1)+1), ytraj(Ntsep*(j-1)+1), N,L,H, f2, ubot2, utop2);
        xtraj(Ntsep*(j-1)+2) = xtraj(Ntsep*(j-1)+1) + (ux1)*dt;
        ytraj(Ntsep*(j-1)+2) = ytraj(Ntsep*(j-1)+1) + (uy1)*dt;
        for i =2:Ntsep
            [ux1,uy1] = flow_point(xtraj(Ntsep*(j-1)+i), ytraj(Ntsep*(j-1)+i), N,L,H, f2, ubot2, utop2);
            [ux2,uy2] = flow_point(xtraj(Ntsep*(j-1)+i-1), ytraj(Ntsep*(j-1)+i-1), N,L,H, f2, ubot2, utop2);
            xtraj(Ntsep*(j-1)+i+1) = xtraj(Ntsep*(j-1)+i) + (3*ux1-ux2)*dt/2;
            ytraj(Ntsep*(j-1)+i+1) = ytraj(Ntsep*(j-1)+i) + (3*uy1-uy2)*dt/2;
        end
    end
end









% % First iteration Forward-Euler
% for i=2:Nt+1
%     if mod(floor(i/Ntsep),2) == 0
%         if i==2
%             [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f1, ubot1, utop1);
%             xtraj(i) = xtraj(i-1) + (ux1)*dt;
%             ytraj(i) = ytraj(i-1) + (uy1)*dt;
%         elseif mod(floor((i-1)/Ntsep),2)==1
%             [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f1, ubot1, utop1);
%             xtraj(i) = xtraj(i-1) + (ux1)*dt;
%             ytraj(i) = ytraj(i-1) + (uy1)*dt;
%         else
%             [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f1, ubot1, utop1);
%             [ux2,uy2] = flow_point(xtraj(i-2), ytraj(i-2), N,L,H, f1, ubot1, utop1);
%             xtraj(i) = xtraj(i-1) + (3*ux1-ux2)*dt/2;
%             ytraj(i) = ytraj(i-1) + (3*uy1-uy2)*dt/2;
%         end
% 
%     else
%         if mod(floor((i-1)/Ntsep),2) ==0
%             [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f2, ubot2, utop2);
%             xtraj(i) = xtraj(i-1) + (ux1)*dt;
%             ytraj(i) = ytraj(i-1) + (uy1)*dt;
%         else
%             [ux1,uy1] = flow_point(xtraj(i-1), ytraj(i-1), N,L,H, f2, ubot2, utop2);
%             [ux2,uy2] = flow_point(xtraj(i-2), ytraj(i-2), N,L,H, f2, ubot2, utop2);
%             xtraj(i) = xtraj(i-1) + (3*ux1-ux2)*dt/2;
%             ytraj(i) = ytraj(i-1) + (3*uy1-uy2)*dt/2;
%         end
%     end
%     if (ytraj(i)<0)
%         break
%     end
%     if (ytraj(i)>H)
%         break
%     end
%     if (xtraj(i)<0)
%         break
%     end
%     if (xtraj(i)>L)
%         break
%     end



end
