bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + tanh( bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
                    
alpha = 0.5; u = 0.5 ; beta = 0.5;
gamma = 1;
ef = 0.0075;
delta = 0.01;

ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,ef),[-10,10])

% myfunc = @(x,y,k) (x.^k -y.^k -1);
% ezplot(@(x,y)myfunc(x,y,2))