% Test out FitzHugh-Nagumo model from Keener and Sneyd Chapter 5
clear all
close all

global p
global b

tmax = 40;
% Set up various variables
tspan = [0 tmax];      % Time interval
v0 = [0;0;0];     % Intial condition

p = 50;
b = 1;
z = 1;

while (b*z >= 1-8/p)
    b = b - 0.1;
    z = polynom(b,p);
    disp ('Still reducing b')
    
end

% ODE solver
[t,v] = ode45(@goodwin, tspan, v0);

%% Show Results
% Action potential
figure(1)
plot(t,v(:,1))
hold on
plot(t,v(:,2))
plot(t,v(:,3))
xlabel('Time')
ylabel('Concentration')
legend('x_1','x_2','x_3')
