% Parameters
% kb = -0.5;
% % kb = -1;
% % alpha = 0.5;
% beta = 0.37;
% % beta = 0.5;
% gamma = 0;
% delta = 0.5;
% u = 0.8;
% % u = 0.7;
% alpha_const = 0.0;
% tf = 0.0075;
% ts = 1;
% tus = 800;
% tmax = 2000;
% ultra_slow_plant_X0 = 0.45;
% slow_plant_X0 = -1.0;
% fast_plant_X0 = -1.0;

kb = -0.5;
alpha = 0.45;
beta = 0.37;
gamma = 0;
delta = 0.5;
u = 0.8;
alpha_const = 0.0;
tf = 0.0075;
ts = 1;
% ts=10;
tus = 800;
% tus = 50;
tmax = 2000;
ultra_slow_plant_X0 = 0.45;
% ultra_slow_plant_X0 = 0.61;
slow_plant_X0 = -1.0;
fast_plant_X0 = -1.0;

% <<<<<<< HEAD
% =======
% % alphaMin = 0.4;
% % alphaMax = 0.47;
% >>>>>>> 55341b22f5267b1b1a2725c90498be2e9150f8ce
alphaMin = 0.2;
alphaMax = 0.8;
iterMax = 100;
alphaArray = linspace(alphaMin,alphaMax,iterMax);

for i = 1:iterMax
    alpha = alphaArray(i);
    [t(:,i),fval] = findPeriodForAsymmOscill2(alpha, beta, gamma, ts, kb, u);
    averagedRelay(i) = 2*t(1,i)/t(2,i)-1;
end

% figure()
% axis([alphaMin, alphaMax, 0, 8])
% plot(alphaArray,t(1,:),'b-')
% hold on
% plot(alphaArray,t(2,:),'r-')
% plot(alphaArray,averagedRelay(:),'g-')
% legend('\tau','T','averagedRelay')
% xlabel('\alpha')
% ylabel('Time')
% 
% axis([alphaMin, alphaMax, 0, 8])


figure()
p1 = plot(alphaArray,t(1,:),'b-')
hold on
p2 = plot(alphaArray,t(2,:),'r-')
l1 = legend('\tau','T')
xlabel('x_{us}')
ylabel('Time')
axis([0.3, 0.55, 0, 8])
set(p1,'LineWidth',2)
set(p2,'LineWidth',2)
set(l1,'FontSize',16)

figure()
p3 = plot(alphaArray,averagedRelay(:),'g-')
hold on
p4 = plot(SimOut.get('ultra_slow').Data,filtered_xf,'r')
xlabel('x_{us}')
ylabel('\langle x_f \rangle')
set(p3,'LineWidth',2)
set (p4,'LineWidth',2)
axis([0.3, 0.55, -1, 1])

