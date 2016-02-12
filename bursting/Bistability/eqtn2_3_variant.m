function h = eqtn2_3_variant(hArray, A, B, C, D, epsilon, d)
% h = eqtn2_3_variant(hArray, A, B, C, D,epsilon, d )
% evaluate f(h) according to equation 2.3 from Astroms 1995 paper
% 'Oscillations in systems with relay feedback'
% hArray is the interval over which to evaluate f(h)
% A,B,C,D are state space matrices
% epsilon is the relay hysteresis
% d is the relay output
% The variation is that D~=0
% Zeros of this function are the solution to Theorem 2.1

if det(A) ~= 0
    h = C*(A^-1)*tanhm(0.5*A*hArray)*B + D - epsilon/d;
    
else
    fun = @(s) expm(A*s)*B;
    q = integral(fun,0,hArray, 'ArrayValue', true);
    h = C*((eye(size(A)) + expm(A*hArray))^-1)*q + D - epsilon/d;
    
end




    function K = tanhm(M)
        K = tanhm(M)
        Matrix tanh function
        
        if size(M)>1
            sinhm = expm(M) - expm(-M);
            coshm = expm(M) + expm(-M);
            K = sinhm*(coshm^-1);
        else
            K = tanh(M);
        end
        
        
    end

end
