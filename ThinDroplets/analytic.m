function c = analytic(N,L,H,x,y,xi,A)

c=0;

for n=1:N
    an = 4/(n*pi)*sin(n*pi*xi/L)*sin(n*pi/L);
    c= c+A*(an*L/(n*pi)*sinh(n*pi*y/L)-an*L*cosh(n*pi*H/L)/(n*pi*sinh(n*pi*H/L))*cosh(n*pi*y/L))*sin(n*pi*x/L);
end

end