function p = theorem1(h, A, B, C)
% p = theorem1(h, A, B, C)
% evaluate f(h) = C*A^-1(tanhm(0.5*A*h)*B

if det(A) ~= 0
p = C*(A^-1)*tanhm(0.5*A*h)*B;
else
fun = @(s) expm(A*s)*B;
q = integral(fun,0,h, 'ArrayValue', true);
p = C*((eye(size(A)) + expm(A*h))^-1)*q;
end

end

