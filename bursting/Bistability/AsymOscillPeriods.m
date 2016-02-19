
function [tau2,T2] = AsymOscillPeriods(alpha, beta, gamma, ts, kb, u)
% kb = -0.5
% alpha = 0.5;
% beta = 0.27;
% gamma = 1;
% u = 0.5;

A = -1/ts;
B = kb/ts;
C = 1;
D = 0.5*kb*gamma;
itermax = 100;
a = linspace(0,1,itermax);

for i = 1:itermax
    alpha = a(i);
    
    
    % Relay
    e2 = -1 + beta - alpha -kb*u;
    e1 = 1 - beta - alpha - kb*u;
    d = 1;
    
    % My own algebraic solution for the scalar case
    a1 = D -e1- C*B/A;
    a2 = -C*B/A + e1 -D;
    a3 = (e1 + e2)*C*B/A;
    a4 = -e1 + D;
    a5 = -e2 -D;
    
    % Quadratic formula
    A1 = a1*a4;
    B1 = a1*a5 + a2*a4 - a3;
    C1 = a2*a5 -a3;
%     x2 = (-B1 - sqrt(B1^2 - 4*A1*C1))/(2*A1);
%     Only one of the two solutions seem plausible
    x1 = (-B1 + sqrt(B1^2 - 4*A1*C1))/(2*A1);
    x2 = (-B1 - sqrt(B1^2 - 4*A1*C1))/(2*A1);
    
%     T1(i) = log(x1)/A;
    T2(i) = log(x2)/A;
%     tau1(i) = log(0.5*(e1+e2)*(x1 + 1)/((e1 + D)*x1 + e2 -D))/A;
    tau2(i) = log(0.5*(e1+e2)*(x2 + 1)/((e1 + D)*x2 + e2 -D))/A;
end

% T1(imag(T1)~=0) = 0;
% tau1(imag(tau1)~=0) = 0;
T2(imag(T2)~=0) = 0;
tau2(imag(tau2)~=0) = 0;


% figure()
% plot(a,T1,'b')
% hold on
% plot(a,tau1,'r')
% legend('T','\tau')
% xlabel('\alpha')
% ylabel('Time')
% hold off

figure()
plot(a,T2,'b')
hold on
plot(a,tau2,'r')
legend('T','\tau')
xlabel('\alpha')
ylabel('Time')
hold off
end
