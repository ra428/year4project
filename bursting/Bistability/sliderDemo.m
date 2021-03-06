function sliderDemo

init_ui()
    %% Initialise sliders and graph
    function init_ui()
        hfig = figure();
        ax = axes('Parent',hfig,'position',[0.13 0.2  0.77 0.74]);
        
        % Set parameter values
        setappdata(hfig,'alpha',0.5);
        setappdata(hfig,'beta',0.5);
        setappdata(hfig,'gamma',1);
        setappdata(hfig,'delta',0.5);
        setappdata(hfig,'u',0.5);
        setappdata(hfig,'tf',0.5);
        setappdata(hfig,'ts',1);
%         updatePlot(hfig)
        
        %% Sliders
        slider1 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[0.05 0.01 0.4 0.05],...
            'Tag','slider1',...
            'Callback',@slider_callback1);
        slider1_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[0.001 0.005 0.05 0.05],...
            'String','α');
        
        slider2 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[0.05 0.055 0.4 0.05],...
            'Tag','slider2',...
            'Callback',@slider_callback2);
        slider2_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[0.001 0.05 0.05 0.05],...
            'String','β');
        
        slider3 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[0.05 0.1 0.4 0.05],...
            'Tag','slider3',...
            'Callback',@slider_callback3);
        slider3_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[0.001 0.1 0.05 0.05],...
            'String','γ');
        
        
        slider4 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[0.55 0.01 0.4 0.05],...
            'Tag','slider4',...
            'Callback',@slider_callback4);
        slider4_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[0.95 0.005 0.05 0.05],...
            'String','u');
        
        slider5 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[0.55 0.055 0.4 0.05],...
            'Tag','slider4',...
            'Callback',@slider_callback5);
        slider5_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[0.95 0.05 0.05 0.05],...
            'String','δ');
  
        slider6 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[0.55 0.1 0.4 0.05],...
            'Tag','slider4',...
            'Callback',@slider_callback6);
        slider6_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[0.95 0.1 0.05 0.05],...
            'String','τs');
        
    end
%% Callback
    function slider_callback1(hObject,eventdata)
        setappdata(hObject.Parent,'alpha',hObject.Value);
        updatePlot(hObject)
    end

    function slider_callback2(hObject,eventdata)
        setappdata(hObject.Parent,'beta',hObject.Value);
        updatePlot(hObject)
    end

    function slider_callback3(hObject,eventdata)
        setappdata(hObject.Parent,'gamma',hObject.Value);
        updatePlot(hObject)
    end
    function slider_callback4(hObject,eventdata)
        setappdata(hObject.Parent,'u',hObject.Value);
        updatePlot(hObject)
    end

    function slider_callback5(hObject,eventdata)
        setappdata(hObject.Parent,'delta',hObject.Value);
        updatePlot(hObject)
    end

    function slider_callback6(hObject,eventdata)
        setappdata(hObject.Parent,'ts',hObject.Value);
        updatePlot(hObject)
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
            ((-xf + sign(piece_wise_bump2(u + xs +0.5*gamma*xf) + beta*xf+ alpha))/ef);
        linear_plant = @(xs,xf,ts) (xf-xs*ts);
        
        % Get slider values
        alpha = getappdata(hObject.Parent,'alpha');
        beta = getappdata(hObject.Parent,'beta');
        gamma = getappdata(hObject.Parent,'gamma');
        u = getappdata(hObject.Parent,'u');
        delta = getappdata(hObject.Parent,'delta');
        ts = getappdata(hObject.Parent,'ts');        
        fprintf('α    β    γ    δ    u    τ_s \n')
        disp([alpha beta gamma delta u ts])
        
        % Other parameters
        tf = 0.0075;
%         ts = 1;
        
%         h1 = ezplot(@(x,y)fast_nullcline(x,y,u,gamma,beta,alpha,delta,tf),[-4,4]);
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



end
