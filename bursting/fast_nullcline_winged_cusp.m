bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
linear_plant = @(xs,xf) (xf-.35*xs);
                    
% alpha = 0.4;
alpha =.5;
u = 1.25 ; beta = 0.5;
gamma = 1;
ef = 0.0075;
delta = .5;

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

% for iteration = 1:5
%     ef = .0075/(5*iteration);

    h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,ef),[-4,4])
    set(h1,'Color',cc(10,:));
    grid on
    hold on
    
% end
% legend('\delta = 0.0','\delta = 0.2','\delta = 0.4','\delta = 0.6','\delta = 0.8')

h2 = ezplot(@(x,y)linear_plant(x,y),[-4,4])
title('Phase portrait')
[x,y] = meshgrid(-4:0.1:4,-4:0.1:4);

xf_dot = fast_nullcline(x,y,u,gamma,beta,alpha,delta,ef);
xs_dot = linear_plant(x,y);
%quiver(x,y,xs_dot,xf_dot)
% myfunc = @(x,y,k) (x.^k -y.^k -1);
% ezplot(@(x,y)myfunc(x,y,2))