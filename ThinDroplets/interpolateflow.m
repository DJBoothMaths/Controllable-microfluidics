function [U,V] = interpolateflow(N,L,H, drop_centre, Nint,Opt)

%drop setup
   if Opt == 1
        Abot = zeros(N,1);
        Abot(floor(drop_centre*(N-1)/L)+1-(N-1)/L:floor(drop_centre*(N-1)/L)+1+(N-1)/L)=-1;
        Atop = zeros(N,1);
   elseif Opt == 2
        Abot = zeros(N,1);
        Atop = zeros(N,1);
        Atop(floor(drop_centre*(N-1)/L)+1-(N-1)/L:floor(drop_centre*(N-1)/L)+1+(N-1)/L)=-1;    
    elseif Opt == 3
        Abot = zeros(N,1);
        Abot(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
        Atop = zeros(N,1);
        Atop(.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
        Atop(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1; 
    elseif Opt == 4
        Atop = zeros(N,1);
        Atop(0.5*(N-1)+1-(N-1)/L:0.5*(N-1)+1+(N-1)/L)=-1;
        Abot = zeros(N,1);
        Abot(.3*(N-1)+1-(N-1)/L:0.3*(N-1)+1+(N-1)/L)=-1;
        Abot(0.7*(N-1)+1-(N-1)/L:0.7*(N-1)+1+(N-1)/L)=-1; 
    elseif Opt == 5
        Atop = zeros(N,1);
        Atop(floor(drop_centre*(N-1)/L)+1-(N-1)/L:floor(drop_centre*(N-1)/L)+1+(N-1)/L)=-1;
        Abot = zeros(N,1);
        Abot(floor(drop_centre*(N-1)/L)+1-(N-1)/L:floor(drop_centre*(N-1)/L)+1+(N-1)/L)=-1;
   end
    % solve BEM equations
    [c,~] = laplace_BEM_2d(N,L,H,Abot,Atop,8);
    if Opt==1
        [ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 0);
    else 
        [ubot, utop] = u_slip_alt(c,N,L, Abot, Atop, [1 1], 1);
    end
    f = stokes_BEM_2d(N,L,H,ubot,utop);
    
    [Ubem,Vbem] = flow_int(N,L,H, f, ubot, utop);
    [X,Y]=meshgrid(linspace(0,L,N),linspace(0,H,N));
    [Xq,Yq]=meshgrid(linspace(0,L,Nint),linspace(0,H,Nint));
    U = interp2(X,Y,Ubem,Xq,Yq,'cubic');
    V = interp2(X,Y,Vbem,Xq,Yq,'cubic');   
end