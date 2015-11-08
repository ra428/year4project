function output = theorem5_1 (A, B, C, epsilon_1,epsilon_2,d1,d2,T,tau)
% Evaluates equations 5.2  (all moved to LHS) of Astroms 1995 paper,
% modified for the finding limit cycles for FitzHugh-Nagumo with relay
% approximation.
% Theorem 5.1 adapted (e = y, so minus signs disappear)
% C(I - \Phi)^{-1}(\Phi_2\Gamma_1d_1 - \Gamma_2d_2) = \epsilon_1
% C(I - \Phi)^{-1}(-\Phi_1\Gamma_2d_2 + \Gamma_1d_1) = \epsilon_2
%
% function output = theorem5_1 (A,B,C,epsilon_1, epsilon_2, d1,d2,T,tau)
% this uses a relay element that is NOT symmetric, that is why there are
% four inputs related to the relay characteristics
% output is EVERY TERM moved to LEFT hand side of the equations


fun = @(s) expm(A*s)*B;
Gamma_1 = integral(fun,0,tau, 'ArrayValue', true);
Gamma_2 = integral(fun, 0, T-tau, 'ArrayValue', true);
Phi = fun(T);
Phi_1 = fun(tau);
Phi_2 = fun(T-tau);

output(1,1) = -epsilon_1 + C*(eye(size(A,1)) - Phi)^-1 * (Phi_2*Gamma_1*d1 - Gamma_2*d2);
output(2,1) = -epsilon_2 + C*(eye(size(A,1)) - Phi)^-1 * (-Phi_1*Gamma_2*d2 + Gamma_1*d1);

% x = fsolve(@(x) theorem5_1(A,B,C,epsilon_1,epsilon_2,d1,d2,x(1),x(2)),[1 0.2])

end
