function [state,LandStateImage] = changeToBurnt(x,y,fuelType,timeBurning, previousState, LandStateImage)
    %changeToBurnt Change neighboring unit to "burnt" state if time burning exceeds
    %residence time (extinguishes after a time out condition met)

    global resTime;
    if timeBurning >= resTime(fuelType) && previousState == "Burning"
        state = "Burnt";
         LandStateImage(x,y) = 100; 
    else
        state = previousState;
    end 
end

