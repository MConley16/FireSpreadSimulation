function Land = runSimBackUp(Land,duration,Ip,fuelType)
%Run the simulation: Let fire start at specified point and let it burn 
%for the specified amount of time

%If isn't working anymore, get rid of "and if state = burning" on restime
%checks, and all display related lines

global heatofC;
global resTime;

%Draw initial board
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
image(LandStateImage)
hold on

% LandHeatNumeric = zeros(size(Land,1), size(Land,1));
% for i = 1:size(LandHeatNumeric,1)
%     for j = 1:size(LandHeatNumeric,1)
%         LandHeatNumeric(i,j) = Land(i,j).currentHeat;    
%     end
% end   
% 
% colormap(jet(10e+03))
% image(LandHeatNumeric)
% hold on

%Repeat until reach end time
for time = 1:duration
    %Check all units each time that clock steps
    for i = 1:size(Land,1)
        for j = 1:size(Land,1)
           %For each land unit that is burning, calculate the heat that
           %is absorbed by all of surrounding unburnt units
           if Land(i,j).state == "Burning"
               % 1. North
               if(i-1>0) %check if out of bounds
                   if Land(i-1,j).state == "Not Burnt" 
                        Land(i-1,j).currentHeat = Land(i-1,j).currentHeat+Ip(1);    
                       if Land(i-1,j).currentHeat >= heatofC(fuelType) && Land(i-1,j).state == "Not Burnt"
                           Land(i-1,j).state = "Burning"; 
                           LandStateImage(i-1,j) = 85;
                           hold on
                           image(LandStateImage)  
                           pause(0.01)
                       end
                   end
               end    
               % 2. NorthEast
               if(i-1>0 && j+1<=size(Land,1))
                 if Land(i-1,j+1).state == "Not Burnt"     
                        Land(i-1,j+1).currentHeat = Land(i-1,j+1).currentHeat+Ip(2);   
                        if Land(i-1,j+1).currentHeat >= heatofC(fuelType) && Land(i-1,j+1).state == "Not Burnt"
                           Land(i-1,j+1).state = "Burning"; 
                           LandStateImage(i-1,j+1) = 85;
                           hold on
                           image(LandStateImage)
                           pause(0.01)
                        end
                 end
               end  
               % 3. East
               if(j+1<=size(Land,1))
                  if Land(i,j+1).state == "Not Burnt"     
                         Land(i,j+1).currentHeat = Land(i,j+1).currentHeat+Ip(3);   
                         if Land(i,j+1).currentHeat >= heatofC(fuelType) && Land(i,j+1).state == "Not Burnt"
                            Land(i,j+1).state = "Burning";
                            LandStateImage(i,j+1) = 85;
                            hold on
                            image(LandStateImage)
                            pause(0.01)
                         end
                  end
               end   
               % 4. SouthEast
               if(i+1<=size(Land,1) && j+1<=size(Land,1))
                   if Land(i+1,j+1).state == "Not Burnt"     
                         Land(i+1,j+1).currentHeat = Land(i+1,j+1).currentHeat+Ip(4);   
                         if Land(i+1,j+1).currentHeat >= heatofC(fuelType) && Land(i+1,j+1).state == "Not Burnt"
                            Land(i+1,j+1).state = "Burning";
                            LandStateImage(i+1,j+1) = 85;
                            hold on
                            image(LandStateImage)
                            pause(0.01)
                         end
                   end
               end    
               % 5. South
               if(i+1<=size(Land,1))
                    if Land(i+1,j).state == "Not Burnt"     
                         Land(i+1,j).currentHeat = Land(i+1,j).currentHeat+Ip(5);   
                         if Land(i+1,j).currentHeat >= heatofC(fuelType) && Land(i+1,j).state == "Not Burnt"
                            Land(i+1,j).state = "Burning";
                            LandStateImage(i+1,j) = 85;
                            hold on
                            image(LandStateImage)
                            pause(0.01)
                         end
                    end
               end
                % 6. SouthWest
                if(i+1<=size(Land,1) && j-1>0)
                    if Land(i+1,j-1).state == "Not Burnt"     
                         Land(i+1,j-1).currentHeat = Land(i+1,j-1).currentHeat+Ip(6);   
                         if Land(i+1,j-1).currentHeat >= heatofC(fuelType) && Land(i+1,j-1).state == "Not Burnt"
                            Land(i+1,j-1).state = "Burning";
                            LandStateImage(i+1,j-1) = 85;
                            hold on
                            image(LandStateImage)
                            pause(0.01)
                         end
                    end
                end    
                % 7. West  
                if(j-1>0)
                    if Land(i,j-1).state == "Not Burnt"     
                         Land(i,j-1).currentHeat = Land(i,j-1).currentHeat+Ip(7);   
                         if Land(i,j-1).currentHeat >= heatofC(fuelType) && Land(i,j-1).state == "Not Burnt"
                            Land(i,j-1).state = "Burning";
                            LandStateImage(i,j-1) = 85;
                            hold on
                            image(LandStateImage)
                            pause(0.01)
                         end
                    end
                end
               % 8. NorthWest 
               if(i-1>0 && j-1>0)
                    if Land(i-1,j-1).state == "Not Burnt"     
                         Land(i-1,j-1).currentHeat = Land(i-1,j-1).currentHeat+Ip(8);   
                         if Land(i-1,j-1).currentHeat >= heatofC(fuelType) && Land(i-1,j-1).state == "Not Burnt"
                            Land(i-1,j-1).state = "Burning"; 
                            LandStateImage(i-1,j-1) = 85;
                            hold on
                            image(LandStateImage)
                            pause(0.01)
                         end
                    end
               end 
               %Increase time that current unit has been burning,
               %If reached total flame residence time, then it is
               %done burning and extinguishes
               Land(i,j).timeBurning = Land(i,j).timeBurning+1;
               if Land(i,j).timeBurning >= (resTime(fuelType)) && Land(i,j).state == "Burning"
                   Land(i,j).state = "Burnt";
                   LandStateImage(i,j) = 100; 
                   hold on
                   image(LandStateImage)
                   pause(0.01)
               end              
           end    
        end
    end   
end


