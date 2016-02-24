function [t,fval] = findPeriodForAsymmOscill2(alpha, beta, gamma, ts, kb, u)
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
[t,fval,eflag,output] = fmincon(myScalarFun, [0.1,0.2], Aineq, bineq,[],[],[0,0],[1,1] );

e = getAsymmetricRelayHysteresisForFitzNagumo(A,B,C,D,0.2,0.133,d,d)

% stable = checkStability(t,A,B,C,D,e1,e2,d)

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
        fh1 = D*d + C*((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d) - e2;
        
        % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) + ε1 = 0
        fh2 = -D*d + C * ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d) - e1;
        
        % Original
        %         % Equation 5.2 with non zero D and different ε for each side
        %         % Dd + C(I-Φ)^-1 (Φ2Γ1d - Γ2d) + ε2 = 0
        %         fh1 = D*d + C*((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d) + e2;
        %
        %         % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) + ε1 = 0
        %         fh2 = -D*d + C * ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d) + e1;
        
        % The cost function is at a minimum when fh1 = fh2 = 0
        c = abs(fh1) + abs(fh2);
    end


    function stable = checkStability(t,A,B,C,D,e1,e2,d)
        tau = t(1);
        T = t(2);
        
        % Simplify notation
        F = @(s) exp(A*s);          % Φ(s)
        G = @(x) B * (F(x)-1)/A;    % Γ(s)
        I = eye(size(A));
        
        a1 = ((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d);
        a2 = ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d);
        
        w1 = F(tau)*(A*a1 + B*d);
        w2 = F(T-tau)*(A*a2 -B*d);
        
        W = (I - w2*C/w2*C)*F(T-tau)*(I - w1*C/w1*C)*F(T);
        if abs(eig(W) )<1
            stable = true;
        else
            stable = false;
        end
    end

    function e = getAsymmetricRelayHysteresisForFitzNagumo(A,B,C,D,T,tau,d1,d2)
        % function e = getAsymmetricRelayHysteresisForFitzNagumo(T,tau,d1,d2)
        % A = -0.5;
        % B = 1;
        % C = 1;
        
        fun = @(s) expm(A*s);
        Gamma_1 = integral(fun,0,tau, 'ArrayValue', true) * B;
        Gamma_2 = integral(fun, 0, T-tau, 'ArrayValue', true) * B;
        Phi = fun(T);
        Phi_1 = fun(tau);
        Phi_2 = fun(T-tau);
        
        e(1,1) = D*d1 + C*(eye(size(A,1)) - Phi)^-1 * (Phi_2*Gamma_1*d1 - Gamma_2*d2);
        e(2,1) = -D*d2 + C*(eye(size(A,1)) - Phi)^-1 * (-Phi_1*Gamma_2*d2 + Gamma_1*d1);
        
        
    end


end

