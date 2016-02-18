function p = eqtn2_3(h, A, B, C)
% p = theorem1(h, A, B, C)
% evaluate f(h) according to equation 2.3 from Astroms 1995 paper
% 'Oscillations in systems with relay feedback'

    I = eye(size(A));
    fun = @(s) expm(A*s)*B;
    G = integral(fun,0,h, 'ArrayValue', true);
    p = C*inv(I + expm(A*h))*G;

    
end

