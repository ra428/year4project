N = 100;
d1_test = linspace(0.65, 1, N);
d2_test = linspace(-0.2829,0.1,N);

T = 0.9104; tau = 0.4496;
d1 = 0.9864;
d2 = 0.2829;

for j = 1:N
    for i = 1:N
        e = getAsymmetricRelayHysteresisForFitzNagumo(T,tau,d1_test(i),d2_test(j));
        epsilon_1(i,j) = e(1);
        epsilon_2(i,j) = e(2);
    end
end




