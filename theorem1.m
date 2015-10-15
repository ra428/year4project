function p = theorem1(h, A, B, C)
% p = theorem1(h, A, B, C)
% evaluate f(h) = C*A^-1(tanhm(0.5*A*h)*B

p = C*(A^-1)*tanhm(0.5*A*h)*B;

end

