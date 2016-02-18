function K = tanhm(M)

% K = tanhm(M)
% Matrix tanh function

if size(M)>1
    sinhm = expm(M) - expm(-M);
    coshm = expm(M) + expm(-M);
    K = sinhm*(coshm^-1);
else
    K = tanh(M);
end
    
    
return
    
