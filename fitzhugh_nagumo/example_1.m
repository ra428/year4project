clear all
close all
tmax = 6;

%% Variables for simulink
% A = [-1 1 0; 0 -1 1; 0 0 -1];
A = [0 1 1; 0 -1 6; 0 0 -1];
% B = [0 ; 0 ; 1];
B = [1; 6; 6];
C = [1 0 0];
[a1,a2] = getInitialConditionsAsymmRelay(A,B,C,1,-1,3.89,1.9464)
%X0 = [0; .2906;.7259];
X0 = a1;
epsilon_1 = -1;
epsilon_2 = 1;


%% Simulink
set_param('example1', 'StopTime', 'tmax')
set_param('example1/Relay','OffSwitchValue','epsilon_1', 'OnSwitchValue','epsilon_2' )
set_param('example1/State-Space','A','A','B','B','C','C','X0','X0')
simulate_fitz = sim('example1'); 

%% Show results
figure(1)
plot(relay.time, relay.data, 'r')
hold on
plot(plant.time, plant.data, 'b')
xlabel('Time')
legend('Relay', 'Plant')
