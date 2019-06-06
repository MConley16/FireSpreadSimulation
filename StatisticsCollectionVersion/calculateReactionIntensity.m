function Ir = calculateReactionIntensity(fuelType,r)
  %Reaction intensity: rate of heat release per unit area of ground               
  %Btu/ft^2/s
    global initFuelLoad;                                     %lb/ft^2
    global heatofC;                                          %Btu/lb
    Ir = (r*heatofC(fuelType)*initFuelLoad(fuelType))/60;    % orig in min, so converted to s
end
