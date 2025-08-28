function [slp, dlp] = arc_sdlp( T0, T1, T2, rad, xcnt, ycnt, NGL, Ising)

    slp = 0.0;
    dlp = 0.0;
    vni = 1.0;
    X0 = xcnt + rad * cos(T0);
    Y0 = ycnt + rad * sin(T0);

    % Prepare for the quadrature
    
        TM = 0.5 * (T2 + T1);
        TD = 0.5 * (T2 - T1);
        DR = rad * abs(TD);
        ornt = 1.0; % orientation index
        if TD < 0
            ornt = -1.0;
        end
    

    % Loop over Gaussian points
    [Z,W] = gauss_leg(NGL);
    for i = 1:NGL
            T = TM + TD * Z(i);
            cs = cos(T);
            sn = sin(T);
            X = xcnt + rad * cs;
            Y = ycnt + rad * sn;
            vnx = -cs * ornt; % unit normal vector
            vny = -sn * ornt; % when arc is clockwise, normal vector points toward the center
      
        
        % Call lgf_2d_fs function
        [G, Gx, Gy] = lgf_2d_fs(X, Y, X0, Y0, 2);

        % Treat the SLP singularity
        if Ising == 1
            
            Dists = (rad * (T0 - T))^2;
            G = G + log(Dists) / (4*pi);
        end
        
        WI = W(i);
        slp = slp + G * WI;
        dlp = dlp + vni * (Gx * vnx + Gy * vny) * WI;
    end

    % Finish up
    slp = slp * DR;
    dlp = dlp * DR;

    % Add the SLP singularity back to the SLP
    if Ising == 1
        slp = slp -  DR * (log(DR/2) - 1.0) / (2*pi);
    end

    % Analytical integration of the DLP for the free space GF
    if Ising == 1
        dlp = (T2 - T1) / (4*pi); % independent of T0
        
    end
end
