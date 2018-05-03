function varargout = four_w(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @four_w_OpeningFcn, ...
                   'gui_OutputFcn',  @four_w_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before four_w is made visible.
function four_w_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

ha=axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'down')
II=imread('backgroud1.jpg');  
image(II)  
colormap white  
set(ha,'handlevisibility','off','visible','off');

axes(handles.axes1)
xlabel('t');
ylabel('y(t)')
axes(handles.axes2)
xlabel('w')
ylabel('F(jw)')
guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = four_w_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
%popupmenu1（下拉菜单栏）的回调函数，主要监控下拉菜单栏中的动作以及作出的响应。
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(handles.popupmenu1,'Value');
axes(handles.axes1)
switch val
    case 1
    case 2										%符号函数
        t=-1:0.0001:1;
        y=heaviside(t)-heaviside(-t);
        plot(t,y);
        xlabel('t');
        ylabel('y(t)')
        axis([-1 1 -1.5 1.5])
        legend('y=u(t)-u(-t)')
    case 3										%单位阶跃信号
        t=-1:0.01:5; 
        y=heaviside(t); 
        plot(t,y); 
        xlabel('t')
        ylabel('y(t)')
        axis([-1,3,-0.2,1.5])
        legend('y=u(t)')
    case 4										%单边指数信号
        t=-1:0.0001:5;
        y=0.5*exp(-t);
        plot(t,y)
        xlabel('t');
        ylabel('y(t)')
        legend('y=0.5{e}^{2t}')
    case 5										%单边余弦信号
        t=0:0.0001:6;
        y=cos(4*t).*heaviside(t);
        plot(t,y)
        xlabel('t');
        ylabel('y(t)')
        legend('y=cos(4t)*u(t)')
    case 6										%复合余弦信号
        t=0:0.0001:6;
        y=cos(2*t).*heaviside(t)+sin(4*t).*heaviside(t);
        plot(t,y)
        xlabel('t');
        ylabel('y(t)')
        legend('y=cos(2t)*u(t)+sin(4t)*u(t)')         
  case 7										%抽样函数信号
       t=-20:0.01:20;
       y1=sin(t)./t;
       y2=sin(2*t)./(2*t);
       plot(t,y1,t,y2,'--')
       xlabel('t');
       ylabel('y(t)')
       legend('y1=sin(t)./t','y2=sin(2*t)./(2*t)');
        
    case 8										%三角脉冲信号
        t=-4:0.0001:4;
        y1=tripuls(t,4,0.5);
        y2=tripuls(t+2,2,0.5);
        plot(t,y1,t,y2,'--')
        xlabel('t');
        ylabel('y(t)')
        legend('y1=tripuls(t,4,0.5)','y2=tripuls(t+2,2,0.5)')
    case 9										%门函数
        t=-20:0.0001:20;
        y=heaviside(t+1)-heaviside(t-1);
        plot(t,y)
        xlabel('t');
        ylabel('y(t)')   
        legend('y=u(t+1)-u(t-1)')
 	case 10								    %单位冲激函数
        t=-10:0.0001:10;
        y=(t==0);        			        		%条件判断，只有x=0或1的时候，y才“1”
        plot(t,y);
        xlabel('t');
        ylabel('y(t)')  
        legend('y=\delta(t)')
    case 11								    %双冲激函数
        t=-10:0.0001:10;
        y=(t==-2|t==2);        			        		%条件判断，只有x=0或1的时候，y才“1”
        plot(t,y);
        xlabel('t');
        ylabel('y(t)')  
        legend('y=\delta(t-2)+\delta(t+2)')
    case 12										%直流信号
        f='1';
        fplot(f,[0 1])
        xlabel('时间（t）');
        ylabel('幅值（f）');
        legend('y=1')
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
%pushbutton(按钮)的回调函数，监控按钮按下动作，并作出相应的响应。
function pushbutton1_Callback(hObject, eventdata, handles)

val=get(handles.popupmenu1,'Value');
axes(handles.axes2)
switch val
    case 2          %符号函数
        t=-1:0.0001:1;
        syms t
        y=sym('heaviside(t)')-sym('heaviside(-t)');
        F=fourier(y);
        ezplot(abs(F));
        ylabel('F(w)')
        axis([-6 6 0 100]);
    case 3
        t=-1:0.01:5; 
        y=heaviside(t); 
        j=sqrt(-1);
        F=1./(j*t);
        plot(t,abs(F)) 
        axis([-1,3,0,100]); 
        xlabel('w')
        ylabel('F(jw)')
    case 4          %单边指数信号
        t=-5:0.0001:5;
        syms t
        y=0.5*exp(-t)*sym('heaviside(t)');
        F=fourier(y);
        ezplot(abs(F));
        ylabel('F(w)')
    case 5          %单边余弦信号
        t=-2:0.0001:2;
        syms t
        y=cos(4*t)*sym('heaviside(t)');
        F=fourier(y);
        ezplot(abs(F));
        axis([-7,7,0,100]);
        ylabel('F(w)');
    case 6          %复合正弦信号
        t=-5:0.001:5;
        syms t
        val1 = cos(2*t);
        val2 = sin(4*t);
        y=val1*sym('heaviside(t)')+val2*sym('heaviside(t)');
        F=fourier(y);
        ezplot(abs(F));
        axis([-7,7,0,100]);
        ylabel('F(w)');
    case 7              %抽样函数信号
        syms t
        r=0.01;									%采样间隔
        j=sqrt(-1);
        t=-20:r:20;
        %f=sin(t)./t;							%计算采样函数的离散采样点sqrt
        N=500;									%采样点数
        W=5*pi*1;								%设定采样角频率
        k=-N:N;
        w=k*W/N;%对频率采样?
        F1=r*(sinc(t/pi)*exp(-j*t'*w));		%计算采样函数的频谱  y1=sin(t)./t;                                                     
        F2=r*sinc(2*t/pi)*exp(-j*t'*w);      %y2=sin(2*t)./(2*t) =>sinc(2*t/pi);
        plot(w,F1,w,F2,'--');
        axis([-4 4 -1 4]);
        xlabel('w'); 
        ylabel('F(w)');
        legend('F1(w)','F2(w)')
    case 8              %三角脉冲信号
        j=sqrt(-1);
        N=500;
        W=5*pi*1;
        k=-N:N;
        w=k*W/N;
        F1=sinc(0.5*w/pi).^2;
        N1=250;									%采样点数
        W1=5*pi*1;								%设定采样角频率
        w1=k*W1/N1;							    %对频率采样
        F2=sinc(0.5*w1/pi).^2;
        plot(w,F1,w,F2,'--');
        xlabel('w');
        ylabel('F(w)');
        legend('F1(w)','F2(w)')
    case 9
        N=500;									%采样点数
        W=5*pi*1;								%设定采样角频率
        k=-N:N;
        w=k*W/N;								%对频率采样
        F=2*sinc(1*w);
        plot(w,F)
        ylabel('F(w)')
    case 10         %冲击信号
        t=-10:0.0001:10;
        syms t
        y=dirac(t);
        F=fourier(y);
        ezplot(abs(F));
        ylabel('F(w)')
    case 11         %冲击信号
        t=-10:0.0001:10;
        syms t
        y=dirac(t+2)+dirac(t-2);
        F=fourier(y);
        ezplot(abs(F));
        ylabel('F(w)')
    case 12         %直流信号
        t=-1:0.0001:1;
        y=(t==0); 
        y=2*pi*y;
        plot(t,y);
        ylabel('F(w)')
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)


h = gcf;
logsel;
close(h);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
