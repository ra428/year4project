% Test out the hysteresis effect of positive feedback on the simplest relay

clear all
close all

% Variables for simulink
d = 1;      % amplitude of relay output
b = 1;    % hysteresis parameter
tmax = 500;  % simulation time

% Threshold data
t = linspace(0,tmax,500);
upper_thresh = b*d*ones(1,500);
lower_thresh = -upper_thresh;

% Assign the variables to simulink model
load_system('relay_feedback_with_positive_loop')
set_param('relay_feedback_with_positive_loop', 'StopTime', 'tmax');
set_param('relay_feedback_with_positive_loop/Relay','OffOutputValue','-d','OnOutputValue','d');
set_param('relay_feedback_with_positive_loop/Gain','Gain','b');
simulate_fitz = sim('relay_feedback_with_positive_loop'); 

% Plot results
figure(1)
plot(relay_output.Time, relay_output.Data,'b')
hold on
plot(input.Time,input.Data,'r')
%plot(slow_plant.Time, slow_plant.Data,'r')
plot(pulses.Time,pulses.Data,'m')
plot(fast_plant.Time, fast_plant.Data,'c')
plot(t,upper_thresh,'--g')
plot(t,lower_thresh,'--g')

legend('Relay output','Input','Switch','Fast plant')
xlabel('Time')