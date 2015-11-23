function [T tau] = getTandTauForAsymmOscillations(A, e1, e2, d1, d2)
% [T tau] = getTandTauForAsymmOscillations(A, e1, e2, d1, d2)
% assuming B = C = 1
% the relay outputs d1 past e1 and -d2 past e2

a = d1*d1 + d1*A*(e1-e2) - A*A*e1*e2;
b = A*A*e1*e2 + d1*d1 + 2*d1*d2 + d2*d2;
c = d1*d2 - A*(A*e1*e2 + d1*e1-d2*e2);

% Quadratic formula
T1 = (-b + sqrt(b*b - 4*a*c))/(2*a);
T2 = (-b - sqrt(b*b - 4*a*c))/(2*a);

if (T1 < 0 || ~isreal(T1))
    if (T2<0 || ~isreal(T2)) 
        disp('No solutions found')
        T = NaN;
        tau = NaN;
        return;
    else
        T = T2;
    end
else
    T = T1;
end

tau = (1/A)*(log(exp(A*T) * (d2-A*e2) + d1 + A*e2)-log(d1+d2));
