% close all;
% clear all;

% [t1,y1] = ode45(@hindmarshRose,[0 2000],[-1;0;+2]);
[t1,y1] = ode15s(@hindmarshRose,[0 2000],[-1;0;+2]);
figure();
plot(t1,y1(:,1))
hold on
% plot(t1,y1(:,2))
plot(t1,y1(:,3))


%% Plot phase portrait
figure()
plot(y1(:,1),y1(:,2),'r')
hold on
cubicNullcline = @(x,y) y+3*x^2-x^3;
quadraticNullcline = @(x,y) 1-5*x^2-y;
h1 = ezplot(@(x,y) cubicNullcline(x,y),[-5,5]);
set(h1,'LineColor','b')
h2 = ezplot(@(x,y) quadraticNullcline(x,y),[-5,5]);
set(h1,'LineColor','g')
hold on

title('Phase portrait')
xlabel('Voltage')

%% Rinzel model
% [t2,y2] = ode15s(@Rinzel,[0 5000],[0;0;0]);
% figure(2);
% plot(t2,y2(:,1))



