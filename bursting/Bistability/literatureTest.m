% close all;
% clear all;

% % [t1,y1] = ode45(@hindmarshRose,[0 2000],[-1;0;+2]);
% [t1,y1] = ode15s(@hindmarshRose,[0 2000],[-1;0;+2]);
% figure();
% plot(t1,y1(:,1))
% hold on
% % plot(t1,y1(:,2))
% plot(t1,y1(:,3))
% 
% 
% %% Plot phase portrait
% figure()
% plot(y1(:,1),y1(:,2),'r')
% hold on
% cubicNullcline = @(x,y) y+3*x^2-x^3;
% quadraticNullcline = @(x,y) 1-5*x^2-y;
% h1 = ezplot(@(x,y) cubicNullcline(x,y),[-5,5]);
% set(h1,'LineColor','b')
% h2 = ezplot(@(x,y) quadraticNullcline(x,y),[-5,5]);
% set(h1,'LineColor','g')
% hold on
% 
% title('Phase portrait')
% xlabel('Voltage')

%% Rinzel model
[t2,y2] = ode15s(@Rinzel,[0 5000],[0;0;0]);
figure(2);
subplot(2,1,1)
plot(t2,y2(:,1),'b')
l1 = legend('x_f')
set(l1,'FontSize',12);
% hold on
% plot(t2,y2(:,2))
subplot(2,1,2)
plot(t2,y2(:,3),'r')
l1=legend('x_{us}')
set(l1,'FontSize',12);

figure(3)
cubicNullcline2 = @(x,y) y-(1/3)*y^3-x + 0.3125;
linearNullcline = @(x,y) y + 0.7-0.8*x;
plot(y2(:,2),y2(:,1),'r')
hold on
h1 = ezplot(@(x,y) cubicNullcline2(x,y),[-5,5]);
set(h1,'LineColor','b')
h2 = ezplot(@(x,y) linearNullcline(x,y),[-5,5]);
set(h1,'LineColor','g')
title('Phase portrait')
xlabel('x_s')
ylabel('x_f')
l2 = legend('Trajectory','$\dot{x}_f = 0$','$\dot{x}_s = 0$')
set(l2,'Interpreter','latex','FontSize',12)
axis([-1,1.5,-2.5,2.5])



