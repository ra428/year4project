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
kb = -0.5;
% alpha = 0.5;
% beta = 0.27;
% gamma = 1;
% % gamma = 0;
% delta = 0.5;
% % u = 0.8;
% u = 0.5;
% % u =0;
% alpha_const = 0.1;

alpha = 0.5;
beta = 0.37;
gamma = 0;
delta = 0.5;
u = 0.8;
alpha_const = 0.0;

tf = 0.0075;
ts = 1;
% ts=10;
tus = 800;
% tus = 50;
tmax = 2000;
ultra_slow_plant_X0 = 0.45;
% ultra_slow_plant_X0 = 0.61;
slow_plant_X0 = -1.0;
fast_plant_X0 = -1.0;


%% Simulink
load_system('fastSlowModel')
set_param('fastSlowModel/Constant1','Value','u')
set_param('fastSlowModel/Constant2','Value','alpha_const')
set_param('fastSlowModel/State-Space1','A','-1/ts','B','1/ts','C','1','D','0.5*1*gamma','X0','slow_plant_X0')
set_param('fastSlowModel/State-Space3','A','-1/ts','B','kb/ts','C','1','D','0.5*kb*gamma','X0','0')
set_param('fastSlowModel/State-Space2','A','-1/tus','B','-1/tus','C','1','D','0','X0','ultra_slow_plant_X0')
set_param('fastSlowModel/Relay1','OnSwitchValue','beta', 'OffSwitchValue','-beta','OnOutputValue','1','OffOutputValue','-1')
set_param('fastSlowModel/Relay2','OnSwitchValue','beta-kb*u-alpha', 'OffSwitchValue','-beta-kb*u-alpha','OnOutputValue','1','OffOutputValue','-1')

SimOut = sim('fastSlowModel','StopTime','tmax');


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

% subplot(1,2,1)
% plot(SimOut.get('xf').Time, SimOut.get('xf').Data,'b')
% hold on
% plot(SimOut.get('ultra_slow').Time, SimOut.get('ultra_slow').Data,'r')
% % plot(SimOut.get('bump_input').Time, SimOut.get('bump_input').Data,'g')
% xlabel('Time')
% legend('xf','alpha','bump_input')
% text = sprintf('\\tau_{US}=%d',tus);
% title(text)
% subplot(1,2,2)

% moving average;
w = 50;
k = ones(1,w)/w;
filtered_xf = conv(SimOut.get('xf').Data,k,'same');
figure(1)
plot(SimOut.get('xf').Time, SimOut.get('xf').Data,'b')
hold on
plot(SimOut.get('xs').Time, SimOut.get('xs').Data,'g')
plot(SimOut.get('ultra_slow').Time, SimOut.get('ultra_slow').Data,'r')
plot(SimOut.get('xf').Time, filtered_xf,'c')
% plot(SimOut.get('bump_input').Time, SimOut.get('bump_input').Data,'g')
xlabel('Time')
axis([0 SimOut.get('xs').Time(end), -1.25, 1.25])
legend('x_f','x_s','alpha','x_f avg')

figure(2)
subplot(1,2,1)
plot(SimOut.get('bump_output').Data,SimOut.get('xf').Data,'b')
xlabel('bump output')
ylabel('x_f')
subplot(1,2,2)
plot(SimOut.get('ultra_slow').Data,filtered_xf,'r')
xlabel('x_{us}')
ylabel('Filtered x_f')

% figure()
% plot(SimOut.get('bump_output').Data,SimOut.get('xf').Data,'xb')
% xlabel('x_s')
% ylabel('x_f')


%% Plot varying nullcline with phase portait
% disp('Starting plotting')
% figure(3)
% speed = 1000;
% delay = 0.000001;
% for i = 1:speed:numel(SimOut.get('ultra_slow').Time)
%     figure(3)
%     subplot(1,2,1);
%     h1 = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta,SimOut.get('ultra_slow').Data(i),delta,tf),[-4,4]);
%     set(h1,'Color','b');
%     hold on
%     h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
%     plot(SimOut.get('xs').Data(i),SimOut.get('xf').Data(i),'or')
%     text = sprintf('\\alpha = %f', SimOut.get('ultra_slow').Data(i));
%     legend(text)
%     title('Phase Portrait')
%     xlabel('xs')
%     ylabel('xf')
%     hold off
%     subplot(1,2,2);
%     h3 = ezplot(@(x) piece_wise_bump2(x), [-4 4]);
%     set(h3,'Color','b');
%     hold on
%     plot(SimOut.get('bump_input').Data(i),piece_wise_bump2(SimOut.get('bump_input').Data(i)),'o')
%     xlabel('Input')
%     ylabel('Output')
%     title('Behaviour of bump')
%     hold off
%     pause(delay)
% end

% Plothysteresis
disp('Plotting hysteresis')
speed = 100;
delay = 0.000001;
for i = 1:speed:numel(SimOut.get('ultra_slow').Time)
    figure(9)
    subplot(1,2,1);
    hold on
    plot(SimOut.get('bump_output').Data(i),SimOut.get('xf').Data(i),'bx')
    text = sprintf('\\alpha = %f', SimOut.get('ultra_slow').Data(i));
    legend(text)
    title('Fast-slow Hysteresis')
    xlabel('Bump Output')
    ylabel('xf')
    subplot(1,2,2);
    hold on
    plot(SimOut.get('ultra_slow').Data(i),filtered_xf(i),'rx')
    xlabel('x_{us}')
    ylabel('Filtered x_f')
    title('Ultra-slow Hysteresis')
    pause(delay)
end


%% Plot varying nullcline with phase portait
% Plot varying nullcline and history
% disp('Starting plotting')
% figure(4)
% speed = 300;
% delay = 0.00001;
% for i = 1:speed:numel(SimOut.get('ultra_slow').Time)
%     figure(4)
%     h1 = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta,SimOut.get('ultra_slow').Data(i),delta,tf),[-4,4]);
%     set(h1,'Color','b');
%     hold on
%     h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
%     plot(SimOut.get('xs').Data(i),SimOut.get('xf').Data(i),'or')
%     hold off
%     pause(delay)
% end
% 
% figure(3)
% subplot(1,2,1);
%     h1 = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta,SimOut.get('ultra_slow').Data(i),delta,tf),[-4,4]);
%     set(h1,'Color','b');
%     hold on
%     h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
%     plot(SimOut.get('xs').Data,SimOut.get('xf').Data,'r')
% %     text = sprintf('\\alpha = %f', SimOut.get('alpha_vary').Data(i));
% %     legend(text)
%     title('Phase Portrait')
%     xlabel('xs')
%     ylabel('xf')
%     
%     
% subplot(1,2,2);
% h3 = ezplot(@(x) piece_wise_bump2(x), [-4 4]);
%     set(h3,'Color','b');
%     hold on
%     plot(SimOut.get('bump_input').Data,piece_wise_bump2(SimOut.get('bump_input').Data),'r')
%     xlabel('Input')
%     ylabel('Output')
%     title('Behaviour of bump')

