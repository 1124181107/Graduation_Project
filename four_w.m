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
%popupmenu1�������˵������Ļص���������Ҫ��������˵����еĶ����Լ���������Ӧ��
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(handles.popupmenu1,'Value');
axes(handles.axes1)
switch val
    case 1
    case 2										%���ź���
        t=-1:0.0001:1;
        y=heaviside(t)-heaviside(-t);
        plot(t,y);
        xlabel('t');
        ylabel('y(t)')
        axis([-1 1 -1.5 1.5])
        legend('y=u(t)-u(-t)')
    case 3										%��λ��Ծ�ź�
        t=-1:0.01:5; 
        y=heaviside(t); 
        plot(t,y); 
        xlabel('t')
        ylabel('y(t)')
        axis([-1,3,-0.2,1.5])
        legend('y=u(t)')
    case 4										%����ָ���ź�
        t=-1:0.0001:5;
        y=0.5*exp(-t);
        plot(t,y)
        xlabel('t');
        ylabel('y(t)')
        legend('y=0.5{e}^{2t}')
    case 5										%���������ź�
        t=0:0.0001:6;
        y=cos(4*t).*heaviside(t);
        plot(t,y)
        xlabel('t');
        ylabel('y(t)')
        legend('y=cos(4t)*u(t)')
    case 6										%���������ź�
        t=0:0.0001:6;
        y=cos(2*t).*heaviside(t)+sin(4*t).*heaviside(t);
        plot(t,y)
        xlabel('t');
        ylabel('y(t)')
        legend('y=cos(2t)*u(t)+sin(4t)*u(t)')         
  case 7										%���������ź�
       t=-20:0.01:20;
       y1=sin(t)./t;
       y2=sin(2*t)./(2*t);
       plot(t,y1,t,y2,'--')
       xlabel('t');
       ylabel('y(t)')
       legend('y1=sin(t)./t','y2=sin(2*t)./(2*t)');
        
    case 8										%���������ź�
        t=-4:0.0001:4;
        y1=tripuls(t,4,0.5);
        y2=tripuls(t+2,2,0.5);
        plot(t,y1,t,y2,'--')
        xlabel('t');
        ylabel('y(t)')
        legend('y1=tripuls(t,4,0.5)','y2=tripuls(t+2,2,0.5)')
    case 9										%�ź���
        t=-20:0.0001:20;
        y=heaviside(t+1)-heaviside(t-1);
        plot(t,y)
        xlabel('t');
        ylabel('y(t)')   
        legend('y=u(t+1)-u(t-1)')
 	case 10								    %��λ�弤����
        t=-10:0.0001:10;
        y=(t==0);        			        		%�����жϣ�ֻ��x=0��1��ʱ��y�š�1��
        plot(t,y);
        xlabel('t');
        ylabel('y(t)')  
        legend('y=\delta(t)')
    case 11								    %˫�弤����
        t=-10:0.0001:10;
        y=(t==-2|t==2);        			        		%�����жϣ�ֻ��x=0��1��ʱ��y�š�1��
        plot(t,y);
        xlabel('t');
        ylabel('y(t)')  
        legend('y=\delta(t-2)+\delta(t+2)')
    case 12										%ֱ���ź�
        f='1';
        fplot(f,[0 1])
        xlabel('ʱ�䣨t��');
        ylabel('��ֵ��f��');
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
%pushbutton(��ť)�Ļص���������ذ�ť���¶�������������Ӧ����Ӧ��
function pushbutton1_Callback(hObject, eventdata, handles)

val=get(handles.popupmenu1,'Value');
axes(handles.axes2)
switch val
    case 2          %���ź���
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
    case 4          %����ָ���ź�
        t=-5:0.0001:5;
        syms t
        y=0.5*exp(-t)*sym('heaviside(t)');
        F=fourier(y);
        ezplot(abs(F));
        ylabel('F(w)')
    case 5          %���������ź�
        t=-2:0.0001:2;
        syms t
        y=cos(4*t)*sym('heaviside(t)');
        F=fourier(y);
        ezplot(abs(F));
        axis([-7,7,0,100]);
        ylabel('F(w)');
    case 6          %���������ź�
        t=-5:0.001:5;
        syms t
        val1 = cos(2*t);
        val2 = sin(4*t);
        y=val1*sym('heaviside(t)')+val2*sym('heaviside(t)');
        F=fourier(y);
        ezplot(abs(F));
        axis([-7,7,0,100]);
        ylabel('F(w)');
    case 7              %���������ź�
        syms t
        r=0.01;									%�������
        j=sqrt(-1);
        t=-20:r:20;
        %f=sin(t)./t;							%���������������ɢ������sqrt
        N=500;									%��������
        W=5*pi*1;								%�趨������Ƶ��
        k=-N:N;
        w=k*W/N;%��Ƶ�ʲ���?
        F1=r*(sinc(t/pi)*exp(-j*t'*w));		%�������������Ƶ��  y1=sin(t)./t;                                                     
        F2=r*sinc(2*t/pi)*exp(-j*t'*w);      %y2=sin(2*t)./(2*t) =>sinc(2*t/pi);
        plot(w,F1,w,F2,'--');
        axis([-4 4 -1 4]);
        xlabel('w'); 
        ylabel('F(w)');
        legend('F1(w)','F2(w)')
    case 8              %���������ź�
        j=sqrt(-1);
        N=500;
        W=5*pi*1;
        k=-N:N;
        w=k*W/N;
        F1=sinc(0.5*w/pi).^2;
        N1=250;									%��������
        W1=5*pi*1;								%�趨������Ƶ��
        w1=k*W1/N1;							    %��Ƶ�ʲ���
        F2=sinc(0.5*w1/pi).^2;
        plot(w,F1,w,F2,'--');
        xlabel('w');
        ylabel('F(w)');
        legend('F1(w)','F2(w)')
    case 9
        N=500;									%��������
        W=5*pi*1;								%�趨������Ƶ��
        k=-N:N;
        w=k*W/N;								%��Ƶ�ʲ���
        F=2*sinc(1*w);
        plot(w,F)
        ylabel('F(w)')
    case 10         %����ź�
        t=-10:0.0001:10;
        syms t
        y=dirac(t);
        F=fourier(y);
        ezplot(abs(F));
        ylabel('F(w)')
    case 11         %����ź�
        t=-10:0.0001:10;
        syms t
        y=dirac(t+2)+dirac(t-2);
        F=fourier(y);
        ezplot(abs(F));
        ylabel('F(w)')
    case 12         %ֱ���ź�
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
