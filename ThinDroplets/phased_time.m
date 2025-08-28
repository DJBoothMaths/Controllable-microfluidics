function times = phased_time(xst,yst,xend, Nint, L, H, dt,Ntsep, MaxTsep,InitialTsep)

dtsep = (MaxTsep-InitialTsep)/(Ntsep-1);
times = zeros(Ntsep,1);

for i=1:Ntsep
    tsep = InitialTsep+dtsep*(i-1);
    [time, ~] = phased(xst,yst, xend, L, H,tsep, dt,Nint);
    times(i)=time;
end

end