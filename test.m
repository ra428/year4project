% Matlab code implementation attempt of Astrom 1995

% Input which test case to see
example =input('Example 1,2,4 or 0:  ');

switch example
    case 0
        A = input('A:\n');
        B = input('B:\n');
        C = input('C:\n');
    case 1
        % Example 1
        A = [-1 1 0; 0 -1 1; 0 0 -1];
        B = [0 ; 0 ; 1 ];
        C = [1 0 0];
    case 2
        % Example 2
        A = [0 1 1; 0 -1 6; 0 0 -1];
        B = [1; 6; 6];
        C = [1 0 0 ];
    case 3
        disp('No state space matrices were given for Example 3')
        return
    case 4
        % Example 4
        A = [0 1; -1 0];
        B = [0;1];
        C = [11 0];
        
end

% Relay characteristics
epsilon = 0;
d = 1;

% Samples that are evaluated
h_max = 40;
N = h_max*100;
h = linspace(0,h_max,N);

% Evaluate equation2_3
for i = 1:N
    f(i) = eqtn2_3(h(i), A, B, C) - epsilon/d;
end



% Plot results
plot(h,f)
I(1) = xlabel('$h$');
I(2) = ylabel('$f(h) - \epsilon/d$');
I(3) = legend('$f(h)- \epsilon/d$');
grid on
set(I, 'Interpreter','Latex')







