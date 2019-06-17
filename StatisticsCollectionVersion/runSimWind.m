function Land = runSim(Land,duration,Ip,fuelType,simIndex)
%runSim Run the simulation: Let fire start at specified point and let it burn 
%for the specified amount of time

%Draw initial land plot/grid
LandStateImage = zeros(size(Land,1), size(Land,1));
for i = 1:size(LandStateImage,1)
    for j = 1:size(LandStateImage,1)
        if Land(i,j).state == "Not Burnt"
            LandStateImage(i,j) = 55;
        elseif Land(i,j).state == "Burning"
            LandStateImage(i,j) = 85;
        else
            LandStateImage(i,j) = 100;  
        end    
    end
end  
colormap(jet(100));
% image(LandStateImage)
% hold on

%Repeat until reach end time (time units = minutes)
for time = 1:duration                     
    %Check all units each time that clock steps
    for i = 1:size(Land,1)
        for j = 1:size(Land,1)
           %For each land unit that is burning, calculate the heat that
           %is absorbed by all of surrounding unburnt units
           if Land(i,j).state == "Burning"
               % 1. North i-1,j
               if(i-1>0)
               [Land(i-1,j).currentHeat,Land(i-1,j).tempState,LandStateImage] = heatUnit(i-1,j,Land(i-1,j).qsig,Land(i-1,j).currentHeat,...
                                                             Land(i-1,j).state, LandStateImage, ...
                                                             1, Ip,time);
               end    
               % 2. NorthEast i-1,j+1
               if(i-1>0 && j+1<=size(Land,1))
               [Land(i-1,j+1).currentHeat,Land(i-1,j+1).tempState,LandStateImage] = heatUnit(i-1,j+1,Land(i-1,j+1).qsig,Land(i-1,j+1).currentHeat,...
                                                             Land(i-1,j+1).state, LandStateImage,...
                                                             2, Ip,time);
               end
               % 3. East i,j+1
               if(j+1<=size(Land,1))
               [Land(i,j+1).currentHeat,Land(i,j+1).tempState,LandStateImage] = heatUnit(i,j+1,Land(i,j+1).qsig,Land(i,j+1).currentHeat,...
                                                             Land(i,j+1).state, LandStateImage, ...
                                                             3, Ip,time);   
               end
                % 4. SouthEast i+1,j+1
               if(i+1<=size(Land,1) && j+1<=size(Land,1))
               [Land(i+1,j+1).currentHeat,Land(i+1,j+1).tempState,LandStateImage] = heatUnit(i+1,j+1,Land(i+1,j+1).qsig,Land(i+1,j+1).currentHeat,...
                                                             Land(i+1,j+1).state, LandStateImage,  ...
                                                             4, Ip,time); 
               end
               % 5. South i+1,j
               if(i+1<=size(Land,1))
               [Land(i+1,j).currentHeat,Land(i+1,j).tempState,LandStateImage] = heatUnit(i+1,j,Land(i+1,j).qsig,Land(i+1,j).currentHeat,...
                                                             Land(i+1,j).state, LandStateImage, ...
                                                             5, Ip,time);
               end                                          
                % 6. SouthWest i+1,j-1
                if(i+1<=size(Land,1) && j-1>0)
                [Land(i+1,j-1).currentHeat,Land(i+1,j-1).tempState,LandStateImage] = heatUnit(i+1,j-1,Land(i+1,j-1).qsig,Land(i+1,j-1).currentHeat,...
                                                             Land(i+1,j-1).state, LandStateImage, ...
                                                             6, Ip,time); 
                end                                         
                % 7. West   i,j-1
                if(j-1>0)
                [Land(i,j-1).currentHeat,Land(i,j-1).tempState,LandStateImage] = heatUnit(i,j-1,Land(i,j-1).qsig,Land(i,j-1).currentHeat,...
                                                             Land(i,j-1).state, LandStateImage, ...
                                                             7, Ip,time);
                end                                         
               % 8. NorthWest  i-1,j-1
               if(i-1>0 && j-1>0)
               [Land(i-1,j-1).currentHeat,Land(i-1,j-1).tempState,LandStateImage] = heatUnit(i-1,j-1,Land(i-1,j-1).qsig,Land(i-1,j-1).currentHeat,...
                                                             Land(i-1,j-1).state, LandStateImage, ...
                                                             8, Ip,time);
               end                                          
               %Increase time that current unit has been burning,
               %If reached total flame residence time, then it is
               %done burning and extinguishes
               Land(i,j).timeBurning = Land(i,j).timeBurning+1;
               [Land(i,j).state,LandStateImage] = changeToBurnt(i,j,fuelType,Land(i,j).timeBurning,... 
                                               Land(i,j).state, LandStateImage);
                             
           end  
        end
    end
    
   %Set tempStates equal to permanent states
   for i = 1:size(Land,1)
        for j = 1:size(Land,1)
            Land(i,j).state = Land(i,j).tempState;
        end
   end 
%      hold on
%      image(LandStateImage)  
%      pause(0.01)
end

if(simIndex == 1)
figure(1)
image(LandStateImage)
end
                  
if(simIndex == 13)
figure(2)
image(LandStateImage)
end


end





