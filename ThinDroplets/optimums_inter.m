function [opt_time, opt_tsep] = optimums_inter(xst,xend, Nint, L, H, dt,Ntsep, MaxTsep,InitialTsep, points,opt)


opt_time = zeros(points,1);
opt_tsep = zeros(points,1);
dtsep = (MaxTsep-InitialTsep)/(Ntsep-1);

for i=1:points
    %broad sweep
    yst = 0.1+0.05*(i-1);
    time_disc = traversal_time_inter(xst,yst,xend, Nint, L, H, dt,Ntsep, MaxTsep,InitialTsep,opt);
    [~,j_time] = min(time_disc);
    min_tsep = InitialTsep +(j_time-1)*dtsep;
    %small sweep around min of big sweep
    time_disc_min = traversal_time_inter(xst,yst,xend, Nint, L, H, dt,Ntsep, min_tsep+2,min_tsep-2,opt);
    [opt_time(i),j] = min(time_disc_min);
    opt_tsep(i) = min_tsep-2 + (j-1)*4/(Ntsep-1);
end

end