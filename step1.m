% Matlab code implementation attempt of Astrom 1995
function [h, f_data] = step1(f,h_data)
% h = step1()
% Tries to find f(h) = epsilon/d
% You can input your own state space matrices by choosing 0
% or try out the examples given in the paper by choosing 1,2,4
% h = 0 means that it could not find solutions, and shows you
% a plot of the values it tred

fprintf('Step 1\n') % Let user know where the program is 

% Evaluate equation2_3 and find where sign changes (indicating root)
j = 2;
error_check = 0;
fprintf('Evaluating f(h) from h = %d to %d\n',min(h_data),max(h_data))
for i = 1:size(h_data,2)
    f_data(i) = f(h_data(i));
    if i>1
        % Record where sign changes occur
        if f_data(i)*f_data(i-1)<0
            h_pos(j)= h_data(i);
            h_pos(j-1) = h_data(i-1);
            j = j+2;
            error_check = 1; % at least one root found
        end
    end
end



% Bisection to get a more accurate value of h
if error_check % at least one root found
    iter_max = 8;
    for k = 1:0.5*size(h_pos,2)
        iterations = 1;
        m = 2*k - 1;
        h_lower = h_pos(m);
        h_upper = h_pos(1+m);
        h_middle = 0.5*(h_lower+h_upper);
        
        fprintf('Bisecting \n')
        while iterations<=iter_max
            if f(h_middle)*f(h_upper) < 0
                h_lower = h_middle;
                h_middle = 0.5*(h_lower+h_upper);
                
            else
                h_upper = h_middle;
                h_middle = 0.5*(h_lower+h_upper);
                
            end
            iterations = iterations +1;
        end
        h(k) = h_middle;
    end
    
    fprintf('%d solutions found\n', 0.5*size(h_pos,2))
else
    fprintf('No sign changes found! \nHave a look at the plot \n')
    h=0;
end

% Plot results
figure()
plot(h_data,f_data)
I(1) = xlabel('$h$');
I(2) = ylabel('$f(h) - \epsilon/d$');
I(3) = legend('$f(h)- \epsilon/d$');
grid on
set(I, 'Interpreter','Latex')
hold on
plot(h,zeros(size(h,2)),'ro')

end