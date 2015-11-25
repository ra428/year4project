a = [-1.1262 -1.1262 -.9976 -.9976;...
      0.2693 -0.6883  0.0061 -1.003];


skew = [1 0; 2 1];
skew2 = inv(skew);

for i = 1:4
    a(:,i) = a(:,i) + [1.0619;0.3535];
   b(:,i) = skew*a(:,i);
end


ax1 = linspace(-.0000001,.0000001);
ax2 = 0*ax1;

x1 = [ax2;ax1];
x2 = skew2*x2;



figure()

plot(a(1,1),a(2,1),'xb')
hold on;grid on
plot(a(1,2),a(2,2),'xr')
plot(a(1,3),a(2,3),'xg')
plot(a(1,4),a(2,4),'xm')

plot(b(1,1),b(2,1),'ob')
hold on;grid on
plot(b(1,2),b(2,2),'or')
plot(b(1,3),b(2,3),'og')
plot(b(1,4),b(2,4),'om')

plot(ax1,ax2,'black')
plot(ax2,ax1,'black')

plot(x2(1,:),x2(2,:),'black--')

axis([-.7 .7 -.7 .7])




