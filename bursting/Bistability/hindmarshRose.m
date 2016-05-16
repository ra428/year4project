function dxdt = hindmarshRose(t,x)
% Hindmarsh-Rose model for bursting from the paper:
% A model of neuronal bursting using three coupled first order differential
% equations (1983)

dxdt(1,1) = (x(2) - x(1)^3 + 3*x(1)^2 + 2 - x(3))/0.000001;
dxdt(2,1) = (1 - 5*x(1)^2 - x(2));
dxdt(3,1) = 0.001*(4*(x(1) + 1.6 ) - x(3));