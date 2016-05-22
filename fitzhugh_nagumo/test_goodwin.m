% Test out goodwin
clear all
% close all

global p
global b

% p = 99999999;               % Exponent
% p = 990;
% b = .99;                   % Related to rate of production/consumption

p = 100;
b = .8;

%% Find b small enough to cause oscillations
% z = 1;
% while (b*z >= 1-8/p)
%     b = b - 0.1;
%     z = polynom(b,p);
%     disp ('Still reducing b')
% end

%% Set up variables for Simulink
A = b*[-1 0 0 ; 1 -1 0; 0 1 -1];
B = [1; 0 ; 0];C = [0 0 1];D = 0;
d1 = 1; d2 = 0;
T = 5.93; tau = 0.19;
[a1 a2]= getInitialConditionsAsymmRelay(A,B,C,d2,d1,T,tau);
% X0 = -a1;
X0 = [1;1;1];

%% ODE solver
tmax = 100;
% Set up various variables
tspan = [0 tmax];               % Time interval
% v0 = [1;1.02;1.02;1];         % Intial condition
% [t,v] = ode15s(@goodwin, tspan, X0);
% [t,v] = ode23s(@goodwin, tspan, X0);
[t,v] = ode23tb(@goodwin, tspan, X0);
% [t,v] = ode45(@goodwin, tspan, X0);

%% Simulink
set_param('goodwin_relay','StopTime','tmax')
set_param('goodwin_relay/State-Space','A','A','B','B','C','C','D','D','X0','X0')
simulate_goodwin = sim('goodwin_relay');

%% Show Results
% Circadian rhythim
figure()
plot(t,v(:,3))
hold on
plot(x3.time,x3.data)
xlabel('Time')
ylabel('Concentration')
legend('Goodwin','Relay System')
grid on

% % Relay outputs
% figure(2)
% plot(t,(1+v(:,3).^p).^-1)   % The relay part's behavour
% hold on
% plot(relay_output.time,relay_output.data)
% xlabel('Time')
% ylabel('Ouput')
% legend('Goodwin nonlinear term','Relay output')
% axis([0 tmax -.5 1.5])
