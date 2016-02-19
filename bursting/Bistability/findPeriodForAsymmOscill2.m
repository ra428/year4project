function t = findPeriodForAsymmOscill2(alpha, beta, gamma, ts, kb, u)
% Use Astroms Eqtn 5.2 to get T and τ for a relay feedback oscillation
% Typical values for the input arguemts are 
% alpha = 0.5;  % The ultra-slow plant output, assumed to be constant
% beta = 0.27;  % The positive feedback gain around the relay
% gamma = 1;    % The negative feedback gain around the outer loop
% ts = 1;       % Slow plant time constant
% kb = -0.5     % Slope of the bump when spiking
% u = 0.5;      % External input into the system

A = -1/ts;
B = kb/ts;
C = 1;
D = 0.5*kb*gamma;

% Relay 
e2 = beta - alpha -kb*u;
e1 = - beta - alpha - kb*u;
d = 1;

% myFun = @(x) evalEqtn5_2_variant(x,A,B,C,D,e1,e2,d);
myScalarFun = @(x) costFunction(x,A,B,C,D,e1,e2,d);

% Matlab's nonlinear solver to find minimum of a cost function
Aineq = [-1 0; 0 -1; 1 -1]; % Contrain to positive solutions
bineq = [0; 0; 0];
t = fmincon(myScalarFun, [0.1,0.2], Aineq, bineq,[],[],[0,0],[1,1] );

% % Display final solution
% disp('Cost of the solution')
% c = costFunction(t,A,B,C,D,e1,e2,d)

    function c = costFunction(t,A,B,C,D,e1,e2,d)
        
        % Unknows that we are solving for
        tau = t(1);
        T = t(2);
        
        % Simplify notation
        F = @(s) exp(A*s);          % Φ(s)
        G = @(x) B * (F(x)-1)/A;    % Γ(s)
        I = eye(size(A));
                       
        % Equation 5.2 with non zero D and different ε for each side
        % Dd + C(I-Φ)^-1 (Φ2Γ1d - Γ2d) + ε2 = 0
        fh1 = D*d + C*((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d) + e2;
        
        % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) + ε1 = 0
        fh2 = -D*d + C * ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d) + e1;
        
        % The cost function is at a minimum when fh1 = fh2 = 0
        c = abs(fh1) + abs(fh2);
    end

end


