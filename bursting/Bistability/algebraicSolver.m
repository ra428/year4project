function [sol_tau, sol_T] = algebraicSolver(alpha, beta, gamma, ts, kb, u);
A = -1/ts;
B = kb/ts;
C = 1;
D = 0.5*kb*gamma;

% Relay
e2 = beta - alpha -kb*u;
e1 = - beta - alpha - kb*u;
d = 1;
syms T tau
[sol_tau, sol_T] = solve(C*((1-exp(A*T))^-1)*(exp(A*(T-tau))*(B/A)*(exp(A*tau)-1)-(B/A)*(exp(A*(T-tau))-1))+D == -e2, C*((1-exp(A*T))^-1)*(-exp(A*(tau))*(B/A)*(exp(A*(T-tau)-1)+(B/A)*(exp(A*(tau))-1)))-D == -e1, [tau, T]);

end
