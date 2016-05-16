function manipulateParameters
clear all
initUi()
%% Initialise sliders and graph
    function initUi()
        hfig = figure('units','normalized','outerposition',[0 0 1 1]);
        subplot(1,2,1);
        
        initSliderParams(hfig);
        initPlot(hfig);
        initSystem(hfig);
        
        %% Sliders
        sHeight = 0.03;
        sWidth = 0.1;
        sLeft = 0.015;
        sY = 0.01;
        
        sTextLeft = 0;
        sTextHeight = 0.025;
        sTextWidth = 0.015;
        
        slider1 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY sWidth sHeight],...
            'Tag','slider1',...
            'Value',getappdata(hfig,'alpha'),...
            'Callback',@slider_callback1);
        slider1_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY sTextWidth sTextHeight],...
            'String','α');
        
        slider2 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+sHeight sWidth sHeight],...
            'Tag','slider2',...
            'Value',getappdata(hfig,'beta'),...
            'Callback',@slider_callback2);
        slider2_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+sHeight sTextWidth sTextHeight],...
            'String','β');
        
        slider3 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+2*sHeight sWidth sHeight],...
            'Tag','slider3',...
            'Value',getappdata(hfig,'gamma'),...
            'Callback',@slider_callback3);
        slider3_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+2*sHeight sTextWidth sTextHeight],...
            'String','γ');
        
        slider4 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+3*sHeight sWidth sHeight],...
            'Tag','slider4',...
            'Value',getappdata(hfig,'u'),...
            'Callback',@slider_callback4);
        slider4_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+3*sHeight sTextWidth sTextHeight],...
            'String','u');
        
        slider5 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+4*sHeight sWidth sHeight],...
            'Tag','slider4',...
            'Value',getappdata(hfig,'delta'),...
            'Callback',@slider_callback5);
        slider5_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+4*sHeight sTextWidth sTextHeight],...
            'String','δ');
        
        slider6 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+5*sHeight sWidth sHeight],...
            'Tag','slider4',...
            'Value',getappdata(hfig,'ts'),...
            'Callback',@slider_callback6);
        slider6_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+5*sHeight sTextWidth sTextHeight],...
            'String','τs');
        
        slider7 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+6*sHeight sWidth sHeight],...
            'Tag','slider7',...
            'Min',0.001, 'Max',0.5,...
            'Value',getappdata(hfig,'tf'),...
            'Callback',@slider_callback7);
        slider7_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+6*sHeight sTextWidth sTextHeight],...
            'String','τf');
        
        slider8 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+7*sHeight sWidth sHeight],...
            'Tag','slider8',...
            'Min',100,'Max',1000,...
            'Value',getappdata(hfig,'tus'),...
            'Callback',@slider_callback8);
        slider8_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+7*sHeight sTextWidth sTextHeight],...
            'String','τu');
        
        slider9 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+8*sHeight sWidth sHeight],...
            'Tag','slider9',...
            'Min',-2,'Max',2,...
            'Value',getappdata(hfig,'alpha_const'),...
            'Callback',@slider_callback9);
        slider9_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+8*sHeight sTextWidth sTextHeight],...
            'String','αc');
        
        slider10 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+9*sHeight sWidth sHeight],...
            'Tag','slider10',...
            'Min',1000,'Max',10000,...
            'Value',getappdata(hfig,'tmax'),...
            'Callback',@slider_callback10);
        slider10_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+9*sHeight sTextWidth sTextHeight],...
            'String','T');
        
        busy_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+10*sHeight sTextWidth*7 sTextHeight],...
            'String','Busy');
        
    end

