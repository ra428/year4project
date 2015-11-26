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
alpha = -2;

%% Four points representing the "cubic" nullcline, voltage in x-axis 
% axis, f(v), current in the y axis. 
a = [-.2693 0.6883 -.0061 1.003; ...
    0.6262  0.6262   0.4976   0.4976];
% Plot this
figure(9)
hold on
plot(a(1,1:2),a(2,1:2),'m')
plot(a(1,2:2:end),a(2,2:2:end),'m')
plot(a(1,1:2:end),a(2,1:2:end),'m')
plot(a(1,3:4),a(2,3:4),'m')
grid on

% % %% Move these points up in the y-axis to take into account I_app
% % for i = 1:4
% %     a(:,i) = a(:,i) + [0;I_app];
% % end
% % 
% % plot(a(1,1:2),a(2,1:2),'m')
% % plot(a(1,2:2:end),a(2,2:2:end),'m')
% % plot(a(1,1:2:end),a(2,1:2:end),'m')
% % plot(a(1,3:4),a(2,3:4),'m')

%% Reflect these points about the y=x line, so just swap the x with y
% So now the x-axis is the current and the y-axis is the voltage
for i = 1:4
    b(1,i) = a(2,i); 
    b(2,i) = a(1,i);
end

plot(b(1,1:2),b(2,1:2),'r')
plot(b(1,2:2:end),b(2,2:2:end),'r')
plot(b(1,1:2:end),b(2,1:2:end),'r')
plot(b(1,3:4),b(2,3:4),'r')

%% Multiply by -1 to reflect about the x-axis
% b = -1* b;
for i = 1:4
        b(1,i) = b(1,i);
        b(2,i) = -b(2,i);
end

plot(b(1,1:2),b(2,1:2),'g')
plot(b(1,2:2:end),b(2,2:2:end),'g')
plot(b(1,1:2:end),b(2,1:2:end),'g')
plot(b(1,3:4),b(2,3:4),'g')

%% Reflect these points about the y-axis
for i = 1:4
        a(1,i) = -b(1,i);
        a(2,i) = b(2,i);
end

% Plot this

plot(a(1,1:2),a(2,1:2),'b')
plot(a(1,2:2:end),a(2,2:2:end),'b')
plot(a(1,1:2:end),a(2,1:2:end),'b')
plot(a(1,3:4),a(2,3:4),'b')

%% Now need to move all the points to centralise the relay
beta2 = mean([a(1,1) a(1,3)])
beta11 = mean([a(2,1) a(2,2)])
beta12 = mean([a(2,3) a(2,4)])
beta1 = mean([beta11, beta12])

for i = 1:4
    a(:,i) = a(:,i) - [beta2;beta1];
end
plot(a(1,1:2),a(2,1:2),'black')
plot(a(1,2:2:end),a(2,2:2:end),'black')
plot(a(1,1:2:end),a(2,1:2:end),'black')
plot(a(1,3:4),a(2,3:4),'black')

%% Deduce relay properties in the new basis
skewMatrix = [1 0; -alpha 1];
for i = 1:4
    a(:,i) = skewMatrix*a(:,i);
end
plot(a(1,1:2),a(2,1:2),'g')
plot(a(1,2:2:end),a(2,2:2:end),'g')
plot(a(1,1:2:end),a(2,1:2:end),'g')
plot(a(1,3:4),a(2,3:4),'g')

epsilon_1 = a(1,1);
epsilon_2 = a(1,3);
d1 = abs(mean([a(2,1) a(2,3)]));
d2 = abs(mean([a(2,2) a(2,4)]));


% % % %% Relay properties
% % % epsilon_1 = -.0643; 
% % % epsilon_2 = .0643;   
% % % d1 =0.4912;
% % % d2 =0.49215;
% % 
% % % Transformation variables
% % % beta1 = 0.3540;
% % % beta2 = 1.0619;
gamma = 0.5;
% alpha = -2;

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
actual_voltage = relay_output.data+alpha*current.data - beta1;
actual_current = current.data - beta2;                                           %- I_app;

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


