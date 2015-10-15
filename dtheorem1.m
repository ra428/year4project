function a = dtheorem1(h, A, B, C)
% a = dtheorem1(h,A,B,C)
% evaluate df/dh

a =0.5*C*(0.5*(exph(A*h/2) + exph(-A*h/2))^(-2))*B ;


end

