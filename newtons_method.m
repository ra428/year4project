
function x_n = newtons_method(x0, epsilon, d, A, B, C, varargin);

% Apply Netwon's method to find the roots
% half_period = (x0, epsilon, d, A, B, C, varargin);
% x0 =  initial point
% epsilon = relay hysteresis
% d = relay output
% A,B,C = state space matrices
% varargin(1) = iter_max (default = 1000)
% varargin(2) = tolerance_min (default = 0.0001)

% Symmetric or non symmetric relay output
if size(d) ~= 1
    d1 = d(1);
    d2 = d(2);
else
    d1 = d;
    d2 = d;
end

% Algorithm parameters
if length(varargin)== 0
    iter_max = 1000;
    tolerance_min = 0.0001;
elseif length(varargin) == 1
    iter_max = varargin(1);
    tolerance_min = 0.0001;
else
    iter_max = varargin(1);
    tolerance_min = varargin(2);
    
end

% Few other initialisations
x_n = x0;
tolerance = eqtn2_3(x_n,A,B,C) - epsilon/d1;
x_n = x_n - tolerance/deqtn2_3(x_n,A,B,C);
tolerance = abs(tolerance);
iterations = 1;



while iterations<iter_max
    if abs(tolerance)>= tolerance_min
        tolerance = eqtn2_3(x_n,A,B,C) - epsilon/d1;
        x_n = x_n - tolerance/deqtn2_3(x_n,A,B,C);
        iterations = iterations + 1;
    else
        break;
    end
   

    
end

fprintf('%d\n Iterations',  iterations)
fprintf('%f\n Tolerance', tolerance)
fprintf('%f\n Root at', x_n)

return








