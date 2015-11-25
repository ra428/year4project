%% Test out FitzHugh-Nagumo model from Keener and Sneyd Chapter 5
clear all
close all
tmax = 5;

%% ODE solver
% Set up various variables
tspan = [0 tmax];      % Time interval
v0 = [0.9;0.5];        % Intial condition [voltage current]
                       %[t,v] = ode45(@fitzhugh_nagumo, tspan, v0);
[t,v] = ode15s(@fitzhugh_nagumo, tspan, v0);

%% Variables for simulink
% Relay properties
epsilon_1 = min (v(:,2))   % 0.4976;
epsilon_2 = max(v(:,2))    % 0.6262;
d1 = 0.75;d2 = 0.25;       % d1 = 0.75; d2 = 0.25

I_app = 0.5;
T = 0.519; tau = 0.1975;
gamma = 0.5; alpha = -2;
                         
A = gamma+alpha;            % A = zeros_of_theorem_5_1(epsilon_1, epsilon_2, d1, d2, T, tau);
B = 1; C = 1; D = 0;
                            % out = getAsymmetricRelayHysteresisForFitzNagumo(A,B,C,T,tau,d1,d2);
                            % epsilon_1 = out(1)
                            % epsilon_2 = out(2)

% Reflection                            
epsilon_1 = -(epsilon_1 - I_app);
epsilon_2 = -(epsilon_2 - I_app);

[a1 , a2 ] = getInitialConditionsAsymmRelay(A,B,C,d1,d2,T,tau);
X0 =a1;
stable = checkStability(A,B,C,T,tau,d1,d2) % Stability check


%% Simulink
set_param('fitz_relay', 'StopTime', 'tmax')
set_param('fitz_relay/Relay','OnOutputValue','d1','OffOutputValue','-d2',...
    'OnSwitchValue','epsilon_1', 'OffSwitchValue','epsilon_2' )
set_param('fitz_relay/State-Space','A','A','B','B','C','C','D','D','X0','X0')
simulate_fitz = sim('fitz_relay'); 

%% Transform back to coordinates
voltage = relay_output.data + alpha*current.data(:,1);
current = current.data + I_app;

%% Show Results
% Action potential
figure(1)
plot(t,v(:,1))
hold on
plot(relay_output.time,relay_output.data(:,1)- alpha*current.data(:,1))
%plot(simout.time,relay_output.data(:,1))
xlabel('Time')
ylabel('Voltage')
legend('FitzHugh-Nagumo','Relay feedback')
hold off

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
alpha_cubic = 0.1; I_app = 0.5;
f = (-v2.^3 + (1+alpha_cubic).*v2.^2 - alpha_cubic.*v2)+I_app;
plot(f,v2,'--')
plot(current.data(:,1)+I_app,(relay_output.data(:,1) - alpha*(current.data(:,1))))
xlabel('Current')
ylabel('Voltage')
grid on
% axis([0.35 0.8 -0.4 1])



% % % d1 = 0.99;d2 = 0.19;        % d1 = 0.9864; d2 =0.2829; 
% % % 
% % %                             %T = 0.9104; tau = 0.4496;
% % % 
% % % I_app = 0.5;
% % % T = 0.519; tau = 0.1975;
% % % gamma = -0.5;
% % % alpha = 2;
% % % %                             A = zeros_of_theorem_5_1(epsilon_1, epsilon_2, d1, d2, T, tau);
% % % A = gamma+alpha;