clear all


bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
fast_nullcline_relay = @(xs,xf,u,gamma,beta2,alpha,delta,ef)...
    ((-xf + sign(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta2*xf+ alpha))/ef);

linear_plant = @(xs,xf,ts) (xf-xs*ts);

%% Variables
m = 0.65;
alpha = 0.25;
%beta = .5;
beta = .5;
beta2 = ((beta-1)/m);
gamma = 1;
delta = 0.3;
u = 0.5 ;
tf = 0.0075;
ts = 1/2;
t_max = 10000;
alpha_max = 1.75;
alpha_period = t_max;
alpha_width = 1; % %of period
alpha_delay1 = 4000;
alpha_delay2 = 7000;
slow_plant_X0 = -1;
fast_plant_X0 = -0.5;

%% Simulink
load_system('rest_spike_bistability')
%set_param('rest_spike_bistability_original', 'StopTime', 't_max')
set_param('rest_spike_bistability/Constant1','Value','u')
set_param('rest_spike_bistability/Constant2','Value','alpha')
set_param('rest_spike_bistability/Bump','Expr','tanh(u+delta) -  tanh(u-delta) - 2*tanh(delta)')
set_param('rest_spike_bistability/State-Space','A','-1/tf','B','1/tf','C','1','D','0','X0','fast_plant_X0')
set_param('rest_spike_bistability/State-Space1','A','-1/ts','B','1/ts','C','1','D','0','X0','slow_plant_X0')
set_param('rest_spike_bistability/Gain','Gain','1+beta2')
set_param('rest_spike_bistability/Gain1','Gain','gamma/2')
set_param('rest_spike_bistability/Pulse Generator','Amplitude','alpha_max','Period','alpha_period','PulseWidth','alpha_width','PhaseDelay','alpha_delay1')
set_param('rest_spike_bistability/Pulse Generator1','Amplitude','-1*alpha_max','Period','alpha_period','PulseWidth','alpha_width','PhaseDelay','alpha_delay2')
SimOut = sim('rest_spike_bistability','StopTime','10000');

%% Plot
cc = hsv(15);
% Plot winged cusp
% h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
% set(h1,'Color','b');
hold on

h3 = ezplot(@(x,y)fast_nullcline_relay(x,y,u,gamma,beta2,alpha,delta,tf),[-4,4]);
%set(h3,'Color',cc(ceil(15*rand(1)),:));
set(h3,'Color','g');

% Plot linear plant
h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);

[x,y] = meshgrid(-2:.1:1,-1.5:.1:1.5);
grid on

% Plot trajectories
 xf_dot = fast_nullcline_relay(x,y,u,gamma,beta2,alpha,delta,tf);
 xs_dot = linear_plant(x,y,ts);
 quiver(x,y,xs_dot,xf_dot)

% Plot history
plot(SimOut.get('xs').Data, SimOut.get('xf').Data, 'r')

title('Phase portrait')
xlabel('x_s')
ylabel('x_f')




figure(2)
plot(SimOut.get('xf').Time, SimOut.get('xf').Data,'b')






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
