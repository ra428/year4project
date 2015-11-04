% Test out Fitzhugh-Nagumo model from Keener and Sneyd Chapter 5
clear all 
close all

% Set up various variables
tspan = [0 3];         % Time interval
v0 = [0.5; 0.5] ;              % Initial condition

% ODE solver
[t,v] = ode45(@fitzhugh_nagumo, tspan, v0);

%% Show results
% Action potential
figure(1)
plot(t,v(:,1))
xlabel('Time')
ylabel('Voltage')

% Limit cycle
figure(2)
plot(v(:,1), v(:,2))
hold on
v2 = linspace(min(v(:,1))-0.1,max(v(:,1))+0.1,100);
alpha = 0.1; I_app = 0.5;
f = (-v2.^3 + (1+alpha).*v2.^2 - alpha.*v2)+I_app;
plot(v2,f,'--')
xlabel('Voltage')
ylabel('Current')




