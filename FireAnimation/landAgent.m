classdef landAgent
    %LANDAGENT Used to fill matrix of whole land plot
    %Has characteristics that determine how fire agent affects it
    properties
        state
        tempState
        currentHeat
        initFuelLoad
        sav 
        packingRatio
        mx
        heatofC
        resTime
        
        fuelType                        %Type of vegetation burning,    unitless
        mf      %MUST BE LESS THAN MX   %fuel moisture content,         fraction
        %mr                             %fuel moisture ratio,           unitless
        
        Se = .001;                      %effective mineral content,     fraction
        %ns                             %mineral damping coefficient,   unitless
        St = .0555;                     %fuel mineral content,          fraction
        %nm                             %moisture damping coefficient,  unitless
        
        %density                        %bulk density of fuel bed,      lb/ft^3
        %e                              %fraction of fuel bed that needs to be
                                        %heated to flashpoint for the unit to 
                                        %combust/ignite                         
        qsig                            %Heat needed to reach flashpoint/ignition
                                        %point for a unit volume of the fuel type
                                        %                               Btu/ft^3
        timeBurning
                                     
    end
    
    methods
         function obj = landAgent(fuelType,mf,initHeat,landDimensions)    %Each unit area = 1x1
                                               %Unit volume = beddepth*area
             global initFuelLoad;  
             global sav;
             global packingRatio;
             global mx;
             global heatofC;
             global resTime;       %used as mean for random resTimes for each unit
             
         if nargin ~= 0
            m = landDimensions;         %MUST BE SQUARE
            n = landDimensions;
            landQsig = calculateQsig(fuelType,mf,initHeat);
            obj(m,n) = obj;
            for i = 1:m
               for j = 1:n
                  obj(i,j).fuelType = fuelType;
                  obj(i,j).mf = mf;
                  obj(i,j).initFuelLoad = initFuelLoad(fuelType);
                  obj(i,j).sav = sav(fuelType);
                  obj(i,j).packingRatio = packingRatio(fuelType);
                  obj(i,j).mx = mx(fuelType);
                  obj(i,j).heatofC = heatofC(fuelType);
                  obj(i,j).resTime = resTime(fuelType);
                  obj(i,j).state = "Not Burnt";
                  obj(i,j).tempState = "Not Burnt";
                  obj(i,j).qsig = landQsig;
                  obj(i,j).currentHeat = initHeat;
                  obj(i,j).timeBurning = 0;
               end
            end
         end
         end
        
        
    end
end

