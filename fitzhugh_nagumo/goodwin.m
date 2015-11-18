function dxdt = goodwin(t,x)
% function dvdt = goodwing(t,v)
% Goodwing Oscillator model
% From Computational cell biology book, 

global p
global b

dxdt = zeros(3,1);  % empty column
% Differential equations
dxdt(1) = -b*x(1) + 1/(1+x(3)^p);   
dxdt(2) = b*(x(1)-x(2));
dxdt(3) = b*(x(2)-x(3));

end


