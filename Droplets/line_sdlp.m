function [slp, dlp] = line_sdlp(X0, Y0, X1, Y1, X2, Y2, NGL, Ising)
    % Computes the single-layer and double-layer potential over
    % a straight segment 

    % Initialize variables
    slp = 0.0;
    dlp = 0.0;
    vni = 1.0;

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
        
        % Call lgf_2d_fs function, change this for the specific greens
        % function needed
        [G, Gx, Gy] = lgf_2d_fs(X, Y, X0, Y0, 2);

        % Treat the SLP singularity
        if Ising == 1
            Dists = (X - X0)^2 + (Y - Y0)^2;
            G = G + log(Dists) / (4*pi);
        end
       
        slp = slp + G * W(i);
        dlp = dlp + vni * (Gx * vnx + Gy * vny) * W(i);
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
         dlp = 0.0;   
    end
end
