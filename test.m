% Matlab code implementation attempt of Astrom 1995

% Testing basics
% Example 1
A = [-1 1 0; 0 -1 1; 0 0 -1];
B = [0 ; 0 ; 1 ];
C = [1 0 0];
epsilon = 0;
d = 1;

N = 50;
h = linspace(0,10,N);
f = zeros(1,N);

for i = 1:N
    f(i) = theorem1(h(i), A, B, C);
end

plot(h, f)
xlabel('h')
ylabel('f(h')






