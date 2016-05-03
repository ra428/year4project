% parameters
alpha = 0.5;
beta = 0.37;
gamma = 0;
delta = 0.5;
u = 0.8;
alpha_const = 0.0;
tf = 0.0075;
ts = 1;

functionToSolve = @(variables) evaluateDerivatives(variables,beta,gamma,u);

x0  = [-2,-2,0.5];
x = fsolve(functionToSolve,x0)




