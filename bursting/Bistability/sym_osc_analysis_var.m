% Analysis of a given system for symmetric limit cycles
% according to Section 3.1 of Astrom's 1995 paper
% 'Oscillations in systems with Relay feedback'

function [h] = sym_osc_analysis_var(A,B,C,D,epsilon,d)

% Samples that are evaluated
h_min = 0; % min h that is evaluated
h_max = 40; % max h that is evaluated
N = (h_max-h_min)*50; % number of evaluations
h_data = linspace(h_min,h_max,N);
% any dips that are within a step of (h_max-h_min)/N are missed

f = @(x)eqtn2_3(x,A,B,C) - epsilon/d - D;

%% Step 1
% Evaluate where f(h) = epsilon/d
[h,f_data] = step1(f,h_data);

% %% Step 2
% % Evaluate x(0),\dot(x)(0),W and check stability
% [a,v,stability] = step2(h,A,B,C,d);
% 
% %% Step 3
% % Evaluate y(t) for 0<t<h and check condition
% y = step3(stability, h,A,B,C,d,epsilon,a);

end
