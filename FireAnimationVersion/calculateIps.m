function Ip = calculateIps(fuelType,wSpeed,wDir,slopeAngle,slopeDir,Ir)
    %calculateIps Determines the rate of heat absorption of each neighbor
    %of a land unit according to the wind, slope, surface-area-to-volume
    %ratio, and packing ratio
    
    global sav;                                                 %ft^-1
    global packingRatio;                                        %unitless

    Ip = (1:8);                     %Propagating flux - Rate of heat absorption
                                    %per unit area of this fuel bed
                                    %                           Btu/ft^2/min
    %Ip(1): Forward
    %Ip(2): Right Positive Diagonal
    %Ip(3): Right Perpindicular
    %Ip(4): Right Negative Diagonal
    %Ip(5): Backwards
    %Ip(6): Left Negative Diagonal
    %Ip(7): Left Perpindicular
    %Ip(8): Left Positive Diagonal

    %E;                             %Base propagating flux ratio - Ratio 
                                    %of heat absorption per unit area of the 
                                    %fuel bed with no wind or slope   
                                    %                            fraction
    Ews = (1:8);                    %Propagating flux ratio with wind and slope
                                    %accounted for                    
                                    %                            fraction
    Ow = (1:8);                     %Effect of wind in the form of a factor
                                    %                            unitless
    %C,B,D;                         %Ow coefficients             unitless
    Os = (1:8);                     %Effect of slope in the form of a factor
                                    %                            unitless

%Ip: Propagating Flux/Absorption rate for each direction
E = ((192+0.259*sav(fuelType))^-1)*exp((0.792+0.681*(sav(fuelType)^.5))*(packingRatio(fuelType)+0.1));
C = 7.47*exp(-0.133*(sav(fuelType)^.55));
B = 0.02526*(sav(fuelType)^.54);
D = 0.715*exp(-3.59*(10^-4)*sav(fuelType));

%Effective windspeed in each direction (where direction 1 = forward direction of wind)
wArray = (1:8);
wArray(1) = wSpeed;
wArray(2) = wSpeed*cos(0.785398);
wArray(3) = 0;
wArray(4) = wSpeed*cos(0.785398);   %(-)
wArray(5) = wSpeed;                 %(-)   
wArray(6) = wSpeed*cos(0.785398);   %(-)
wArray(7) = 0;
wArray(8) = wSpeed*cos(0.785398);   

%Angle of slope of surrounding units in relation to current unit (where 
%direction 1 is the direction of upward slope)
slopeArray = (1:8);
for i = 1:8
    slopeArray(i) = slopeAngle;     %4,5,6 = (-)
end
slopeArray(3) = 0;
slopeArray(7) = 0;

W = (1:8);
theta = (1:8);
%Absorption rate of units surrounding the current unit (where unit 1 is 
%the unit to the North, 2 is the unit to the NorthEast, ...)
for IpIndex = 1:8
    negW = false;
    negTheta = false;
    if (IpIndex+(-wDir+9)) <= 8
        W(IpIndex) = wArray(IpIndex+(-wDir+9));
        if ((IpIndex+(-wDir+9))>=4 && (IpIndex+(-wDir+9))<=6)
            negW = true;
        end
    else   
        W(IpIndex) = wArray(IpIndex-(wDir-1));
        if ((IpIndex-(wDir-1))>=4 && (IpIndex-(wDir-1))<=6)
            negW = true;
        end
    end    
    
    if (IpIndex+(-slopeDir+9)) <= 8
        theta(IpIndex) = slopeArray(IpIndex+(-slopeDir+9));
        if ((IpIndex+(-slopeDir+9))>=4 && (IpIndex+(-slopeDir+9))<=6)
            negTheta = true;
        end
    else
        theta(IpIndex) = slopeArray(IpIndex-(slopeDir-1)); 
        if ((IpIndex-(slopeDir-1))>=4 && (IpIndex-(slopeDir-1))<=6)
            negTheta = true;
        end
    end    
    
    Os(IpIndex) = 5.275*(packingRatio(fuelType)^-.3)*(tan(theta(IpIndex))^2);
    packingRatioOpt = 3.348*(sav(fuelType)^-0.8189);
    beta = packingRatio(fuelType)/packingRatioOpt;
    Ow(IpIndex) = C*(W(IpIndex)^B)*(beta^-D);
    
    if (negW == false && negTheta == false)
        Ews(IpIndex) = (1+Ow(IpIndex)+Os(IpIndex))*E;
    elseif (negW == true && negTheta == false)
        Ews(IpIndex) = (1-Ow(IpIndex)+Os(IpIndex))*E;
    elseif (negW == false && negTheta == true)
        Ews(IpIndex) = (1+Ow(IpIndex)-Os(IpIndex))*E;
    else
        Ews(IpIndex) = (1-Ow(IpIndex)-Os(IpIndex))*E;
    end    
    Ip(IpIndex) = Ews(IpIndex)*Ir;
    if Ip(IpIndex) <0
        Ip(IpIndex) = 0;
    end    
end
end

