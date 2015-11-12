% Test out FitzHugh-Nagumo model from Keener and Sneyd Chapter 5
clear all
close all
tmax = 3;

%% Variables for simulink
epsilon_1 = 0.4723; epsilon_2 = 0.6666;
T = 0.9104; tau = 0.4496;
%d1 = 0.9864;d2 = 0.2829;
d1 = 0.9864; d2 =0.2829; 
A = zeros_of_theorem_5_1(epsilon_1, epsilon_2, d1, d2, T, tau)
B = 1; C = 1; D = 0;
% out = getAsymmetricRelayHysteresisForFitzNagumo(A,B,C,T,tau,d1,d2);
% epsilon_1 = out(1)
% epsilon_2 = out(2)
[a1 , a2 ] = getInitialConditionsAsymmRelay(A,B,C,d1,d2,T,tau);
X0 = a1;

 stable = checkStability(A,B,C,T,tau,d1,d2) % Stability check

%% ODE solver
% Set up various variables
tspan = [0 tmax];      % Time interval
v0 = [0.9;0.5];     % Intial condition [voltage current]
[t,v] = ode45(@fitzhugh_nagumo, tspan, v0);


%% Simulink
set_param('fitz_relay', 'StopTime', 'tmax')
set_param('fitz_relay/Relay','OffOutputValue','d1','OnOutputValue','-d2','OffSwitchValue','epsilon_1', 'OnSwitchValue','epsilon_2' )
set_param('fitz_relay/State-Space','A','A','B','B','C','C','D','D','X0','X0')
simulate_fitz = sim('fitz_relay'); % Returns  a variable called 'simout'

%% Show Results
% Action potential
figure(1)
plot(t,v(:,1))
hold on
plot(simout.time,simout.data(:,1))
xlabel('Time')
ylabel('Voltage')
hold off

% limit cycle
figure(2)
plot(v(:,2),v(:,1))
hold on
v2 = linspace(min(v(:,1))-0.1, max(v(:,1))+0.1, 100);
alpha = 0.1; I_app = 0.5;
f = (-v2.^3 + (1+alpha).*v2.^2 - alpha.*v2)+I_app;
%plot(f,v2,'--')
plot(simout.data(:,2),simout.data(:,1))
xlabel('Current')
ylabel('Voltage')
% axis([0.35 0.8 -0.4 1])

