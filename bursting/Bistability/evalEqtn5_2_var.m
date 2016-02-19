function fh = evalEqtn5_2_var(t,alpha, beta, gamma, ts, kb, u)

tau = t(1);
T = t(2);

A = -1/ts;
B = kb/ts;
C = 1;
D = 0.5*kb*gamma;
itermax = 100;
a = linspace(0,1,itermax);


% Relay
e2 =   beta - alpha -kb*u;
e1 = - beta - alpha - kb*u;
d = 1;

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
c = abs(fh(1)) + abs(fh(2))

end