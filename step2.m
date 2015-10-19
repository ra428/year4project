function [a,v,stability] = step2(h,A,B,C,d);
% [a,v] = step2(h,A,B,C);
% Compute a, v according to Astrom's 1995 paper
% 'Oscillations in systems with relay feedback'
% a = initial state (x(0))
% v = initial velocity (\dot(x)(0))
% stability(:,1) tell whether |?(W)| < 1
% stability(:,2) tell whether Cv > 0
% h = 0.5*time_perod of symmetric limit cycle
% A,B,C = state  space matrices
% d = magnitude of relay feedback
% Step 2 is checking stability of time period

fprintf('Step 2\n') % Let the user know where the program is

% Calculate a,v,W
for i = 1:size(h,2)
    a(:,i) = eqtn2_3(h(i),A,B,eye(size(A)));
    v(:,i) = A*a(:,i) + B*d;
    y0(i) = C*v(:,i);
    
    % Check C*v > 0
    if y0(i)>0
        stability(i,2) = 1;
    else
        stability(i,2) =0;
    end

    W(:,:,i) = (eye(size(A)) -(v(:,i)*C)/(C*v(:,i)))*expm(A*h(i));
    lambda(:,i) = eig(W(:,:,i));
    
    % Check |?(W)| < 1
    for j = 1:size(lambda(:,i),1)
        if abs(lambda(j,i))>=1
            stability(i,1) = 0;
            break
        else 
            stability(i,1) = 1;
            
        end
    end 
    
    % Convert results to messages for user to read
    if stability(i,1) == 1
        message{i,1} = 'Stable';
    else
        message{i,1} = 'Unstable';
    end
    
    if stability(i,2) == 1
        message{i,2} = 'C*v  OK';
    else
        message{i,2} = 'C*v not OK';
    end
    
    % Print messages to screen
    fprintf('Time period %f  is %s and  %s\n', 2*h(i),message{i,1},message{i,2})
end


