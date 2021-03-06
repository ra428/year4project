function f = plotEqtn5_2_variant(sysParam)
% f = plotEqtn5_2_variant(sysParams)
% hArray is the range of values of h over which f(h) is evaluated
% The slight tweak is that the relay hysteresis is not symmetric
% and the transfer function has non-zero D matrix
% ie. the relay switches at (e2, e1), where e1 > e2
% Output of the relay is symmetric, d
% sysParams.A, sysParams.B, sysParams.C, sysParams.D, sysParams.e1,
% sysParams.e2


initUI(sysParam)

    function initUI(sysParam)
        hfig = figure('units','normalized','outerposition',[0 0 1 1]);
        initSliderParams(hfig, sysParam);
        initPlot(hfig, sysParam);
        
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
            'Value',getappdata(hfig,'A'),...
            'Callback',@slider_callback1);
        slider1_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY sTextWidth sTextHeight],...
            'String','A');
        
        slider2 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+sHeight sWidth sHeight],...
            'Tag','slider2',...
            'Value',getappdata(hfig,'B'),...
            'Callback',@slider_callback2);
        slider2_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+sHeight sTextWidth sTextHeight],...
            'String','B');
        
        slider3 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+2*sHeight sWidth sHeight],...
            'Tag','slider3',...
            'Value',getappdata(hfig,'C'),...
            'Callback',@slider_callback3);
        slider3_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+2*sHeight sTextWidth sTextHeight],...
            'String','C');
        
        slider4 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+3*sHeight sWidth sHeight],...
            'Tag','slider4',...
            'Value',getappdata(hfig,'D'),...
            'Callback',@slider_callback4);
        slider4_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+3*sHeight sTextWidth sTextHeight],...
            'String','d');
        
        slider5 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+4*sHeight sWidth sHeight],...
            'Tag','slider4',...
            'Value',getappdata(hfig,'alpha'),...
            'Callback',@slider_callback5);
        slider5_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+4*sHeight sTextWidth sTextHeight],...
            'String','α');
        
        slider6 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+5*sHeight sWidth sHeight],...
            'Tag','slider4',...
            'Value',getappdata(hfig,'beta'),...
            'Callback',@slider_callback6);
        slider6_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+5*sHeight sTextWidth sTextHeight],...
            'String','β');
        
        slider7 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+6*sHeight sWidth sHeight],...
            'Tag','slider7',...
                        'Min',0.001, 'Max',0.5,...
            'Value',getappdata(hfig,'u'),...
            'Callback',@slider_callback7);
        slider7_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+6*sHeight sTextWidth sTextHeight],...
            'String','u');
        
        slider8 = uicontrol('Parent', hfig,'Style','slider',...
            'Units','normalized',...
            'Position',[sLeft sY+7*sHeight sWidth sHeight],...
            'Tag','slider8',...
                        'Min',100,'Max',1000,...
            'Value',getappdata(hfig,'tau'),...
            'Callback',@slider_callback8);
        slider8_label = uicontrol('Parent',hfig,'Style','text',...
            'Units','normalized',...
            'Position',[sTextLeft sY+7*sHeight sTextWidth sTextHeight],...
            'String','τ');
        
        
        
    end

%% Callback functions
    function slider_callback1(hObject,eventdata)
        setappdata(hObject.Parent,'A',hObject.Value);
        updatePlot(hObject)
    end
    function slider_callback2(hObject,eventdata)
        setappdata(hObject.Parent,'B',hObject.Value);
        updatePlot(hObject)
    end
    function slider_callback3(hObject,eventdata)
        setappdata(hObject.Parent,'C',hObject.Value);
        updatePlot(hObject)
    end
    function slider_callback4(hObject,eventdata)
        setappdata(hObject.Parent,'D',hObject.Value);
        updatePlot(hObject)
    end
    function slider_callback5(hObject,eventdata)
        setappdata(hObject.Parent,'alpha',hObject.Value);
        updatePlot(hObject)
    end
    function slider_callback6(hObject,eventdata)
        setappdata(hObject.Parent,'beta',hObject.Value);
        updatePlot(hObject)
    end
    function slider_callback7(hObject,eventdata)
        setappdata(hObject.Parent,'u',hObject.Value);
        updatePlot(hObject)
    end
    function slider_callback8(hObject,eventdata)
        setappdata(hObject.Parent,'tau',hObject.Value);
        updatePlot(hObject)
    end

   %% Update plot
   
    function updatePlot(hObject)
        A = getappdata(hObject.Parent,'A');
        B = getappdata(hObject.Parent,'B');
        C = getappdata(hObject.Parent,'C');
        D = getappdata(hObject.Parent,'D');
        alpha = getappdata(hObject.Parent,'alpha');
        beta = getappdata(hObject.Parent,'beta');
        u = getappdata(hObject.Parent,'u');
        tau = getappdata(hObject.Parent,'tau');
        T = 1700;
        kb = 0.5;
        
        e1 =  1 - beta + alpha + kb * u;
        e2 = -1 + beta + alpha + kb * u;
        
        fh = evalEqtn5_2_variant(A,B,C,D,e1,e2,d,T,tau);
        plot(fh.T,fh.h1)
        hold on
        plot(fh.T,fh.h2)
        xlabel('T')
        legend('fh1','fh2')
        
        
    end

    function initPlot(figureHandle,sysParam)
        fh = evalEqtn5_2_variant(sysParam.A, sysParam.B, sysParam.C, ...
            sysParam.D, sysParam.e1, sysParam.e2, sysParam.d, sysParam.T...
            sysParam.tau)
        plot(fh.T,fh.h1)
        hold on
        plot(fh.T,fh.h2)
        xlabel('T')
        legend('fh1','fh2')
    end

    function fh = evalEqtn5_2_variant(A,B,C,D,e1,e2,d,T,tau)
        Phi = @(s) expm(A*s);
        G = @(t) B * integral(Phi,0,t,'ArrayValue', true);
        I = eye(size(A));
        
        Tmax = T + 1000;
        fh.T = linspace(0, Tmax, Tmax);
        fh.h1 = zeros(Tmax,1);
        fh.h2 = zeros(Tmax,1);
        d = d;
        
        for i = 1:Tmax
            % Dd + C(I-Φ)^-1 (Φ2Γ1d - Γ2d) + ε2 = 0
            fh.h1(i) = D*d + C * inv(I - Phi(T(i)) ...
                * (Phi(T(i) - tau) * ...
                G(tau)*d - G(T(i) - tau)*d) + e2;
            
            % - Dd + C(I-Φ)^-1 (-Φ1Γ2d + Γ1d) - ε1 = 0
            fh.h2(i) = -D*d + C * inv(I - Phi(T(i)) ...
                * (-Phi(tau) * ...
                G(T(i) - tau)*d + G(tau)*d) - sys.Param.e1;
        end
        
    end

    function initSliderParams(figureHandle,sysParam)
        % Set parameter values
        setappdata(figureHandle,'A',sysParam.A);
        setappdata(figureHandle,'B',sysParam.B);
        setappdata(figureHandle,'C',sysParam.C);
        setappdata(figureHandle,'D',sysParam.D);
        setappdata(figureHandle,'alpha',sysParam.alpha);
        setappdata(figureHandle,'beta',sysParam.beta);
        setappdata(figureHandle,'u',sysParam.u);
        setappdata(figureHandle,'tau',sysParam.tau);
        setappdata(figureHandle,'T',sysParam.T);
             
    end








end