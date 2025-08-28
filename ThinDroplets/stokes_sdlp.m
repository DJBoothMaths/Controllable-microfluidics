function [slxx,slxy,slyx,slyy,dlxx,dlxy,dlyx,dlyy] = stokes_sdlp(X0, Y0, X1, Y1, X2, Y2, NGL, Ising)

% Initialize variables
    vni = 1.0;
     slxx = 0;
     slxy = 0;
     slyx = 0;
     slyy = 0;
     dlxx = 0;
     dlxy = 0;
     dlyx = 0;
     dlyy = 0;

    % Prepare for the quadrature
    % straight segments
        XM = 0.5 * (X2 + X1);
        XD = 0.5 * (X2 - X1);
        YM = 0.5 * (Y2 + Y1);
        YD = 0.5 * (Y2 - Y1);
        DR = sqrt(XD^2 + YD^2);
        
        vnx = -YD / DR; % unit normal vector
        vny = XD / DR;
    

    % Loop over Gaussian points
    [Z,W] = gauss_leg(NGL);
    for i = 1:NGL
        
            X = XM + XD * Z(i);
            Y = YM + YD * Z(i);
            [S, T] = Stokes_gfunc(X,Y,X0,Y0);

            if Ising == 1 %remove singularity
                for j=1:2
                S(j,j) = S(j,j)+0.5*log((X-X0)^2+(Y-Y0)^2);
                end
            end
        slxx = slxx + S(1,1)*W(i);
        slxy = slxy + S(1,2)*W(i);
        slyx = slyx + S(2,1)*W(i);
        slyy = slyy + S(2,2)*W(i);
        dlxx = dlxx + (T(1,1,1)*vnx+T(1,1,2)*vny)*W(i);
        dlxy = dlxy + (T(1,2,1)*vnx+T(1,2,2)*vny)*W(i);
        dlyx = dlyx + (T(2,1,1)*vnx+T(2,1,2)*vny)*W(i);
        dlyy = dlyy + (T(2,2,1)*vnx+T(2,2,2)*vny)*W(i);

    end
        slxx = slxx*DR; 
        slxy = slxy*DR;
        slyx = slyx*DR; 
        slyy = slyy*DR;
        dlxx = dlxx*DR; 
        dlxy = dlxy*DR;
        dlyx = dlyx*DR; 
        dlyy = dlyy*DR;

        if Ising==1 %add analytical singularity integral back
            slxx = slxx - 2*DR * (log(DR) - 1.0);
            slyy = slyy - 2*DR * (log(DR) - 1.0); %need to check the sign here
            dlxx=0; % double layer integral is zero over a singularity
            dlxy=0;
            dlyx=0;
            dlyy=0;
        end



end
