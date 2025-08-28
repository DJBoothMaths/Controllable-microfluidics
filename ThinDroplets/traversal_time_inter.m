function times = traversal_time_inter(xst,yst,xend, Nint, L, H, dt,Ntsep, MaxTsep,InitialTsep,opt)

dtsep = (MaxTsep-InitialTsep)/(Ntsep-1);
times = zeros(Ntsep,1);

for i=1:Ntsep
    tsep = InitialTsep+dtsep*(i-1);
    [time, ~] = particle_trans_discrete_inter(xst,yst, xend, L, H,tsep, dt,Nint,opt);
    times(i)=time;
end

end