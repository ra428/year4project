function output = evaluateDerivatives(variables,beta,gamma,u)
% xs = variables(1);
% xf = variables(2);
% alpha = variables(3);

output(1,1) = G(variables, beta, gamma, u);
output(1,2) = G_xs(variables, beta, gamma, u);
output(1,3) = G_xf(variables, beta, gamma, u);


    function y = G( variables, beta, gamma, u)
        %         Evaluate ef * dxf/dt
        xs = variables(1);
        xf = variables(2);
        alpha = variables(3);
        y = -xf + sign(bump_piecewise(u+xs+0.5*gamma*xf) + beta*xf + alpha)
    end

    function dydxs = G_xs(variables,beta,gamma,u)
        xs = variables(1);
        xf = variables(2);
        alpha = variables(3);
        c = u+xs+0.5*gamma*xf;
        if(c >=-2 && c <0)
                        dydxs = dirac(bump_piecewise(c) + beta*xf + alpha);
%             dydxs = kroneckerDelta(bump_piecewise(c) + beta*xf + alpha);
        elseif(0<c && c<=2)
                        dydxs = -dirac(bump_piecewise(c)+beta*xf + alpha);
%             dydxs = -kroneckerDelta(bump_piecewise(c)+beta*xf + alpha);
        else
            dydxs = 0;
        end
    end

    function dydxf = G_xf(variables,beta,gamma,u)
        xs = variables(1);
        xf = variables(2);
        alpha = variables(3);
        c = u + xs + 0.5*gamma*xf;
        if(c >=-2 && c <0)
                        dydxf = -1 + 2 * (beta + 0.25 * gamma) * dirac(bump_piecewise(c) + beta * xf + alpha);
%             dydxf = -1 + 2 * (beta + 0.25 * gamma) * kroneckerDelta(bump_piecewise(c) + beta * xf + alpha);
        elseif(0<c && c<=2)
                        dydxf = -1 + 2 * (beta - 0.25 * gamma) * dirac(bump_piecewise(c) + beta * xf + alpha);
%             dydxf = -1 + 2 * (beta - 0.25 * gamma) * kroneckerDelta(bump_piecewise(c) + beta * xf + alpha);
        else
            dydxf = -1;
        end
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
