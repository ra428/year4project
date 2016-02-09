% Relay model for bistability
clear all

%% Functions
bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
fast_nullcline_relay = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + sign(bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
fast_nullcline_relay_piecewise = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + sign(piece_wise_bump2(u + xs +0.5*gamma*xf) + beta*xf+ alpha))/ef);
linear_plant = @(xs,xf,ts) (xf-xs*ts);

%% Variables
m = 0.65;
alpha = 0.5;
% beta = .25;
% beta = 0.45;
beta = 0.27;
% beta_hat = 1 + beta;
% beta_relay = -(1-beta_hat)/m;
% %beta = beta_relay;
% %beta2 = ((beta-1)/m);
gamma = 1;
delta = 0.5;
u = 0.8 ;
tf = 0.0075;
ts = 0.25;
tmax = 3500;
alpha_max = 1.75;
alpha_period = tmax;
alpha_width = 1; % %of period
alpha_delay1 = 200;
alpha_delay2 = 300;
slow_plant_X0 = -1.05;
fast_plant_X0 = -1.05;
sine_alpha_max = 0.65;

%% Simulink
load_system('piece_wise_bump_model')
set_param('piece_wise_bump_model/Constant1','Value','u')
set_param('piece_wise_bump_model/Constant2','Value','alpha')
% set_param('piece_wise_bump_model/Bump','Expr','tanh(u+delta) -  tanh(u-delta) - 2*tanh(delta)')
set_param('piece_wise_bump_model/State-Space','A','-1/tf','B','1/tf','C','1','D','0','X0','fast_plant_X0')
set_param('piece_wise_bump_model/State-Space1','A','-1/ts','B','1/ts','C','1','D','0','X0','slow_plant_X0')
set_param('piece_wise_bump_model/Gain','Gain','beta')
set_param('piece_wise_bump_model/Gain1','Gain','gamma/2')
set_param('piece_wise_bump_model/Pulse Generator','Amplitude','alpha_max','Period','alpha_period','PulseWidth','alpha_width','PhaseDelay','alpha_delay1')
set_param('piece_wise_bump_model/Pulse Generator1','Amplitude','-1*alpha_max','Period','alpha_period','PulseWidth','alpha_width','PhaseDelay','alpha_delay2')
set_param('piece_wise_bump_model/Sine Wave','Amplitude','sine_alpha_max')

SimOut = sim('piece_wise_bump_model','StopTime','tmax');


%% Plot
% cc = hsv(15);
% % Plot winged cusp
% % h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
% % set(h1,'Color','b');
% hold on
% 
% h3 = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
% set(h3,'Color',cc(ceil(15*rand(1)),:));
% % set(h3,'Color','g');
% 
% % Plot linear plant
% h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
% 
% [x,y] = meshgrid(-2:.1:1,-1.5:.1:1.5);
% grid on
% 
% % Plot trajectories
% %  xf_dot = fast_nullcline_relay_piecewise(x,y,u,gamma,beta,alpha,delta,tf);
% %  xs_dot = linear_plant(x,y,ts);
% %  quiver(x,y,xs_dot,xf_dot)
% 
% % Plot history
% % plot(SimOut.get('xs').Data, SimOut.get('xf').Data, 'r')
% DELAY = 0.001;
% sparse_index = 32;
% % for i = 1:numel(SimOut.get('xs').Data)/sparse_index
% %     %clf;
% %     %plot(SimOut.get('xs').Data,SimOut.get('xf').Data);
% %     %hold on;
% %     plot(SimOut.get('xs').Data(sparse_index*i),SimOut.get('xf').Data(sparse_index*i),'o');
% %     pause(DELAY);
% % end
% 
% title('Phase portrait')
% xlabel('x_s')
% ylabel('x_f')
% 
figure(2)
plot(SimOut.get('xf').Time, SimOut.get('xf').Data,'b')

%% Plot varying nullcline with phase portait
% Plot varying nullcline and history
disp('Starting plotting')
figure(4)
speed = 800;
delay = 0.001;
for i = 1:speed:numel(SimOut.get('alpha_vary').Time)
    figure(4)
    h1 = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta,SimOut.get('alpha_vary').Data(i),delta,tf),[-4,4]);
    set(h1,'Color','b');
    hold on
    h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
    plot(SimOut.get('xs').Data(i),SimOut.get('xf').Data(i),'or')
    text = sprintf('\\alpha = %f', SimOut.get('alpha_vary').Data(i));
    legend(text)
    hold off
    pause(delay)
end



