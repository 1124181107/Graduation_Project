function varargout = digmod(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @digmod_OpeningFcn, ...
                   'gui_OutputFcn',  @digmod_OutputFcn, ...
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


% --- Executes just before digmod is made visible.
function digmod_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to digmod (see VARARGIN)

% Choose default command line output for digmod
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes digmod wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = digmod_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel_init(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
global sig; 
global dig_len;
val=get(handles.edit2,'String');
dig_len=length(val);
sig = [];
for i=1:1:dig_len
    num = str2num(val(i:i));
    if num~=0 && num~=1
        errordlg('请输入数字0或1的数字信号','error');
        return;
    end
    sig=[sig,str2num(val(i:i))];
    disp(sig);
end

axes(handles.axes1)
print_digsig(sig)
axis([0 dig_len 0 1]);

function print_digsig(sig)
sig_len=length(sig);
y=0;
x=0:0.02:sig_len
for i=1:1:sig_len
    if sig(i) == 1
         y=y+(heaviside(x-i+1)-heaviside(x-i))
    end
end
plot(x,y);
    
    
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global sig; 
global dig_len;
sig = 0;
dig_len =0;
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
pop1_val = get(handles.popupmenu1,'Value')
switch pop1_val
    case 1 %调幅
        sel_init(hObject, eventdata, handles)
    case 2 %调频
        sel_init(hObject, eventdata, handles)
        show_FSK(hObject, eventdata, handles)
    case 3 %调相
        sel_init(hObject, eventdata, handles)
end
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function [A t]=get_carsig(hObject, eventdata, handles)
global dig_len;
global sliderValue;
pop2_val = get(handles.popupmenu2,'Value');
t = 0:0.001:dig_len;
switch pop2_val
    case 1 %正弦波
         A = sin(15*sliderValue*t);
    case 2 %方波
         A=square(sliderValue*pi*5*t);
    case 3 %三角波
         A=sawtooth(pi*5*t*sliderValue,0.5);
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
[A t] = get_carsig(hObject, eventdata, handles);
axes(handles.axes2);
plot(t,A);
% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global sliderValue;
sliderValue = get(handles.slider1,'Value');  
ang = int32(sliderValue);  
set(handles.slider1,'Value',ang);  
sliderValue = get(handles.slider1,'Value');
set(handles.edit3,'String',sliderValue)

[A t] = get_carsig(hObject, eventdata, handles);
axes(handles.axes2);
plot(t,A);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global sig;
global dig_len;
pop1_val = get(handles.popupmenu1,'Value')
[A t] = get_carsig(hObject, eventdata, handles);
axes(handles.axes3);
switch pop1_val
    case 1 %调幅
        sel_init(hObject, eventdata, handles)
        print_ASK(A,sig,dig_len);
    case 2 %调频
        sel_init(hObject, eventdata, handles)
        show_FSK(hObject, eventdata, handles)
        print_FSK(sig,dig_len,handles);
    case 3 %调相
        sel_init(hObject, eventdata, handles)
        print_PSK(sig,dig_len,handles);
end

function sel_init(hObject, eventdata, handles)
set(handles.edit4,'visible','off')
set(handles.text7,'visible','off')
set(handles.text8,'visible','off')
set(handles.slider2,'visible','off')


function print_ASK(A,sig,dig_len)
y=0;
t = 0:0.001:dig_len;
for i=1:1:dig_len
    if sig(i) == 1
        y=y+(heaviside(t-i+1)-heaviside(t-i)).*A;
    end
end
plot(t,y)

function show_FSK(hObject, eventdata, handles)
set(handles.edit4,'visible','on')
set(handles.text7,'visible','on')
set(handles.text8,'visible','on')
set(handles.slider2,'visible','on')

function print_FSK(sig,dig_len,handles)
global sliderValue;
global sliderValue2;
pop2_val = get(handles.popupmenu2,'Value');
t = 0:0.001:dig_len;
y=0
switch pop2_val
    case 1 %正弦波
         A1 = sin(15*sliderValue*t);
         A2 = sin(15*sliderValue2*t);
    case 2 %方波
         A1=square(sliderValue*pi*5*t);
         A2=square(sliderValue2*pi*5*t);
    case 3 %三角波
         A1=sawtooth(pi*5*t*sliderValue,0.5);
         A2=sawtooth(pi*5*t*sliderValue2,0.5);
end
for i=1:1:dig_len
    if sig(i) == 1
        y=y+(heaviside(t-i+1)-heaviside(t-i)).*A1;
    else
        y=y+(heaviside(t-i+1)-heaviside(t-i)).*A2;
    end
end
plot(t,y)

function print_PSK(sig,dig_len,handles)
global sliderValue;
pop2_val = get(handles.popupmenu2,'Value');
t = 0:0.001:dig_len;
y=0;
switch pop2_val
    case 1 %正弦波
         A1 = sin(15*sliderValue*t);
         A2 = sin(15*sliderValue*t+pi);
    case 2 %方波
         A1=square(sliderValue*pi*5*t);
         A2=square(sliderValue*pi*5*t+pi);
    case 3 %三角波
         A1=sawtooth(pi*5*t*sliderValue,0.5);
         A2=sawtooth(pi*5*t*sliderValue+pi,0.5);
end
for i=1:1:dig_len
    if sig(i) == 1
        y=y+(heaviside(t-i+1)-heaviside(t-i)).*A1;
    else
        y=y+(heaviside(t-i+1)-heaviside(t-i)).*A2;
    end
end
plot(t,y)

% --- Executes on button press in pushbutton_back.
function pushbutton_back_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
logsel;
close(h);



function edit3_Callback(hObject, eventdata, handles)
global sliderValue;
edit3_val = get(handles.edit3,'String');
sliderValue = str2double(edit3_val);
disp(sliderValue)

[A t] = get_carsig(hObject, eventdata, handles);
axes(handles.axes2);
plot(t,A);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
global sliderValue2;
sliderValue2 = get(handles.slider2,'Value');  
ang = int32(sliderValue2);  
set(handles.slider2,'Value',ang);  
sliderValue2 = get(handles.slider2,'Value');
set(handles.edit4,'String',sliderValue2)



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit4_Callback(hObject, eventdata, handles)
global sliderValue2;
edit4_val = get(handles.edit4,'String');
sliderValue2 = str2double(edit4_val);
disp(sliderValue2)

function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
