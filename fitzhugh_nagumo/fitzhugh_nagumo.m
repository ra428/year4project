function dvdt = fitzhugh_nagumo(t,v)
% function dvdt = fitzhugh_nagumo(t,v)
% FitzHugh-Nagumo model
% From Keener and Sneyd book, equations (5.38), (5.39). (5.40)

%I_app = 0.5;        % External applied current    
I_app = 0.5;
epsilon = 1e-10;     % Controls how 'fast' v is compared to w
gamma = 0.5;        % Parameter in equation (5.39)
dvdt = zeros(2,1);  % empty column
dvdt(1) = (NL_resistor(v(1)) - v(2) + I_app)/epsilon; % Equation (5.38)
dvdt(2) = v(1) - gamma*v(2);        % Equation (5.39)

    function F = NL_resistor(v)
        % function F = NL_Resistor(v)
        % Model the nonlinear resistor with input V and alpha (optional)
        % Equation (5.40) in Keener and Sneyd book
        alpha = 0.1;            % Control the shape of F(V)
        F = v*(1-v)*(v-alpha);
        % F = heaviside(v - alpha) - v; 
%         if v <0.5*alpha
%             F = -v;
%         elseif v>0.5*(1+alpha)
%             F = 1-v;
%         else
%             F = v - alpha;
%         end
        
    end
end

