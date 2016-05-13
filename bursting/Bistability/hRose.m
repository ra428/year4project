%% Simulink model of Hindmarsh-Rose
clear all
close all

%% Variables
cubicNullcline = @(x,y) y+3*x.^2-x.^3;
quadraticNullcline = @(x,y) 1-5*x.^2-y;
% tus = 50;
epsilon = 0.01;
tmax = 2000;
ultra_slow_plant_X0 = 2000;
% ultra_slow_plant_X0 = 0.61;
slow_plant_X0 = -10;
fast_plant_X0 = 0;


%% Simulink
load_system('hRoseModel')
set_param('hRoseModel/Constant','Value','1.6')
set_param('hRoseModel/State-Space1','A','0','B','1','C','1/epsilon','D','0','X0','fast_plant_X0')
set_param('hRoseModel/State-Space','A','-.001','B','4','C','0.001','D','0','X0','ultra_slow_plant_X0')
set_param('hRoseModel/State-Space2','A','-1','B','1','C','1','D','0','X0','slow_plant_X0')
% set_param('hRoseModel/Relay1','OnSwitchValue','beta', 'OffSwitchValue','-beta','OnOutputValue','1','OffOutputValue','-1')
% set_param('fastSlowModel/Relay2','OnSwitchValue','beta-kb*u-alpha', 'OffSwitchValue','-beta-kb*u-alpha','OnOutputValue','1','OffOutputValue','-1')

SimOut = sim('hRoseModel','StopTime','tmax');

%% Plot
% Plot the voltage output
figure(1)
plot(SimOut.get('xf').Time,SimOut.get('xf').Data,'b')
hold on
plot(SimOut.get('xus').Time,SimOut.get('xus').Data,'r')
plot(SimOut.get('xs').Time,SimOut.get('xs').Data,'g')
xlabel('Time')
l = legend('$x_f$','$x_{us}$','$x_s$')
set(l,'Interpreter','latex','FontSize',15)

% Plot the phase portrait
figure(2)
plot(SimOut.get('xs').Data,SimOut.get('xf').Data,'r')
hold on
h1 = ezplot(@(x,y) cubicNullcline(y,x),[-10,5]);
set(h1,'LineColor','b')
h2 = ezplot(@(x,y) quadraticNullcline(y,x),[-40,40]);
set(h2,'LineColor','g')
% h3 = ezplot(@ (x,y) -0.1*x+0.5-y ,[-40,40]);
% set(h3,'LineColor','m')
% [x,y] = meshgrid(-10:.5:2,-2:.5:4);
% % Plot trajectories
%  xf_dot = cubicNullcline(y,x);
%  xs_dot = quadraticNullcline(y,x);
%  quiver(x,y,xs_dot,xf_dot)
axis([-10,2,-2,4])
xlabel('xs')
ylabel('xf')
title('Phase portrait')
% % speed = 10;
% % delay = 0.1;
% % for i = 1:speed:numel(SimOut.get('xf').Data)
% %     figure(2)
% %     plot(SimOut.get('xs').Data(i),SimOut.get('xf').Data(i),'o')
% %     pause(delay);
% % end

% % % Plot the bump input and output
% % figure(3)
% % subplot(1,2,1)
% % h2 = ezplot(@(x,y) quadraticNullcline(x,y),[-40,40]);
% % set(h2,'LineColor','r')
% % axis([-2,3,-40,1])
% % camroll(90);
% % subplot(1,2,2)
% % plot(SimOut.get('xf').Time,SimOut.get('xf').Data,'b')


