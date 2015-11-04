% FitzHugh-Nagumo model



    tspan = [0 100]; % Time interval
    v0 = 0.5 ; % Initial condition
    
    [t,v ] = ode45(@dstate, tspan, v0);
    plot(t,y)
    function dstate(t,v)
    
        function F = NL_Resistor(V,varargin)
        % function F = NL_Resistor(V,varargin)
        % Model the nonlinear resistor with input V and alpha (optional)
            if size(varargin,1)<0
                alpha = 0.1;
            else
                alpha = varargin(1);
            end

            F = V*(1-V)*(V-alpha);
        end

end
