clear all

%% Nullcline functions
bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
fast_nullcline_relay = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + sign(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
linear_plant = @(xs,xf,ts) (xf-xs*ts);

%% Variables
% alpha = 0.25;
% beta = 0.5;
% gamma = 1;
% delta = 0.5;
% u = 0.7 ;
% tf = 0.0075;
% ts = 1;
% tus = 500;
% % tmax = 1400;
tmax = 6000;
% alpha_const = 0.1;
% slow_plant_X0 = -1;
% fast_plant_X0 = -1;
% ultra_slow_plant_X0 = -.2;

alpha_max =.5;
alpha_period = tmax;
alpha_width = .1; % %of period
alpha_delay1 = 300;
alpha_delay2 = 200;

kb = -0.5;
alpha = 0.45;
beta = 0.37;
gamma = 0;
delta = 0.5;
u = 0.8;
alpha_const = 0.0;
tf = 0.0075;
ts = 1;
% ts=10;
tus = -800;
ultra_slow_plant_X0 = 0.45;
% ultra_slow_plant_X0 = 0.61;
slow_plant_X0 = -1.0;
fast_plant_X0 = -1.0;

%% Simulink
load_system('original')
set_param('original/Constant1','Value','u')
set_param('original/Constant2','Value','alpha_const')
set_param('original/State-Space','A','-1/tf','B','1/tf','C','1','D','0','X0','fast_plant_X0')
set_param('original/State-Space1','A','-1/ts','B','1/ts','C','1','D','0','X0','slow_plant_X0')
set_param('original/State-Space2','A','-1/tus','B','1/tus','C','1','D','0','X0','ultra_slow_plant_X0')
set_param('original/Gain','Gain','beta+1')
set_param('original/Gain1','Gain','gamma/2')
SimOut = sim('original','StopTime','tmax');

%% Plot nullclines
cc = hsv(15);
% Plot winged cusp
h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf),[-3,3]);
set(h1,'Color','b');
hold on

% Plot linear plant
h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-3,3]);

[x,y] = meshgrid(-2:.1:1,-1.5:.1:1.5);
grid on

% Plot trajectories
%  xf_dot = fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf);
%  xs_dot = linear_plant(x,y,ts);
%  quiver(x,y,xs_dot,xf_dot)

% Plot history
plot(SimOut.get('xs').Data, SimOut.get('xf').Data, 'r')

title('Phase portrait')
xlabel('x_s')
ylabel('x_f')
hold off

%% Plot time data
  figure(2)
  plot(SimOut.get('xf').Time, SimOut.get('xf').Data,'b')
  hold on
  plot(SimOut.get('ultra_slow').Time, SimOut.get('ultra_slow').Data,'r')
  legend('x_f','x_{us}')
  xlabel('Time')

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
% % Plot varying nullcline and history
% disp('Starting plotting')
% figure(4)
% speed = 200;
% delay = 0.0001;
% for i = 1:speed:numel(SimOut.get('alpha_vary').Time)
%     figure(4)
%     h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,SimOut.get('alpha_vary').Data(i),delta,tf),[-4,4]);
%     set(h1,'Color','b');
%     hold on
%     h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
%     plot(SimOut.get('xs').Data(i),SimOut.get('xf').Data(i),'or')
%     hold off
%     pause(delay)
% end



































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
