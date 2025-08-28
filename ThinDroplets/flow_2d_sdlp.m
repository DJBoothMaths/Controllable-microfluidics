function [slp, dlp] = flow_2d_sdlp(X0, Y0, T0, X1, Y1, T1, X2, Y2, T2, NGL, Ising, Itype, rad, xcnt, ycnt)
    % Computes the single-layer and double-layer potential over
    % a straight segment or a circular arc

    % Initialize variables
    slp = 0.0;
    dlp = 0.0;
    vni = 1.0;

    % Prepare for the quadrature
    if Itype == 1 % straight segments
        XM = 0.5 * (X2 + X1);
        XD = 0.5 * (X2 - X1);
        YM = 0.5 * (Y2 + Y1);
        YD = 0.5 * (Y2 - Y1);
        DR = sqrt(XD^2 + YD^2);
        
        vnx = -YD / DR; % unit normal vector
        vny = XD / DR;
    else % circular arcs
        TM = 0.5 * (T2 + T1);
        TD = 0.5 * (T2 - T1);
        DR = rad * abs(TD);
        ornt = 1.0; % orientation index
        if TD < 0
            ornt = -1.0;
        end
    end

    % Loop over Gaussian points
    [Z,W] = gauss_leg(NGL);
    for i = 1:NGL
        if Itype == 1 % straight segments
            X = XM + XD * Z(i);
            Y = YM + YD * Z(i);
        else % circular arcs
            T = TM + TD * Z(i);
            cs = cos(T);
            sn = sin(T);
            X = xcnt + rad * cs;
            Y = ycnt + rad * sn;
            vnx = -cs * ornt; % unit normal vector
            vny = -sn * ornt; % when arc is clockwise, normal vector points toward the center
        end
        
        % Call lgf_2d_fs function
        [G, Gx, Gy] = lgf_2d_fs(X, Y, X0, Y0, 2);

        % Treat the SLP singularity
        if Ising == 1
            if Itype == 1
                Dists = (X - X0)^2 + (Y - Y0)^2;
            elseif Itype == 2
                Dists = (rad * (T0 - T))^2;
            end
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
        slp = slp -  DR/2 * (log(DR/2) - 1.0) / (pi);
    end

    % Analytical integration of the DLP for the free space GF
    if Ising == 1
        if Itype == 1 % straight segments
            dlp = 0.0;
        elseif Itype == 2 % circular arcs
            dlp = (T2 - T1) / (4*pi); % independent of T0
        end
    end
end
