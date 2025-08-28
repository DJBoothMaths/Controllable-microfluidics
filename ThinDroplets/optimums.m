function [opt_time, opt_tsep] = optimums(xst,xend, N, L, H, dt,Ntsep, MaxTsep,InitialTsep, points)


opt_time = zeros(points,1);
opt_tsep = zeros(points,1);
dtsep = (MaxTsep-InitialTsep)/(Ntsep-1);

for i=1:points
    yst = 0.1+0.1*(i-1);
    time_disc = traversal_time(xst,yst,xend, N, L, H, dt,Ntsep, MaxTsep,InitialTsep);
    [opt_time(i),j] = min(time_disc);
    opt_tsep(i) = InitialTsep + (j-1)*dtsep;
end

end