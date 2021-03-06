function fh = evalEqtn5_2_variant(h, A, B, C, D, d, e1, e2)
% fh = evalEqtn5_2_variant(h, A, B, C, D, d, e1, e2)
% Plot the conditions for oscillations from Thoerem 5.1
% hArray is the range of values over which to plot f(h)
% The slight tweak is that the relay hysteresis is not symmetric
% ie. the relay switches at (e2, e1)
% Output of the relay is symmetric, d, 
% so Phi1 = Phi2 and G1 = G2 in the paper
%
% This is essentially the symmetric oscillation that is shifted
% by mean(e1,e2)


I = eye(size(A));
phi = expm(A.*h);

if det(A) ~= 0
    fh(1) = D + C*inv(I - phi*phi)*((phi - I)^2)*inv(A)*B*d - e2;
    fh(2) =-D + C*inv(I - phi*phi)*((I - phi)^2)*inv(A)*B*d - e1;
else
    fun = @(s) expm(A*s)*B;
    G = integral(fun,0,h, 'ArrayValue', true);
    fh(1) = D + C*inv(I + phi*phi)*(phi - I)*G*d -e2;
    fh(2) =-D + C*inv(I + phi*phi)*(I - phi)*G*d -e1;
end

% figure()
% plot(hArray,fh(1),'b')
% hold on
% plot(hArray,fh(2),'r')
% xlabel('h')
% ylabel('f(h)')
% legend('f_1(h)','f_2(h)')

end