function time_disc = traversal_time(xst,yst,xend, N, L, H, dt,Ntsep, MaxTsep,InitialTsep)

dtsep = (MaxTsep-InitialTsep)/(Ntsep-1);
time_disc = zeros(Ntsep,1);

for i=1:Ntsep
    tsep = InitialTsep+dtsep*(i-1);
    [time, ~] = particle_trans_discrete_2(xst,yst, xend, N, L, H,tsep, dt);
    time_disc(i)=time;
end

end