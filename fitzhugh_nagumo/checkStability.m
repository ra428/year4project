function stable = checkStability(A,B,C,T,tau,d1,d2)
% Test out theorem 5.2 from Astroms 1995 paper
% function stable = checkStability(A,B,C,T,tau,d1,d2)

fun = @(s) expm(A*s);
Gamma_1 = integral(fun,0,tau, 'ArrayValue', true)*B;
Gamma_2 = integral(fun, 0, T-tau, 'ArrayValue', true)*B;
Phi = fun(T);
Phi_1 = fun(tau);
Phi_2 = fun(T-tau);

a1 =  (eye(size(A,1)) - Phi)^-1 * (Phi_2*Gamma_1*d1 - Gamma_2*d2)
a2 =  (eye(size(A,1)) - Phi)^-1 * (-Phi_1*Gamma_2*d2 + Gamma_1*d1);

w1 = Phi_1*(A*a1 + B*d1);
w2 = Phi_2*(A*a2 - B*d2);

W = (eye(size(w2*C,1)) - (w2*C)/(C*w2))*Phi_2*...
    (eye(size(w1*C,1)) - (w1*C)/(C*w1))*Phi_1;

lambda = eig(W);

for i = 1:size(lambda,1)
    if lambda(i)>= 1
        stable = false;
        return;
    end
end

stable = true;

