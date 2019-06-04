function r = calculateReactionVelocity(fuelType,mf)
    %calculateReactionVelocity Determines r, the rate of fuel consumption /
    %rate of combustion of the fuel
            global sav;
            global packingRatio;
            global mx;
            ns = 0.174*(.001)^(-.19);  
            packingRatioOpt = 3.348*(sav(fuelType)^-0.8189);
            beta = packingRatio(fuelType)/packingRatioOpt;
            rPotMax = ((sav(fuelType)^1.5)/(495+0.0594));       
            A = 1/(4.77*sav(fuelType)^0.1-7.27);                 
            rPot = (rPotMax*beta*exp(A*(1-beta)));                                                     
            mr = mf/mx(fuelType);
            nm = 1-2.59*mr+5.11*mr^2-3.52*mr^3; 
            r = nm*ns*rPot;
        end