%% Callback functions
    function slider_callback1(hObject,eventdata)
        setappdata(hObject.Parent,'alpha',hObject.Value);
        updatePlot(hObject)
    end

    function slider_callback2(hObject,eventdata)
        setappdata(hObject.Parent,'beta',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end

    function slider_callback3(hObject,eventdata)
        setappdata(hObject.Parent,'gamma',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end
    function slider_callback4(hObject,eventdata)
        setappdata(hObject.Parent,'u',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end

    function slider_callback5(hObject,eventdata)
        setappdata(hObject.Parent,'delta',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end

    function slider_callback6(hObject,eventdata)
        setappdata(hObject.Parent,'ts',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end


    function slider_callback7(hObject,eventdata)
        setappdata(hObject.Parent,'tf',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end
    function slider_callback8(hObject,eventdata)
        setappdata(hObject.Parent,'tus',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end
    function slider_callback9(hObject,eventdata)
        setappdata(hObject.Parent,'alpha_const',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end
    function slider_callback10(hObject,eventdata)
        setappdata(hObject.Parent,'tmax',hObject.Value);
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        updatePlot(hObject)
        updateSystemPlot(hObject)
    end

%% Update plot
    function updatePlot(hObject)
        % Nullclines
        bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
        fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
        fast_nullcline_relay = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + sign(bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
        fast_nullcline_relay_piecewise = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + sign(piece_wise_bump_2(u + xs +0.5*gamma*xf) + beta*xf+ alpha))/ef);
        linear_plant = @(xs,xf,ts) (xf-xs*ts);
        
        % Get slider values
        alpha = getappdata(hObject.Parent,'alpha');
        beta = getappdata(hObject.Parent,'beta');
        gamma = getappdata(hObject.Parent,'gamma');
        u = getappdata(hObject.Parent,'u');
        delta = getappdata(hObject.Parent,'delta');
        ts = getappdata(hObject.Parent,'ts');
        %         fprintf('α    β    γ    δ    u    τ_s \n')
        %         disp([alpha beta gamma delta u ts])
        
        % Other parameters
        tf = 0.0075;
        
        %         h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
        subplot(1,2,1)
        h1 = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
        set(h1,'Color','b');
        hold on
        h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
        %         text = sprintf('\\alpha = %f',alpha);
        %         legend(text)
        %         display( getappdata(hObject.Parent,'Sl_alpha'));
        % % 	diffval = getappdata(hObject.Parent,'difference');
        % % 	display([currentval
        
        title('Nullclines');
        xlabel('xs');
        ylabel('xf');
        hold off
        
    end

    function initPlot(hfig)
        % Nullclines
        bump = @(x,delta) (tanh(x+delta) - tanh(x-delta) -2*tanh(delta));
        fast_nullcline = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + tanh(xf+ bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
        fast_nullcline_relay = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + sign(bump(u + xs +0.5*gamma*xf,delta) + beta*xf+ alpha))/ef);
        fast_nullcline_relay_piecewise = @(xs,xf,u,gamma,beta,alpha,delta,ef)...
            ((-xf + sign(piece_wise_bump_2(u + xs +0.5*gamma*xf) + beta*xf+ alpha))/ef);
        linear_plant = @(xs,xf,ts) (xf-xs*ts);
        
        % parameters
        alpha = 0.5;
        beta = 0.5;
        gamma = 1;
        delta = 0.5;
        u = 0.5;
        tf = 0.5;
        ts = 1;
        tf = 0.0075;
        
        %         h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
        subplot(1,2,1)
        h1 = ezplot(@(x,y)fast_nullcline_relay_piecewise(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
        set(h1,'Color','b');
        hold on
        h2 = ezplot(@(x,y)linear_plant(x,y,ts),[-4,4]);
        title('Nullclines');
        xlabel('xs');
        ylabel('xf');
        hold off
        
    end

    function initSliderParams(hfig)
        % Set parameter values
        %         setappdata(hfig,'alpha',0.5);
        %         setappdata(hfig,'beta',0.27);
        %         setappdata(hfig,'gamma',1);
        %         setappdata(hfig,'delta',0.5);
        %         setappdata(hfig,'u',0.8);
        %         setappdata(hfig,'tf',0.0075);
        %         setappdata(hfig,'ts',1);
        %         setappdata(hfig,'tus',800);
        %         setappdata(hfig,'tmax',5000);
        %         setappdata(hfig,'alpha_const',0.1);
        
        setappdata(hfig,'alpha',0.5);
        setappdata(hfig,'beta',0.37);
        setappdata(hfig,'gamma',0);
        setappdata(hfig,'delta',0.5);
        setappdata(hfig,'u',0.8);
        setappdata(hfig,'tf',0.0075);
        setappdata(hfig,'ts',1);
        setappdata(hfig,'tus',800);
        setappdata(hfig,'tmax',2000);
        setappdata(hfig,'alpha_const',0.0);
        
    end

    function y = piece_wise_bump_2(x)
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

    function initSystem(hfig)
        %         alpha = 0.5;
        %         beta = 0.27;
        %         gamma = 1;
        %         delta = 0.5;
        %         u = 0.8;
        %         alpha_const = 0.1;
        %         tf = 0.0075;
        %         ts = 1;
        %         tus = 800;
        %         tmax = 5000;
        %         ultra_slow_plant_X0 = 0;
        %         slow_plant_X0 = -1.05;
        %         fast_plant_X0 = -1.05;
        
        
        alpha = 0.5;
        beta = 0.37;
        gamma = 0;
        delta = 0.5;
        u = 0.8;
        alpha_const = 0.0;
        tf = 0.0075;
        ts = 1;
        tus = 800;
        tmax = 2000;
        ultra_slow_plant_X0 = 0.45;
        slow_plant_X0 = -1.0;
        fast_plant_X0 = -1.0;
        
        load_system('bursting_linear')
        set_param('bursting_linear/Constant1','Value',num2str(u))
        set_param('bursting_linear/Constant2','Value',num2str(alpha_const))
        set_param('bursting_linear/State-Space','A',num2str(-1/tf),'B',num2str(1/tf),'C','1','D','0','X0',num2str(fast_plant_X0))
        set_param('bursting_linear/State-Space1','A',num2str(-1/ts),'B',num2str(1/ts),'C','1','D','0','X0',num2str(slow_plant_X0))
        set_param('bursting_linear/State-Space2','A',num2str(-1/tus),'B',num2str(-1/tus),'C','1','D','0','X0',num2str(ultra_slow_plant_X0))
        set_param('bursting_linear/Gain','Gain',num2str(beta))
        set_param('bursting_linear/Gain1','Gain',num2str(gamma/2))
%         SimOut = sim('bursting_linear','StopTime',num2str(tmax));
        
%         initSystemPlot(SimOut);
        
    end

    function initSystemPlot(SimOut)
        
        subplot(1,2,2)
        plot(SimOut.get('xf').Time, SimOut.get('xf').Data,'b')
        hold on
        plot(SimOut.get('ultra_slow').Time, SimOut.get('ultra_slow').Data,'r')
        % plot(SimOut.get('bump_input').Time, SimOut.get('bump_input').Data,'g')
        xlabel('Time')
        legend('xf','alpha')
        hold off
        disp('Finished plotting simulation')
        
    end

    function updateSystemPlot(hObject)
        disp('Starting simulation')
        alpha = getappdata(hObject.Parent,'alpha');
        beta = getappdata(hObject.Parent,'beta')
        gamma = getappdata(hObject.Parent,'gamma')
        u = getappdata(hObject.Parent,'u')
        delta = getappdata(hObject.Parent,'delta');
        ts = getappdata(hObject.Parent,'ts');
        tf = getappdata(hObject.Parent,'tf');
        tus = getappdata(hObject.Parent,'tus');
        tmax = getappdata(hObject.Parent,'tmax');
        alpha_const =getappdata(hObject.Parent,'alpha_const')
        
        ultra_slow_plant_X0 = 0;
        slow_plant_X0 = -1.05;
        fast_plant_X0 = -1.05;
        
        set_param('bursting_linear/Constant1','Value',num2str(u))
        set_param('bursting_linear/Constant2','Value',num2str(alpha_const))
        set_param('bursting_linear/State-Space','A',num2str(-1/tf),'B',num2str(1/tf),'C','1','D','0','X0',num2str(fast_plant_X0))
        set_param('bursting_linear/State-Space1','A',num2str(-1/ts),'B',num2str(1/ts),'C','1','D','0','X0',num2str(slow_plant_X0))
        set_param('bursting_linear/State-Space2','A',num2str(-1/tus),'B',num2str(-1/tus),'C','1','D','0','X0',num2str(ultra_slow_plant_X0))
        set_param('bursting_linear/Gain','Gain',num2str(beta))
        set_param('bursting_linear/Gain1','Gain',num2str(gamma/2))
%         SimOut = sim('bursting_linear','StopTime',num2str(tmax));
        set_param('bursting_linear', 'SimulationCommand', 'stop');
        
%         initSystemPlot(SimOut);
    end

    function finishedSimulation()
        set(handleToSlider, 'min', 61);
    end

end
