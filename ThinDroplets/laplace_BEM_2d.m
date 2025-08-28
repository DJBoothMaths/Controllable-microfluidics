function [c, dcdn] = laplace_BEM_2d(N,L,H,Abot,Atop,NGL)

c = zeros(4*N,1);
dcdn = zeros(4*N,1);


M = zeros(4*N); % BEM Matrix to solve
rhs = zeros(4*N,1); %rhs of BEM sytem

[elmx, elmy, midx, midy] = disc_rect(N,L,H);

%Construct BEM Matrix 
%loop over mid points
 %number of gaussian elements

for j = 1:4*N
    for i = 1:N
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
    for i=N+1:2*N
        if i == j
            [slp, ~]= rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 1);
            M(j,i) = -slp;
        else
            [slp, ~] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 0);
            M(j,i) = -slp;
        end
    end
    for i=2*N+1:3*N
        if i == j
            [slp, dlp] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 1);
            M(j,i) = dlp -0.5;
            rhs(j) = rhs(j) + slp*Atop(3*N+1-i);
        else
            [slp, dlp] = rect_sdlp(midx(j), midy(j), elmx(i,1), elmy(i,1), elmx(i,2), elmy(i,2), NGL, 0);
            M(j,i) = dlp;
            rhs(j) = rhs(j) + slp*Atop(3*N+1-i);
        end
    end
    for i=3*N+1:4*N
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
    for i = 1:N
        c(i) = x(i);
        dcdn(i) = Abot(i);
    end
    for i = N+1:2*N
        c(i) = 0;
        dcdn(i) = x(i);
    end
    for i = 2*N+1:3*N
        c(i) = x(i);
        dcdn(i) = Atop(3*N+1-i);
    end
    for i = 3*N+1:4*N
        c(i) = 0;
        dcdn(i) = x(i);
    end
end

