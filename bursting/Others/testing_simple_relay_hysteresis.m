% Test out the hysteresis effect of positive feedback on the simplest relay

clear all
close all

% Variables for simulink
A = 5;      % amplitude of sine input
d = 2;      % amplitude of relay output
b = 1.5;    % hysteresis parameter
tmax = 10;  % simulation time

% Threshold data
t = linspace(0,tmax,100);
upper_thresh = b*d*ones(1,100);
lower_thresh = -upper_thresh;

% Assign the variables to simulink model
set_param('simple_relay_hysteresis', 'StopTime', 'tmax');
set_param('simple_relay_hysteresis/Relay','OffOutputValue','-d','OnOutputValue','d');
set_param('simple_relay_hysteresis/Gain','Gain','b');
set_param('simple_relay_hysteresis/sinewave','Amplitude','A');
simulate_fitz = sim('simple_relay_hysteresis'); 

% Plot results
figure(1)
plot(relay_output.Time, relay_output.Data,'b')
hold on
plot(input.Time, input.Data,'r')
plot(t,upper_thresh,'--g')
plot(t,lower_thresh,'--g')
legend('Relay output','Input signal','Threshold')
xlabel('Time')