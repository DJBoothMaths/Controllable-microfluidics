function [M,rhs,x, c, dcdn] = laplace_BEM_drops(N,L,H,bot, top, Abot,Atop)




if length(top)==0
    Ntot  = (2*length(bot(:,1))+4)*N;
else
    Ntot  = (2*length(bot(:,1))+2*length(top(:,1))+4)*N;    % Total number of elements
end

c = zeros(Ntot,1);
dcdn = zeros(Ntot,1);


M = zeros(Ntot); % BEM Matrix to solve
rhs = zeros(Ntot,1); %rhs of BEM sytem

[elmx,elmy,midx,midy] = disc_drops(N,L,H, bot, top);

%Construct BEM Matrix 
%loop over mid points
NGL = 20; %number of gaussian elements

for j = 1:Ntot
    for i = 1:(2*length(bot(:,1))+1)*N
        if i == j
            [slp, dlp] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 1);
            M(j,i) = dlp - 0.5;
            rhs(j) = rhs(j) + slp*Abot(i);
        else
            [slp, dlp] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 0);
            M(j,i) = dlp;
            rhs(j) = rhs(j) + slp*Abot(i);
        end
    end
    for i=(2*length(bot(:,1))+1)*N+1:(2*length(bot(:,1))+2)*N
        if i == j
            [slp, ~]= rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 1);
            M(j,i) = -slp;
        else
            [slp, ~] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 0);
            M(j,i) = -slp;
        end
    end
        for i=(2*length(bot(:,1))+2)*N+1:Ntot-N
            if i == j
                [slp, dlp] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 1);
                M(j,i) = dlp -0.5;
                rhs(j) = rhs(j) + slp*Atop(Ntot-N+1-i);
            else
                [slp, dlp] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 0);
                M(j,i) = dlp;
                rhs(j) = rhs(j) + slp*Atop(Ntot-N+1-i);
            end
        end
    for i=Ntot-N+1:Ntot
        if i == j
            [slp, ~] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 1);
            M(j,i) = -slp;
        else
            [slp, ~] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 0);
            M(j,i) = -slp;
        end
    end
end

    x = M\rhs;

    %construct c and dcdn
    for i = 1:(2*length(bot(:,1))+1)*N
        c(i) = x(i);
        dcdn(i) = Abot(i);
    end
    for i =(2*length(bot(:,1))+1)*N+1:(2*length(bot(:,1))+2)*N
        c(i) = 0;
        dcdn(i) = x(i);
    end
    for i =(2*length(bot(:,1))+2)*N+1:Ntot-N
        c(i) = x(i);
        dcdn(i) = Atop(Ntot-N+1-i);
    end
    for i = Ntot-N+1:Ntot
        c(i) = 0;
        dcdn(i) = x(i);
    end
end

