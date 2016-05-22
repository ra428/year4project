% Draw graphs for report
close all;
clear all;
saturation = @(x) max(-1,min(1,x));
pieceBump = @(x) max(-1,min(0,0.5*x)) + max(-1,min(0,-0.5*x));

delta = 0.5;
N = 100;
xArray = linspace(-4,4,N);

for i = 1:N
    y1(i) = tanh(xArray(i));
    y2(i) = saturation(xArray(i));
    y3(i) = tanh(xArray(i) + delta) - tanh(xArray(i) - delta) -2*tanh(delta);
    y4(i) = pieceBump(xArray(i));
end

figure(1)
p1 = plot(xArray, y1,'b')
hold on
p2 = plot(xArray, y2,'r')
set(p1,'LineWidth',2);
set(p2,'LineWidth',2);
l1 = legend('$y = tanh(x)$', '$y = sat(x)$');
set(l1,'Interpreter','latex','FontSize',16);
axis([-4,4,-1.25,1.25]);
xlabel('x')
ylabel('y')

figure(2)
p3 = plot(xArray, y3,'b')
hold on
p4 = plot(xArray, y4,'r')
set(p3,'LineWidth',2);
set(p4,'LineWidth',2);
l2 = legend('$y = B_\delta(x)$', '$y = B_p(x)$');
set(l2,'Interpreter','latex','FontSize',16);
axis([-4,4,-1.25,.25])
xlabel('x')
ylabel('y')

figure(3)
p5 = plot(xArray, y3, 'b');
set(p5,'LineWidth',2);
axis('equal');
grid on
