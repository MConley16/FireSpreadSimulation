function qsig = calculateQsig(fuelType,mf,initHeat)
    %Qsig: Heat needed to reach flashpoint/ignition point
    
    global sav;                                                 %ft^-1
    %qig                                %heat needed to reach flashpoint/ignition
                                        %point for a unit mass of the fuel type
                                        %                        Btu/lb
    qig = 250+1116*mf-initHeat;
    e = exp(-138/sav(fuelType));
    qsig = e*qig;    
end

