
function t = findPeriodForAsymmOscill(alpha, beta, gamma, ts, kb, u)
% kb = -0.5
% alpha = 0.5;
% beta = 0.27;
% gamma = 1;
% u = 0.5;

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


% Matlabs solver to find minimum of a function
% % x* = fsolve(function, X0)
% t = fsolve(myFun, [0.5, 0.6]);

% Matlab's nonlinear solver to find minimum of a cost function
Aineq = [-1 0; 0 -1; 1 -1]; % Contrain to positive solutions
bineq = [0; 0; 0];
t = fmincon(myScalarFun, [0.1,0.2], Aineq, bineq,[],[],[0,0],[1,1] );

    function fh = evalEqtn5_2_variant(t,A,B,C,D,e1,e2,d)
        
        % Unknows that we are solving for
        tau = t(1);
        T = t(2);
        
        % Simplify notation
        F = @(s) exp(A*s);          % Φ(s)
        G = @(t) B * (F(t)-1)/A;    % Γ(s)
        I = eye(size(A));
        
        fh = [0;0];
        
        % Equation 5.2 with non zero D and different ε for each side
        % Dd + C(I-Φ)^-1 (Φ2Γ1d - Γ2d) + ε2 = 0
        fh(1) = D*d + C*((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d) + e2;
        
        % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) + ε1 = 0
        fh(2) = -D*d + C * ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d) + e1;

    end

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
        
% %         % Dd + C(I-Φ)^-1 (Φ2Γ1d - Γ2d) + ε2 = 0
% %         fh1 = -D*d + C*((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d) + e1;
% %         % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) + ε1 = 0
% %         fh2 = +D*d + C * ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d) + e2;
% %         
        c = abs(fh1) + abs(fh2);
    end

% %% New algebraic solution
% A1 = (2*C*B/A)*(e1+e2)+2*(D+e2)*(C*B/A + e1 -D);
% B1 = (e1+e2)*(e1-D-C*B/A) + 4*(C*B/A)*(D-e1) + (e1+e2)*(D-e1-C*B/A);
% C1 = 2*(D-e1)*(e1-D-C*B/A);
% % Only one of the two solutions seem plausible
% x1 = (-B1 + sqrt(B1^2 - 4*A1*C1))/(2*A1);
% x2 = (-B1 - sqrt(B1^2 - 4*A1*C1))/(2*A1);
% 
% tau1 = log(x1)/A
% tau2 = log(x2)/A
% 
% T1 = log((e1+e2 - 2*x1*(D+e2))/(e1 + e2 + 2*x1*(D-e1)))/A
% T2 = log((e1+e2 - 2*x2*(D+e2))/(e1 + e2 + 2*x2*(D-e1)))/A

% % My own algebraic solution for the scalar case
% a1 = D -e1- C*B/A;
% a2 = -C*B/A + e1 -D;
% a3 = (e1 + e2)*C*B/A;
% a4 = -e1 + D;
% a5 = -e2 -D;
% 
% A1 = a1*a4;
% B1 = a1*a5 + a2*a4 - a3;
% C1 = a2*a5 -a3;
% 
% % Only one of the two solutions seem plausible
% x1 = (-B1 + sqrt(B1^2 - 4*A1*C1))/(2*A1);
% x2 = (-B1 - sqrt(B1^2 - 4*A1*C1))/(2*A1);
% 
% T1 = log(x1)/A
% T2 = log(x2)/A
% tau1 = log(0.5*(e1+e2)*(x1 + 1)/((e1 + D)*x1 + e2 -D))/A
% tau2 = log(0.5*(e1+e2)*(x2 + 1)/((e1 + D)*x2 + e2 -D))/A

end


%% Old version

% function t = findPeriodForAsymmOscill(alpha, beta, gamma, ts, kb, u)
% % kb = -1/2 usually
% % alpha = 0.5;
% % beta = 0.27;
% % gamma = 1;
% % u = 0.5;
% A = -1/ts;
% B = kb/ts;
% C = 1;
% D = 0.5*kb*gamma;
% 
% e2 = -1 + beta - alpha -kb*u;
% e1 = 1 - beta - alpha - kb*u;
% e1 = -e1; % Since e = -y
% e2 = -e2; % Since e = -y
% d = 1;
% 
% myFun = @(x) evalEqtn5_2_variant(x,A,B,C,D,e1,e2,d);
% 
% % Matlabs solver to find minimum of a function
% % x* = fsolve(function, X0)
% t = fsolve(myFun, [0.01, 0.2]);
% 
% 
% 
%     function fh = evalEqtn5_2_variant(t,A,B,C,D,e1,e2,d)
%         
%         % Unknows that we are solving for
%         tau = t(1);
%         T = t(2);
%         
%         % Simplify notation
%         F = @(s) exp(A*s);          % Φ(s)
%         G = @(t) B * (F(t)-1)/A;    % Γ(s)
%         I = eye(size(A));
%         
%         fh = [0;0];
%         
%         % Equation 5.2 with non zero D and different ε for each side
%         % Dd + C(I-Φ)^-1 (Φ2Γ1d - Γ2d) + ε2 = 0
%         fh(1) = D*d + C*((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d) - e2;
%         
%         % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) - ε1 = 0
%         fh(2) = -D*d + C * ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d) - e1;
% 
%     end
% 
% 
% 
% % My own algebraic solution for the scalar case
% a1 = e1 + D - C*B/A;
% a2 = -C*B/A -e1 -D;
% a3 = -(e1 + e2)*C*B/A;
% a4 = e1 + D;
% a5 = e2 -D;
% 
% A1 = a1*a4;
% B1 = a1*a5 + a2*a4 - a3;
% C1 = a2*a5 -a3;
% 
% % Only one of the two solutions seem plausible
% %x1 = (-B1 + sqrt(B1^2 - 4*A1*C1))/(2*A1);
% x2 = (-B1 - sqrt(B1^2 - 4*A1*C1))/(2*A1);
% 
% %T1 = log(x1)/A
% T2 = log(x2)/A
% %tau1 = log(0.5*(e1+e2)*(x1 + 1)/((e1 + D)*x1 + e2 -D))/A
% tau2 = log(0.5*(e1+e2)*(x2 + 1)/((e1 + D)*x2 + e2 -D))/A
% 
% end

