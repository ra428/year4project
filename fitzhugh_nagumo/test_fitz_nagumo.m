% Test out FitzHugh-Nagumo model from Keener and Sneyd Chapter 5
clear all
close all
tmax = 20;
% Set up various variables
tspan = [0 tmax];      % Time interval
v0 = [0.5;0.5];     % Intial condition

% ODE solver
%global f_relay
[t,v] = ode45(@fitzhugh_nagumo, tspan, v0);
%[t,v] = ode45(@fn_relay, tspan, v0);


%% Show Results
% Action potential
figure(1)
plot(t,v(:,1))
hold on
%plot(linspace(0,tmax,size(f_relay,2)),f_relay,'ro')
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
plot(f,v2,'--')
xlabel('Current')
ylabel('Voltage')

