A = [-1 0 0 ; 1 -1 0; 0 1 -1];
B = [1; 0 ; 0];C = [0 0 1];D = 0;
d1 = 1; d2 = 0;
I = eye(3);
T = 5.93; tau = 0.19;
Phi = expm(A*T);
Phi1 = expm(A*tau);
Phi2 = expm(A*(T-tau));
Gamma1 = ((Phi1 - I)\A)*B;
Gamma2 = ((Phi2 - I)\A)*B;

a1 = inv((I-Phi))*(Phi2*Gamma1*d1 - Gamma2*d2);
a2 = inv((I-Phi))*(-Phi1*Gamma2*d2 + Gamma1*d1);

w1 = Phi1*(A*a1 + B*d1);
w2 = Phi2*(A*a2 - B*d2);

W = (I-w2*C/(C*w2))*Phi2*(I-w1*C/(C*w1))*Phi1
