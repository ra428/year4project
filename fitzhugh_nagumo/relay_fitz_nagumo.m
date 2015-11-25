%% Test out FitzHugh-Nagumo model from Keener and Sneyd Chapter 5
clear all
close all

%% ODE solver
tmax = 3;
tspan = [0 tmax];      % Time interval
v0 = [0.9;0.5];        % Intial condition [voltage current]
[t,v] = ode15s(@fitzhugh_nagumo, tspan, v0);

%% Set up variables for simulink
I_app = 0.5;
T = 0.519; tau = 0.1975;

% Relay properties
epsilon_1 = -.0643; 
epsilon_2 = .0643;   
d1 =0.4912;
d2 =0.49215;

% Transformation variables
beta1 = 0.3540;
beta2 = 1.0619;
gamma = 0.5;
alpha = -2;

% State-space
A = gamma-alpha;
B = 1; C = 1; D = 0;

% Astrom's theory for initial conditions and stability of system
[a1 , a2 ] = getInitialConditionsAsymmRelay(A,B,C,d1,d2,T,tau);     X0 =a2;
stable = checkStability(A,B,C,T,tau,d1,d2) % Stability check

%% Simulink
set_param('fitz_relay', 'StopTime', 'tmax')
set_param('fitz_relay/Relay','OffOutputValue','d1','OnOutputValue','-d2','OffSwitchValue','epsilon_1', 'OnSwitchValue','epsilon_2' )
set_param('fitz_relay/State-Space','A','A','B','B','C','C','D','D','X0','X0')
simulate_fitz = sim('fitz_relay'); 

%% Recover actual results
actual_voltage = relay_output.data+alpha*current.data + beta1;
actual_current = current.data + beta2 - I_app;

%% Plot Results
% Action potential
figure(1)
plot(t,v(:,1))
hold on
plot(relay_output.time,actual_voltage )
xlabel('Time')
ylabel('Voltage')
legend('FitzHugh-Nagumo','Relay feedback')
hold off

% limit cycle
figure(2)
plot(v(:,2),v(:,1))
hold on
plot(actual_current,actual_voltage)
xlabel('Current')
ylabel('Voltage')

% cubic nullcline
v2 = linspace(min(v(:,1))-0.1, max(v(:,1))+0.1, 100);
alpha_cubic = 0.1; 
f = (-v2.^3 + (1+alpha_cubic).*v2.^2 - alpha_cubic.*v2)+I_app;
plot(f,v2,'--')
% axis([0.35 0.8 -0.4 1])
legend('FitzHugh-Nagumo','Relay feedback', 'Cubic nullcline')


