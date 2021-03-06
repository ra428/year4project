%% Variables
alpha = 0.5; % end up oscillating between (0.26-0.78)
beta = 0.27;
gamma = 1;
delta = 0.5;
% u = 0.8;
u = 0.5;
alpha_const = 0.1;
tf = 0.0075;
ts = 1;
tus = 800;
% tus = 20;
tmax = 5000;
ultra_slow_plant_X0 = 0;
% ultra_slow_plant_X0 = 0.61;
slow_plant_X0 = -1.05;
fast_plant_X0 = -1.05;

% State-space variables
kb = 0.5;   % Gradient of piecewise bump
A = -1/ts;
B = kb/ts;
C = 1;
D = 0.5*gamma*kb;
% 
% % Relay hysteresis size
% e1 =  1 - beta + alpha + kb * u;
% e2 = -1 + beta + alpha + kb * u;

% % Relay hysteresis size
% e1 =  1 - 0.5*beta + alpha + kb * u;
% e2 = -1 + 0.5*beta + alpha + kb * u;

e1 =  1 - 0.5*beta - alpha - kb * u;
e2 = -1 + 0.5*beta - alpha - kb * u;

% Plot for various time periods and check for existence of limit cycles
sysParam.A = A;
sysParam.B = B;
sysParam.C = C;
sysParam.D = D;
sysParam.e1 = e1;
sysParam.e2 = e2;
sysParam.T = 5; %3208 - 1548;
sysParam.tau =0.01 %1961 - 1548;
sysParam.u = u;
sysParam.d = 1;
sysParam.alpha = alpha;
sysParam.beta = beta;

% a = 2*e1;
% b = 2*e1*e1 + e1 - e2 + 1;
% c = e1*(1 - e2) + 1;
% x1 = (-b + sqrt(b^2 - 4*a*c)) / (2*a);
% x2 = (-b - sqrt(b^2 - 4*a*c)) / (2*a);
% 
% T1 = log(x1)/A;
% T2 = log(x2)/A;
% 
% tau1 = log((x1*(e1+e2)+e1*e2)/(2*(e1*x1+1)))/A;
% tau1 = log((x2*(e1+e2)+e1*e2)/(2*(e1*x2+1)))/A;

plotEqtn5_2_variant(sysParam);


