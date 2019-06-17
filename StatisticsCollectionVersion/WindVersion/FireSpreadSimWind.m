%**********************************************************************
% Melissa Conley 818890729 Fire Spread Simulation
%*********************************************************************
clear;clc;

%% Globals

global initFuelLoad;                                        %lb/ft^2
global sav;                                                 %ft^-1
global packingRatio;                                        %unitless
global mx;                                                  %fraction
global heatofC;                                             %Btu/lb
global resTime;                                             %min

%Load columns from fuel data table into global vectors
load('FuelDataS2.mat');
initFuelLoad = FuelDataS2{:,4};
sav = FuelDataS2{:,6};
packingRatio = FuelDataS2{:,7};
mx = FuelDataS2{:,8};
heatofC = FuelDataS2{:,9};
resTime = FuelDataS2{:,10};                 
                                   
                                        
%% Run simulation for different levels of key variable
%  Perform several runs at each level

R = (1:8);                      %Rate of fire spread               ft^2/s
Rs = zeros(13,8);
Area = 0;
Areas = (1:13);                 %Total area that fire has covered,
                                %includes burning and burnt units
                                %                                  ft^2
simIndex = 0;
 for wSpeed = 0:7:91
     simIndex = simIndex+1;  
     Area = 0;

        %% Performance Measures
        %wSpeed = 38;                    %wind speed,                    ft/s
        wDir = 1;                       %wind direction,                unitless
        slopeAngle = 0;                %Slope angle                    radians
        slopeDir = 4;                   %slope direction,               unitless
        initHeat = 20;
        fuelType = 3;
        mf = .12;

        %% Initializations done before simulation
                
        duration = 25;                 %duration of simulation in seconds
        landDimensions = 50;           %dimensions of square land plot (x and y length) in feet
        x = 25;                         %x coordinate of starting position of fire
        y = 25;                         %y coordinate of starting position of fire
        %Agent Populations and Ip
        Land = landAgent(fuelType,mf,initHeat,landDimensions);
        Fire = fireAgent(fuelType,mf);
        Ip = calculateIps(fuelType,wSpeed,wDir,slopeAngle,slopeDir,Fire.Ir);

        % Rates of spread in each direction
%         for RIndex = 1:8
%             R(RIndex) = Ip(RIndex)/Land(1,1).qsig;
%             if(R(RIndex) < 0)
%                 R(RIndex) = 0;
%             end
%         end
        for RIndex = 1:8
            Rs(simIndex,RIndex) = Ip(RIndex)/Land(1,1).qsig;
            if(Rs(simIndex,RIndex) < 0)
                Rs(simIndex,RIndex) = 0;
            end
        end

        %Starting coordinates set on fire 
        Land(x,y).state = "Burning";
        Land(x,y).tempState = "Burning";
        Land(x,y).currentHeat = Land(x,y).qsig;

        %Command window outputs
%         Land(1,1).qsig          %heat needed to ignite
%         Fire.Ir                 %heat emitted
%         Ip                      %heat absorbed
%         R                       %Rate of spread


        %% Run Simulation   

        Land = runSimWind(Land,duration,Ip,fuelType,simIndex);

        %% Calculate area that fire has covered

        for XIndex = 1:size(Land,1)
            for YIndex = 1:size(Land,1)
                if(Land(XIndex,YIndex).state == "Burning" || Land(XIndex,YIndex).state == "Burnt")
                    Area = Area+1;
                end
            end
        end
          Areas(simIndex) = Area;
        %Area
  end
 
  axis = (0:7:91);
  
  figure(3);
  hold on;
  Areas
  plot(axis,Areas);
  xlabel('Wind Speed (ft/s)');
  ylabel('Area (ft^2)');
  title('Effect of Wind Speed on Area Burnt')
  hold off;
  
  figure(4);
  hold on ;
  for plotIndex = 1:8
    plot(axis,Rs);
    xlabel('Wind Speed (ft/s)');
    ylabel('Rate of Spread (ft^2/s)');
    title('Effect of Wind Speed on Rate of Spread in Each Cardinal Direction')
  end  
   legend('R1/North','R2/Northeast','R3/East','R4/Southeast','R5/South','R6/Southwest','R7/West','R8/Northwest'); 
   hold off;

  Rs



 