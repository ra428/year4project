function dxdt = Rinzel(t,x)
% Rinzel model for bursting from the paper:
% A formal classification o bursting mechanisms in Excitable systems (1986)

dxdt(1,1) = (x(1)-(1/3)*x(1)^3 - x(2) + x(3) + 0.3125);
dxdt(2,1) = 0.08*(x(1) + 0.7- 0.8*x(2));
dxdt(3,1) = 0.0001*(-x(1)-0.775 -x(3));