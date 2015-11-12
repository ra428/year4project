function [a1,a2] = getInitialConditionsAsymmRelay(A,B,C,d1,d2,T,tau)
% function [a1,a2] = getInitialConditionsAsymmRelay(A,B,C,d1,d2,T,tau)

fun = @(s) expm(A*s);
Gamma_1 = integral(fun,0,tau, 'ArrayValue', true) * B;
Gamma_2 = integral(fun, 0, T-tau, 'ArrayValue', true) * B;
Phi = fun(T);
Phi_1 = fun(tau);
Phi_2 = fun(T-tau);

a1 = (eye(size(A)) - Phi)^-1 * (Phi_2*Gamma_1*d1 - Gamma_2*d2);
a2 = (eye(size(A)) - Phi)^-1 * (-Phi_1*Gamma_2*d2 + Gamma_1*d1);

