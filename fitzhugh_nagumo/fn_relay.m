function dydt = fn_relay(t,y)
% function dvdt = fitzhugh_nagumo(t,v)
% FitzHugh-Nagumo model
% From Keener and Sneyd book, equations (5.38), (5.39). (5.40)
global v
global f_relay


I_app = 0.5;        % External applied current
epsilon = 0.01;     % Controls how 'fast' v is compared to w
gamma = 0.5;        % Parameter in equation (5.39)
dydt = zeros(2,1);  % empty column
dydt(1) = (NL_resistor(y(1)) - y(2) + I_app)/epsilon; % Equation (5.38)
dydt(2) = y(1) - gamma*y(2);        % Equation (5.39)

    function F = NL_resistor(e)
        % function F = NL_Resistor(v)
        % Model the nonlinear resistor with input V and alpha (optional)
        % Equation (5.40) in Keener and Sneyd book
        alpha = 0.1;            % Control the shape of F(V)
        %F = v*(1-v)*(v-alpha);
        if (size(f_relay,1)>0)
            if e<0.5 | (f_relay(end)>0.8 && e<0.625)
                F = -1e-7*e + 1;
                f_relay(end+1) = F;
            else
                F = -1e-7*e - 0.2;
                f_relay(end+1) = F;
            end
        else
            F = 1;
            f_relay(1) = F;
        end
        
    end

end



%%
% % %         if(size(f_relay,1)>0)
% % %             if (f_relay(end) >= 1 && e < 0.65)|  e<0.475
% % %                 F = 1.5;
% % %             else
% % %                 F = -0.7;
% % %             end
% % %             f_relay(end+1) = F;
% % %         else
% % %             F = 1.5; % based on thhe initial conditions (0.5,0.5)
% % %             f_relay(1) = F;
% % %         end
