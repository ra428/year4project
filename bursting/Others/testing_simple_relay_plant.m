% Test out the hysteresis effect of positive feedback on the simplest relay

clear all
close all

% Variables for simulink
d = 1;      % amplitude of relay output
b = 1;    % hysteresis parameter
tmax = 60;  % simulation time

% Threshold data
t = linspace(0,tmax,100);
upper_thresh = b*d*ones(1,100);
lower_thresh = -upper_thresh;

% Assign the variables to simulink model
set_param('simple_relay_plant', 'StopTime', 'tmax');
set_param('simple_relay_plant/Relay','OffOutputValue','-d','OnOutputValue','d');
set_param('simple_relay_plant/Gain','Gain','b');
simulate_fitz = sim('simple_relay_plant'); 

% Plot results
figure(1)
plot(relay_output.Time, relay_output.Data,'b')
hold on
plot(input.Time, input.Data,'r')
plot(pulses.Time,pulses.Data,'mz')
plot(t,upper_thresh,'--g')
plot(t,lower_thresh,'--g')

legend('Relay output','Plant','Switch','Threshold')
xlabel('Time')