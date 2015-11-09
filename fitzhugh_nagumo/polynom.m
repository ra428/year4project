function z = polynom(b,p)
% function z = polynom(b,p)
% returns real root of bz - 1/(1 + z^p) = 0
% uses matlab function root() to find roots of polynomial
% page 246 of Computation Cell Biology

z = [];
poly = zeros(1,p+2);
% bz^(p+1)+ bz -1 = -
poly(1,end) = -1;
poly(1,end-1) = b;
poly(1,1) = b;

r = roots(poly);

for i = linspace(1,size(r,1),size(r,1))
    if isreal(r(i))
        z = r(i);
        return
    end
end

% Computational accuracy not good enough?
if size(z,1)<1
    for i = linspace(1,size(r,1),size(r,1))
        r(i)
        if imag(r(i))<0.0001
            z = r(i);
            return
        end
    end
end
