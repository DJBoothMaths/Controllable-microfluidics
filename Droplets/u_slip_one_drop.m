function [ubot,vbot] = u_slip_one_drop(c,N,L,H,M,drop_centre,theta,Abot)

[elmx,elmy,midx,midy] = disc_one_drop(N,L,H, drop_centre,theta);

ubot = zeros(N,1);
vbot = zeros(N,1);

for i = 0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L
        if Abot(i-1)==0
            ds = norm([midx(i+1)-midx(i), midy(i+1)-midy(i)]);
            ubot(i) = (c(i+1)-c(i))/(ds)*(elmx(i,2)-elmx(i,1))/norm([elmx(i,2)-elmx(i,1),elmy(i,2)-elmy(i,1)]);
            vbot(i) = (c(i+1)-c(i))/(ds)*(elmy(i,2)-elmy(i,1))/norm([elmx(i,2)-elmx(i,1),elmy(i,2)-elmy(i,1)]);
        elseif Abot(i+1)==0
            ds = norm([midx(i-1)-midx(i), midy(i-1)-midy(i)]);
            ubot(i) = (c(i)-c(i-1))/(ds)*(elmx(i,2)-elmx(i,1))/norm([elmx(i,2)-elmx(i,1),elmy(i,2)-elmy(i,1)]);
            vbot(i) = (c(i)-c(i-1))/(ds)*(elmy(i,2)-elmy(i,1))/norm([elmx(i,2)-elmx(i,1),elmy(i,2)-elmy(i,1)]);
        else
            ds1 = norm([midx(i+1)-midx(i), midy(i+1)-midy(i)]);
            ds2 = norm([midx(i-1)-midx(i), midy(i-1)-midy(i)]);
            ubot(i) = (1/2)*((c(i+1)-c(i))/(ds1)+(c(i)-c(i-1))/(ds2))*(elmx(i,2)-elmx(i,1))/norm([elmx(i,2)-elmx(i,1),elmy(i,2)-elmy(i,1)]);
            vbot(i) = (1/2)*((c(i+1)-c(i))/(ds1)+(c(i)-c(i-1))/(ds2))*(elmy(i,2)-elmy(i,1))/norm([elmx(i,2)-elmx(i,1),elmy(i,2)-elmy(i,1)]);
        end
 end
      
    ubot = M*ubot;
    vbot = M*vbot;
end
