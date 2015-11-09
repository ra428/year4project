function [T,tau] = getTimePeriodFitzRelay(d1,d2,e1,e2)

%p = @(x) (2*d1+e2)*(2*d2-e1)*x^2 + 2*(4*d1*d2+e1*e2)*x + ...
%    2*(d1*e1-d2*e2)-e1*e2+4*d1*d2-4*(d1+d2)^2;

p = [(2*d1+e2)*(2*d2-e1), 2*(4*d1*d2+e1*e2),2*(d1*e1-d2*e2)-e1*e2+4*d1*d2-4*(d1+d2)^2];

r = roots(p);

if isreal(r(1))
    T = r(1);
elseif isreal(r(2))
    T = r(2);
else
    error('No real Time period found')
end

tau = 2*log((2*(d1+d2))/(2*d1 - e2 + (2*d1+e2)*exp(-T/2)));
    


end