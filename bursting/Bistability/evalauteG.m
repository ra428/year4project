function output = evalauteG(xs,xf,alpha,beta,gamma,u)

output = G(xs,xf,alpha,beta,gamma,u);

    function y = G( x1,x2,alpha , beta, gamma, u)
        %         Evaluate ef * dxf/dt
        y = -x2 + sign(bump_piecewise(u+x1+0.5*gamma*x2) + beta*x2 + alpha);
    end

    function y = bump_piecewise(x)
        if (x>-2 && x<=0)
            y = 0.5*x;
        elseif (x<2 && x>0)
            y = -0.5*x;
        else
            y = -1;
        end
    end
end
