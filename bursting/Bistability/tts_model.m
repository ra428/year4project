clear all

%% Nullcline functions
bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
fast_nullcline_relay = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + sign(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
linear_plant = @(xs,xf,ts) (xf-xs*ts);

%% Variables
% % m = 0.65;
% % alpha = 0.25;
% % beta = .5;
% % gamma = 1;
% % delta = 0.5;
% % u = 0.5 ;
% % tf = 0.0075;
% % ts = 1;
% % t_max = 10000;
% % alpha_max = 1;
% % alpha_period = t_max;
% % alpha_width = 1; % %of period
% % alpha_delay1 = 4000;
% % alpha_delay2 = 7000;
% % slow_plant_X0 = -2;
% % fast_plant_X0 = -1;

% m = 0.65;
alpha = 0.5;
beta = 0.45;
gamma = 1;
delta = 0.5;
u = 0.8 ;
tf = 0.0075;
ts = 1;
tus = 1000;
tmax = 3500;
alpha_constant = 0.5;
% alpha_period = tmax;
% alpha_width = 1; % %of period
% alpha_delay1 = 200;
% alpha_delay2 = 300;
ultra_slow_plant_X0 = 0;
slow_plant_X0 = -1.05;
fast_plant_X0 = -1.05;

%% Simulink
disp('Starting Simulation')
load_system('tts2')
%set_param('rest_spike_bistability_original', 'StopTime', 't_max')
set_param('tts2/Constant1','Value','u')
set_param('tts2/Constant2','Value','alpha_constant')
set_param('tts2/Bump','Expr','tanh(u+delta) -  tanh(u-delta) - 2*tanh(delta)')
set_param('tts2/State-Space','A','-1/tf','B','1/tf','C','1','D','0','X0','fast_plant_X0')
set_param('tts2/State-Space1','A','-1/ts','B','1/ts','C','1','D','0','X0','slow_plant_X0')
set_param('tts2/State-Space2','A','-1/tus','B','-1/tus','C','1','D','0','X0','ultra_slow_plant_X0')
set_param('tts2/Gain','Gain','1+beta')
set_param('tts2/Gain1','Gain','gamma/2')

% set_param('tts2/Pulse Generator','Amplitude','alpha_max','Period','alpha_period','PulseWidth','alpha_width','PhaseDelay','alpha_delay1')
% set_param('tts2/Pulse Generator1','Amplitude','-1*alpha_max','Period','alpha_period','PulseWidth','alpha_width','PhaseDelay','alpha_delay2')
SimOut = sim('tts2','StopTime','2500');

%% Plot nullclines
cc = hsv(15);
% % Plot winged cusp
%  h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
%  set(h1,'Color','b');
% hold on
%
% % Plot linear plant
% h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
%
% [x,y] = meshgrid(-2:.1:1,-1.5:.1:1.5);
% grid on
%
% % Plot trajectories
% %  xf_dot = fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf);
% %  xs_dot = linear_plant(x,y,ts);
% %  quiver(x,y,xs_dot,xf_dot)
%
% % Plot history
% %plot(SimOut.get('xs').Data, SimOut.get('xf').Data, 'r')
%
% title('Phase portrait')
% xlabel('x_s')
% ylabel('x_f')

% Plot time data
  figure(1)
  plot(SimOut.get('xf').Time, SimOut.get('xf').Data,'b')
  
  figure(3)
  plot(SimOut.get('ultra_slow').Time, SimOut.get('ultra_slow').Data,'r')

%% Plot variation of nullcline with alpha
% % Plot the Figure 4 equivalent to show bistability
% figure(3)
% for i = 1:6;
%     subplot(2,3,i)
%     alpha_var = i/6-0.3;
%     h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha_var,delta,tf),[-4,4]);
%     set(h1,'Color','b');
%     hold on
%     h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
% end

%% Plot varying nullcline with phase portait
% Plot varying nullcline and history
disp('Starting plotting')
figure(4)
speed = 100;
delay = 0.00001;
for i = 1:speed:numel(SimOut.get('ultra_slow').Time)
    figure(4)
    h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,SimOut.get('ultra_slow').Data(i),delta,tf),[-4,4]);
    set(h1,'Color','b');
    hold on
    h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
    plot(SimOut.get('xs').Data(i),SimOut.get('xf').Data(i),'or')
    hold off
    pause(delay)
end



































%% Testing

% for iteration = 1:5
%     alpha = iteration/5;
%
%     h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,ef),[-4,4])
%     set(h1,'Color',cc(iteration+10,:));
%     hold on
%
% end
% legend('\alpha = 0.2','\alpha = 0.4','\alpha = 0.6','\alpha = 0.8','\alpha = 1')

% for iteration = 1:5
%     beta = iteration/5;
%
%     h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,ef),[-4,4])
%     set(h1,'Color',cc(iteration+5,:));
%     hold on
%
% end
% legend('\beta = 0.2','\beta = 0.4','\beta = 0.6','\beta = 0.8','\beta = 1')

% for iteration = 1:5
%     gamma = (iteration-1)/5;
%
%     h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,ef),[-4,4])
%     set(h1,'Color',cc(iteration+8,:));
%     hold on
%
% end
% legend('\gamma = 0.','\gamma = 0.2','\gamma = 0.4','\gamma = 0.6','\gamma = 0.8')
