function y = piece_wise_bump2(x)
y = -1*ones(size(x,1),size(x,2));
index1 = x<-2;
index2 = -2<=x&x<0;
index3 = 0<=x&x<2;
index4 = 2<=x;

y(index1) = -1;
y(index2) = 0.5*x(index2);
y(index3) = -0.5*x(index3);
y(index4) = -1;
end

