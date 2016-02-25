function modelSimulation()
global dt
dt = 0.001;

e1  = -1; e2 = 1; d1 = 1; d2 = -1; x0 = 0.5; y0 = -1; x = 0.6;
y = simRelay(e1, e2, d1, d2, x0,y0,x)


    function [x,y] = simPlant(A,B,C,D,x,u)
        % State-space model
        global dt
        
    end

    function
        
        function y = bump(u)
            % Bump for delta = 0.5;
            if (u < -2)
                y = -1;
            elseif (u > 2)
                y = -1;
            elseif and( u>=-2,u < 0)
                y = 0.5*u;
            else
                y = -0.5*u;
            end
        end
        
        
        
        function y = simRelay(e1, e2, d1, d2, x0,y0,x)
            % Relay with hysteresis limits (e1<e2)
            % and with output (d1>d2)
            % Needs to check past state (x0, y0)
            if or(x > e2,  and(y0 == d1,x0 >e1))
                y = d1;
            else
                y = d2;
            end
        end
        
    end
