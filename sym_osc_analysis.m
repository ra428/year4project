% Analysis of a given system for symmetric limit cycles
% according to Section 3.1 of Astrom's 1995 paper
% 'Oscillations in systems with Relay feedback'

% Clear workspace
clear

%% Set up some parameters
% Relay characteristics
epsilon = 0;
d = 1;

% Samples that are evaluated
h_min = 0; % min h that is evaluated
h_max = 40; % max h that is evaluated
N = (h_max-h_min)*50; % number of evaluations
h_data = linspace(h_min,h_max,N);% any dips that are within...
%a step of (h_max-h_min)/N are missed

% Initialise state space
example =input('Example 1 , 2 , 4 or \n 0 for your own matrices:');
switch example
    case 0
        % Type in your own state space matrices
        A = input('A=\n');
        B = input('B=\n');
        C = input('C=\n');
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

% Set up function handle
f = @(x)eqtn2_3(x,A,B,C) - epsilon/d;

%% Step 1
% Evaluate where f(h) = epsilon/d
[h,f_data] = step1(f,h_data);

%% Step 2
% Evaluate x(0),\dot(x)(0),W and check stability
[a,v,stability] = step2(h,A,B,C,d);

%% Step 3
% Evaluate y(t) for 0<t<h and check condition
y = step3(stability, h,A,B,C,d,epsilon,a);

