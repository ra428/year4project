function e = getAsymmetricRelayHysteresisForFitzNagumo(T,tau,d1,d2)
% function e = getAsymmetricRelayHysteresisForFitzNagumo(T,tau,d1,d2)
A = -0.5;
B = 1;
C = 1;

fun = @(s) exp(A*s)*B;
Gamma_1 = integral(fun,0,tau, 'ArrayValue', true);
Gamma_2 = integral(fun, 0, T-tau, 'ArrayValue', true);
Phi = fun(T);
Phi_1 = fun(tau);
Phi_2 = fun(T-tau);

e(1,1) =  C*(eye(size(A,1)) - Phi)^-1 * (Phi_2*Gamma_1*d1 - Gamma_2*d2);
e(2,1) =  C*(eye(size(A,1)) - Phi)^-1 * (-Phi_1*Gamma_2*d2 + Gamma_1*d1);

