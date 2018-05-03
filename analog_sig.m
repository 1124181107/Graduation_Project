function varargout = analog_sig(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @analog_sig_OpeningFcn, ...
                   'gui_OutputFcn',  @analog_sig_OutputFcn, ...
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


% --- Executes just before analog_sig is made visible.
function analog_sig_OpeningFcn(hObject, eventdata, handles, varargin)

set(handles.text6,'Visible','off');
set(handles.edit1,'Visible','off');

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes analog_sig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = analog_sig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
axes(handles.axes1)
t=0:0.02:6.*pi;
plot(t,sin(t));
varargout{1} = handles.output;


% --- Executes on button press in bt_back.
function bt_back_Callback(hObject, eventdata, handles)
% hObject    handle to bt_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
logsel;
close(h);

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
val = get(handles.popupmenu1,'Value');
sel = get(handles.popupmenu2,'Value');
slider_val = get(handles.slider1,'Value');
edit_val = get(handles.edit1,'String');
edit_val = str2num(edit_val);
t = 0:0.001:6.*pi;
switch val
    case 1 %正弦函数
        A = sin(slider_val*pi.*t);
    case 2 %三角波函数
        A=sawtooth(pi*slider_val*t,0.5);
    case 3 %方波函数
        A=square(pi*slider_val*t);
end
axes(handles.axes3);
switch sel
    case 1 %AM
        f = sin(t);
        F = (f+2).*A;
        plot(t,F);
        legend('调幅信号:（2+sin(t)）*调制信号（t）')
    case 2 %SSB
        f = sin(t);
        F = (f).*A;
        plot(t,F);
        legend('调幅信号:sin(t)*调制信号（t）')
    case 3 %FM
        f = -cos(t);
        switch val
            case 1 %正弦函数
                A = sin(slider_val*pi.*t+edit_val.*f);
                plot(t,A);
            case 2 %三角波函数
                A=sawtooth(pi*slider_val*t+edit_val.*f,0.5);
                plot(t,A);
            case 3 %方波函数
                A=square(pi*slider_val*t+edit_val.*f);
                plot(t,A);
        end
    case 4 %PM
        f = sin(t);
        switch val
            case 1 %正弦函数
                A = sin(slider_val*pi.*t+edit_val.*f);
                plot(t,A);
            case 2 %三角波函数
                A=sawtooth(pi*slider_val*t+edit_val.*f,0.5);
                plot(t,A);
            case 3 %方波函数
                A=square(pi*slider_val*t+edit_val.*f);
                plot(t,A);
        end
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
sel = get(handles.popupmenu2,'Value');
switch sel
    case 1
        set_frame(handles,0);
    case 2
        set_frame(handles,0);
    case 3
        set_frame(handles,1);
    case 4
        set_frame(handles,1);
end

function set_frame(handles,flag)
if flag ==0
    set(handles.text6,'Visible','off');
    set(handles.edit1,'Visible','off');
elseif flag == 1
    set(handles.text6,'Visible','on');
    set(handles.edit1,'Visible','on');
end
    


function popupmenu2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
val=get(handles.popupmenu1,'Value');
slider_val = get(handles.slider1,'Value');
axes(handles.axes2);
t = 0:0.001:6.*pi;
switch val
    case 1 %正弦函数
        plot(t,sin(slider_val*pi*t));
    case 2 %三角波函数
        y=sawtooth(pi*slider_val*t,0.5);
        plot(t,y);
    case 3 %方波函数
        y=square(pi*slider_val*t);
        plot(t,y)
end


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
slider_val = get(handles.slider1,'Value');
ang = int32(slider_val);  
set(handles.slider1,'Value',ang);
slider_val = get(handles.slider1,'Value');

val=get(handles.popupmenu1,'Value');
axes(handles.axes2);
t = 0:0.001:6.*pi;
switch val
    case 1 %正弦函数
        plot(t,sin(slider_val*pi*t));
    case 2 %三角波函数
        y=sawtooth(pi*slider_val*t,0.5);
        plot(t,y);
    case 3 %方波函数
        y=square(pi*slider_val*t);
        plot(t,y)
end


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
