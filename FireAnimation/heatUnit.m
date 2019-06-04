function [currentHeat,state,LandStateImage] = heatUnit(x,y,qsig,previousHeat, previousState,  ...
                                        LandStateImage,IpNumber,Ip,time) 
    %heatUnit Increase the currentHeat of the land unit by the amount
    %absorbed from the amount of heat released from a neighboring unit (but
    %only before it ignites, after it is already burning the amoung of heat
    %absorbed is not significant to the simulation)
    if previousState == "Not Burnt"
        currentHeat = previousHeat+Ip(IpNumber);
        if currentHeat >= qsig && previousState == "Not Burnt"
            state = "Burning"; 
             LandStateImage(x,y) = 85;
        else
            state = previousState;
        end
    else
        currentHeat = previousHeat;
        state = previousState;
    end
end


