function p = eqtn2_3(h, A, B, C)
% p = theorem1(h, A, B, C)
% evaluate f(h)^2 according to equation 2.3 from Astroms 1995 paper
% 'Oscillations in systems with relay feedback'

if det(A) ~= 0
    p = C*(A^-1)*tanhm(0.5*A*h)*B;

else
    fun = @(s) expm(A*s)*B;
    q = integral(fun,0,h, 'ArrayValue', true);
    p = C*((eye(size(A)) + expm(A*h))^-1)*q;
    
end

    %p = abs(p);
    
end

