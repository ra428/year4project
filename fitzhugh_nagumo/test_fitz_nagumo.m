%% Test out FitzHugh-Nagumo model from Keener and Sneyd Chapter 5

clear all
close all
tmax = 6;

%% ODE solver
% Set up various variables
tspan = [0 tmax];      % Time interval
v0 = [0.9;0.5];        % Intial condition [voltage current]
                       %[t,v] = ode45(@fitzhugh_nagumo, tspan, v0);
[t,v] = ode15s(@fitzhugh_nagumo, tspan, v0);

%% Variables for simulink
I_app = 0.5;
epsilon_1 = -.0643;   %0.4976;
epsilon_2 = .0643;    %0.6262;
                            %                             %T = 0.9104; tau = 0.4496;
                            
beta1 = .3540;
beta2 = 1.0619;
T = 0.519; tau = 0.1975;
                            %d1 = 0.9864; d2 =0.2829; 
d1 =.4912;d2 = .49215;

gamma = 0.5;
alpha = -2;
                            %A = zeros_of_theorem_5_1(epsilon_1, epsilon_2, d1, d2, T, tau);
A = gamma-alpha;
B = 1; C = 1; D = 0;
out = getAsymmetricRelayHysteresisForFitzNagumo(A,B,C,T,tau,d1,d2);
epsilon_1 = out(1)
epsilon_2 = out(2)
[a1 , a2 ] = getInitialConditionsAsymmRelay(A,B,C,d1,d2,T,tau);
                            %X0 = 0.5;
X0 =a2;
stable = checkStability(A,B,C,T,tau,d1,d2) % Stability check


%% Simulink
set_param('fitz_relay', 'StopTime', 'tmax')
set_param('fitz_relay/Relay','OffOutputValue','d1','OnOutputValue','-d2','OffSwitchValue','epsilon_1', 'OnSwitchValue','epsilon_2' )
set_param('fitz_relay/State-Space','A','A','B','B','C','C','D','D','X0','X0')
simulate_fitz = sim('fitz_relay'); 

%% Recover actual results
actual_voltage = relay_output.data+alpha*current.data + beta1;
actual_current = current.data + beta2 - I_app;

%% Show Results
% Action potential
figure(1)
hold on
plot(t,v(:,1))
hold on

plot(relay_output.time,actual_voltage )
%plot(simout.time,relay_output.data(:,1))
xlabel('Time')
ylabel('Voltage')
grid on
% legend('FitzHugh-Nagumo','Relay feedback')


% limit cycle
% figure(2)
% plot(v(:,2),v(:,1))
% hold on
% v2 = linspace(min(v(:,1))-0.1, max(v(:,1))+0.1, 100);
% alpha_cubic = 0.1; I_app = 0.5;
% f = (-v2.^3 + (1+alpha_cubic).*v2.^2 - alpha_cubic.*v2)+I_app;
% plot(f,v2,'--')
% plot(current.data(:,1),(relay_output.data(:,1) + alpha*(current.data(:,1))))
% xlabel('Current')
% ylabel('Voltage')
% % axis([0.35 0.8 -0.4 1])


% limit cycle
figure(2)
plot(v(:,2),v(:,1))
hold on
v2 = linspace(min(v(:,1))-0.1, max(v(:,1))+0.1, 100);
alpha_cubic = 0.1; 
f = (-v2.^3 + (1+alpha_cubic).*v2.^2 - alpha_cubic.*v2)+I_app;

plot(f,v2,'--')
plot(actual_current,actual_voltage)

xlabel('Current')
ylabel('Voltage')
grid on
% axis([0.35 0.8 -0.4 1])


