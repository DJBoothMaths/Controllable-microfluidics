N=201;
L=10;
H=3;

%%
[xtraj_twodrop,ytraj_twodrop]=two_drop_mix_traj(N,L,H, 5,1, 1000, 0.01,2);
%%
[xtraj_twodrop4,ytraj_twodrop4]=two_drop_mix_traj(N,L,H, 5,1, 1000, 0.01,4);
[xtraj_twodrop6,ytraj_twodrop6]=two_drop_mix_traj(N,L,H, 5,1, 1000, 0.01,6);
%%
Ntsep = 2/0.01;
Nt=1000/0.01;
strobe = zeros(Nt/Ntsep+1,2);
for i = 1:Nt/Ntsep+1
    strobe21(i) = xtraj_twodrop(Ntsep*(i-1)+1);
    strobe22(i) = ytraj_twodrop(Ntsep*(i-1)+1);
end
%%
Ntsep = 4/0.01;
for i = 1:Nt/Ntsep+1
    strobe41(i) = xtraj_twodrop4(Ntsep*(i-1)+1);
    strobe42(i) = ytraj_twodrop4(Ntsep*(i-1)+1);
end
%%
Ntsep =6/0.01;
for i = 1:Nt/Ntsep+1
    strobe61(i) = xtraj_twodrop6(Ntsep*(i-1)+1);
    strobe62(i) = ytraj_twodrop6(Ntsep*(i-1)+1);
end
%%
figure
plot(strobe21,strobe22,'+')
hold on
plot(strobe41,strobe42,'ro')
plot(strobe61,strobe62,'kx')
hold off
%%
figure
plot(xtraj_twodrop6,ytraj_twodrop6)

