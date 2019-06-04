classdef fireAgent
    %FIREAGENT Defines the properties of a fire agent and allows it to be
    %instantiated
    
    properties
        r                              %reaction velocity             
                                       % = rate of fuel consumption / rate
                                       % of combustion of fuel
        %rPot                          %potential reaction velocity
        %rPotMax                       %max potential reaction vel
        %packingRatioOpt;              %optimum packing ratio,         fraction
        %beta;                         %packing ratio/opt pack ratio,  unitless
        %A;                            %Coefficient used to calc rPot, unitless
        Ir                             %reaction intensity:
                                       %rate of heat release per unit
                                       %area of ground,
                                                                       %Btu/ft^2/min
    end
    
    methods
        function obj = fireAgent(fuelType,mf)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.r = calculateReactionVelocity(fuelType,mf);
            obj.Ir = calculateReactionIntensity(fuelType,obj.r);            
        end
    end
end

