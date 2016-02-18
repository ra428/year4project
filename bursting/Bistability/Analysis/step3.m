function y = step3(stability, h,A,B,C,d,e,a);
% y = step3(stability,h,A,B,C,d,epsilon);
% Compute y(t) for 0<=t<h
% and check that y(t)>-e
% This is step 3 according to Astrom's 1995 paper
% 'Oscillations in systems with relay feedback'
% stability (:,1) tell whether |?(W)| < 1
% stability (:,2) tell whether Cv > 0
% h = 0.5*time_period of symmetric limit cycle
% A,B,C = state space matrices
% d = magnitude of relay feedback
% e = hysteresis of relay feedback
% a = x(0)

fprintf('Step 3\n') % Let the user know where the program is
N = 100; % Data points of y(t)
fun = @(s) expm(A*s);
y = [];

% Compute y(t) if both conditions in stability are met
for i = 1:size(h,2)
    if and(stability(i,1),stability(i,2))
        t = linspace(0,h(i)-0.0001,N);
        for j = 1:size(t,2)
            y(i,j) = C*(expm(A*t(j))*a(:,i) - integral(fun,0,t(j),'ArrayValue',true)*B*d);
            %a = input('yo');
        end 
        if min(y(i,:)) > -e-.0001 % Fudge factor for computational error             fprintf('Theorem 2.4 met for h = %f\n',h(i))
            fprintf('Theorem 2.4 met \n')
            figure()
            plot(t,y(i,:))
            xlabel('Time (s)')
            ylabel('y(t)')
            grid on
        else
            fprintf('Theorem 2.4 not met \n')
%             figure()
%             plot(t,y(i,:))
%             xlabel('Time (s)')
%             ylabel('y(t)')
%             grid on
        end
        
    end
    
end


        

