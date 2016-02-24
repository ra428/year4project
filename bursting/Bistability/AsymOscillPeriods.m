%
% function t = AsymOscillPeriods(beta, gamma, ts, kb, u)
% % kb = -0.5
% % alpha = 0.5;
% % beta = 0.27;
% % gamma = 1;
% % u = 0.5;
%
% % Matlab's nonlinear solver to find minimum of a cost function
% Aineq = [-1 0; 0 -1; 1 -1]; % Contrain to positive solutions
% bineq = [0; 0; 0];
%
% iterMax = 10;
% alphaRange = linspace(0,1,iterMax);
%
% % System
% A = -1/ts;
% B = kb/ts;
% C = 1;
% D = 0.5*kb*gamma;
% d = 1;
%
% for i = 1:iterMax
%
%     alpha = alphaRange(i);
%
%     % Relay
%     e2 = beta - alpha -kb*u;
%     e1 = - beta - alpha - kb*u;
%
%     % Solver
%     myScalarFun = @(x) costFunction(x,A,B,C,D,e1,e2,d);
%     t(i,:) =fmincon(myScalarFun, [0.1,0.2], Aineq, bineq,[],[],[0,0],[1,1] );
%
%     %     % Choose only actual solutions
%     %     fh(i,:) = evalEqtn5_2_variant(t,A,B,C,D,e1,e2,d);
%
% end
%
% %% Plot results
% figure()
% plot(alphaRange,t(:,1),'r')
% hold on
% plot(alphaRange,t(:,2),'b')
% xlabel('\alpha')
% ylabel('Time')
% legend('\tau','T')
%
%
% %% Astrom's Eqtn5.2
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
%         fh(1) = -D*d + C*((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d) + e1;
%
%         % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) + ε1 = 0
%         fh(2) = D*d + C * ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d) + e2;
%
%     end
% %% Cost function
%     function c = costFunction(t,A,B,C,D,e1,e2,d)
%
%         % Unknows that we are solving for
%         tau = t(1);
%         T = t(2);
%
%         % Simplify notation
%         F = @(s) exp(A*s);          % Φ(s)
%         G = @(x) B * (F(x)-1)/A;    % Γ(s)
%         I = eye(size(A));
%
%         % Equation 5.2 with non zero D and different ε for each side
%         % Dd + C(I-Φ)^-1 (Φ2Γ1d - Γ2d) + ε2 = 0
%         fh1 = -D*d + C*((I - F(T))^-1)*(F(T - tau) * G(tau)*d - G(T - tau)*d) + e1;
%         % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) + ε1 = 0
%         fh2 = +D*d + C * ((I - F(T))^-1)* (-F(tau) * G(T- tau)*d + G(tau)*d) + e2;
%
%         c = abs(fh1) + abs(fh2);
%     end
%
%
%
% end

% Old version
function [tau2,T2] = AsymOscillPeriods(alpha, beta, gamma, ts, kb, u)
% kb = -0.5
% alpha = 0.5;
% beta = 0.27;
% gamma = 1;
% u = 0.5;

A = -1/ts;
B = kb/ts;
C = 1;
D = 0.5*kb*gamma;
itermax = 100;
a = linspace(0,1,itermax);

for i = 1:itermax
    alpha = a(i);
    
    % Relay
    e2 =  beta - alpha -kb*u;
    e1 = - beta - alpha - kb*u;
    d = 1;
    m = (D+e2)/(D-e1);
    n = (D-e1)*(A/(C*B));
    
    A1 = m*n-1;
    B1 = n*(1-m) + 2*m;
    C1 = -m*(n+1);
    
    x1 = (-B1 + sqrt(B1^2 - 4*A1*C1))/(2*A1);
    x2 = (-B1 - sqrt(B1^2 - 4*A1*C1))/(2*A1);
    
    tau1(i) = log(x1)/A;
    tau2(i) = log(x2)/A;
    
    T1(i) = log((2*m*x1+1-m)/(2*m/x1 -1 +m))/A;
    T2(i) = log((2*m*x2+1-m)/(2*m/x2 -1 +m))/A;
    
end

T1(imag(T1)~=0) = 0;
tau1(imag(tau1)~=0) = 0;
T2(imag(T2)~=0) = 0;
tau2(imag(tau2)~=0) = 0;


figure()
plot(a,T1,'b')
hold on
plot(a,tau1,'r')
legend('T','\tau')
xlabel('\alpha')
ylabel('Time')
hold off

figure()
plot(a,T2,'b')
hold on
plot(a,tau2,'r')
legend('T','\tau')
xlabel('\alpha')
ylabel('Time')
hold off
end
