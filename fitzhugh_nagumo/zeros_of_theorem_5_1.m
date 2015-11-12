function z = zeros_of_theorem_5_1(e1, e2, d1, d2, T, tau)
% function z = zeros_of_theorem_5_1(e1, e2, d1, d2, T, tau)
% assumes C = B = 1 and that A is a scalar
% tries to find the A that satisfies the theorem given the other
% variables

fun = @(x) (exp(x*T)*d1 + d2 - exp(x*(T-tau))*(d1+d2))/...
    (-exp(x*T)*d2 - d1 + exp(x*tau)*(d1+d2)) - e1/e2;

% Plot the function
a = linspace(-10,10);
for i = 1:size(a,2)
    evals(i) = fun(a(i));
end

z = fzero(fun,1);

figure()
plot(a(:),evals(:))
xlabel('A')
ylabel('')
grid on
end
