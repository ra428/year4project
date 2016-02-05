function y = piece_wise_bump(x)
% Piecewise linear approximation of Bump(.) with delta =0.5;

if (x < -2)
     y = -1;
elseif (x > 2)
     y = -1;
elseif and( x>=-2,x < 0)
     y = 0.5*x;
else
     y = -0.5*x;
end

% % for i = 1:numel(x)
% %     
% %     if (x(i) < -2)
% %          y(i) = -1;
% %     elseif (x(i) > 2)
% %          y(i) = -1;
% %     elseif and( x(i)>=-2,x(i) < 0)
% %          y(i) = 0.5*x(i);
% %     else
% %          y(i) = -0.5*x(i);
% %     end
% % end