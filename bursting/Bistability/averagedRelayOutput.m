% Parameters
kb = -0.5;
alpha = 0.5;
beta = 0.37;
gamma = 0;
delta = 0.5;
u = 0.8;
alpha_const = 0.0;
tf = 0.0075;
ts = 1;
tus = 800;
tmax = 2000;
ultra_slow_plant_X0 = 0.45;
slow_plant_X0 = -1.0;
fast_plant_X0 = -1.0;

% alphaMin = 0.4;
% alphaMax = 0.47;
alphaMin = 0.2;
alphaMax = 0.8;
iterMax = 100;
alphaArray = linspace(alphaMin,alphaMax,iterMax);

for i = 1:iterMax
    alpha = alphaArray(i);
    [t(:,i),fval] = findPeriodForAsymmOscill2(alpha, beta, gamma, ts, kb, u);
    averagedRelay(i) = 2*t(1,i)/t(2,i)-1;
end

figure()
plot(alphaArray,t(1,:),'b-')
hold on
plot(alphaArray,t(2,:),'r-')
plot(alphaArray,averagedRelay(:),'g-')
legend('\tau','T','averagedRelay')
xlabel('\alpha')
ylabel('Time')


