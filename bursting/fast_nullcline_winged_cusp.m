clear


bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
linear_plant = @(xs,xf,ts) (xf-ts*xs);
                    
% alpha = .2;
alpha = 0.25;
beta = 0.5;
gamma = 1;
delta = 0.5;
u = 0.5 ;
tf = 0.0075;
ts = 1;

% % alpha = 0.7;
% % beta = 0.5-1;
% % gamma = 0.3/2;
% % delta = 1;
% % u = 0.7;
% tau_f = 0.0075;
% tau_s = 1;
% xf_0 = -1;
% xs_0 = -1;

cc = hsv(15);

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


% Plot winged cusp
h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
set(h1,'Color',cc(floor(15*rand(1)),:));
hold on

% Plot linear plant
h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);

title('Phase portrait')
[x,y] = meshgrid(-4:1:4,-4:1:4);
grid on

% Plot trajectories
xf_dot = fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf);
xs_dot = linear_plant(x,y,ts);
quiver(x,y,xs_dot,xf_dot)
