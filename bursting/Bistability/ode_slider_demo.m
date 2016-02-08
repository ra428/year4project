%
% Sample code to demonstrate a uislider
% to update an ode solution
%

function ode_slider_demo



% Build the GUI
init_ui;


% This funciton sets up the figure and slider.
% note the CreateFcn and the Callback.
% The CreatFcn runs the first time while the Callback
% runs each time you move the slider.
    function init_ui()
        f1 = figure;
        slider1 = uicontrol('Style', 'slider',...
            'Min',0,'Max',1,'Value',0.5,...
            'Position', [100 10 400 20],...
            'CreateFcn', @solve_and_plot,...
            'Callback',  @solve_and_plot);
        slider2 = uicontrol('Style', 'slider',...
            'Min',0,'Max',1,'Value',0.5,...
            'Position', [100 30 400 40],...
            'CreateFcn', @solve_and_plot,...
            'Callback',  @solve_and_plot);
    end



% This funciton it what is run when you first run the
% code and each time you move the slider.
    function solve_and_plot(src,event)
        % Nullclines
        % Nullcline functions
        bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
        fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
        fast_nullcline_relay = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + sign(bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
        fast_nullcline_relay_piecewise = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + sign(piece_wise_bump2(u + xs +0.5*gamma*xf) + beta*xf+ alpha))/ef);
        linear_plant = @(xs,xf,ts) (xf-xs*ts);
        
        
        m = 0.65;
        alpha = 0.5;
        % beta = .25;
        beta = 0.45;
        gamma = 1;
        delta = 0.5;
        u = 0.8 ;
        tf = 0.0075;
        ts = 1;
        tmax = 3500;
        alpha_max = 1.75;
        alpha_period = tmax;
        alpha_width = 1; % %of period
        alpha_delay1 = 200;
        alpha_delay2 = 300;
        slow_plant_X0 = -1.05;
        fast_plant_X0 = -1.05;
        
        
        
        % Get the current slider value
        alpha_param = get(slider1,'Value');
        beta_param = get(slider2,'Value');
        
        
        % Update plot
        %         h1 = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta_param,alpha_param,delta,tf),[-4,4]);
        h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta_param,alpha_param,delta,tf),[-4,4]);
        
        set(h1,'Color','b');
        hold on
        h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
        text = sprintf('alpha = %f',alpha_param );
        legend(text)
        hold off
        title('Nullclines');
        xlabel('xs');
        ylabel('xf');
        
    end

end