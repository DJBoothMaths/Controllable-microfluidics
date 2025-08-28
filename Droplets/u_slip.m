function [ubot, utop,vbot,vtop] = u_slip(c,N,L,H,bot,top, M)
if length(top)==0
   ubot = zeros((2*length(bot(:,1))+1)*N,1);
   vbot = zeros((2*length(bot(:,1))+1)*N,1);
   utop = zeros(N,1);
   vtop = zeros(N,1);
else
    ubot = zeros((2*length(bot(:,1))+1)*N,1);
    vbot = zeros((2*length(bot(:,1))+1)*N,1);
    utop = zeros((2*length(top(:,1))+1)*N,1);
    vtop = zeros((2*length(top(:,1))+1)*N,1);    % Total number of elements
end
    
[elmx,elmy,midx,midy] = disc_drops(N,L,H, bot, top);


        for i = 1:2*length(bot(:,1))+1
            if mod(i,2)==1
                for j =1:N
                ubot((i-1)*N +j) = 0;
                end
            else
                ds1 = norm([midx((i-1)*N +2)-midx((i-1)*N +1), midy((i-1)*N +2)-midy((i-1)*N +1) ]);
                ds2 = norm([midx((i)*N)-midx((i)*N -1), midy((i)*N )-midy((i)*N -1) ]);
                ubot((i-1)*N +1) = (4*c((i-1)*N +2)-3*c((i-1)*N +1)-c((i-1)*N +3))/(2*ds1) *(elmx((i-1)*N +1,2)-elmx((i-1)*N +1,1))/norm([elmx((i-1)*N +1,2)-elmx((i-1)*N +1,1),elmy((i-1)*N +1,2)-elmy((i-1)*N +1,1)]);
                vbot((i-1)*N +1) =(4*c((i-1)*N +2)-3*c((i-1)*N +1)-c((i-1)*N +3))/(2*ds1) *(elmy((i-1)*N +1,2)-elmy((i-1)*N +1,1))/norm([elmx((i-1)*N +1,2)-elmx((i-1)*N +1,1),elmy((i-1)*N +1,2)-elmy((i-1)*N +1,1)]);
                ubot((i)*N ) = (3*c((i)*N )-4*c((i)*N -1)+c((i)*N -2))/(ds2) *(elmx((i)*N ,2)-elmx((i)*N,1))/norm([elmx((i)*N ,2)-elmx((i)*N,1),elmy((i)*N,2)-elmy((i)*N,1)]);
                vbot((i)*N ) =(3*c((i)*N )-4*c((i)*N -1)+c((i)*N -2))/(ds2) *(elmy((i)*N ,2)-elmy((i)*N,1))/norm([elmx((i)*N ,2)-elmx((i)*N,1),elmy((i)*N,2)-elmy((i)*N,1)]);
           for j =2:N-1
               ds = norm([midx((i-1)*N +j+1)-midx((i-1)*N +j), midy((i-1)*N +j)-midy((i-1)*N +j) ]);
            ubot((i-1)*N +j) = (c((i-1)*N +j+1)-c((i-1)*N +j-1))/(2*ds) *(elmx((i-1)*N +j,2)-elmx((i-1)*N +j,1))/norm([elmx((i-1)*N +j,2)-elmx((i-1)*N +j,1),elmy((i-1)*N +j,2)-elmy((i-1)*N +j,1)]);
            vbot((i-1)*N +j) = (c((i-1)*N +j+1)-c((i-1)*N +j-1))/(2*ds)*(elmy((i-1)*N +j,2)-elmy((i-1)*N +j,1))/norm([elmx((i-1)*N +j,2)-elmx((i-1)*N +j,1),elmy((i-1)*N +j,2)-elmy((i-1)*N +j,1)]);
            end
            end
        end
    ubot = M(1)*ubot;
    vbot = M(1)*vbot;
    utop = M(2)*utop;

end
