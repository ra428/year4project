function [a1,a2] = getInitialConditionsAsymmRelay(A,B,C,d1,d2,T,tau)
% function [a1,a2] = getInitialConditionsAsymmRelay(A,B,C,d1,d2,T,tau)
% Equation (5.5) of Astrom's 1995 paper
% It calculates the initial conditions for asymmetric oscillations

% Equations (5.3)
fun = @(s) expm(A*s);
Gamma_1 = integral(fun,0,tau, 'ArrayValue', true) * B;
Gamma_2 = integral(fun, 0, T-tau, 'ArrayValue', true) * B;
Phi = fun(T);
Phi_1 = fun(tau);
Phi_2 = fun(T-tau);

% Equations (5.5)
a1 = inv((eye(size(A)) - Phi)) * (-Phi_1*Gamma_2*d2 + Gamma_1*d1);
a2 = inv((eye(size(A)) - Phi)) * (Phi_2*Gamma_1*d1 - Gamma_2*d2);


