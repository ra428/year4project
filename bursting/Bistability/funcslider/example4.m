% Logistic Map Example
function h = example4(x0,r,N)

fast_nullcline_relay_piecewise = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
    ((-xf + sign(piece_wise_bump2(u + xs +0.5*gamma*xf) + beta*xf+ alpha))/ef);


h = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta,SimOut.get('alpha_vary').Data(i),delta,tf),[-4,4]);
    set(h1,'Color','b');
    
end

    

