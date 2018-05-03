function varargout = anatolog(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anatolog_OpeningFcn, ...
                   'gui_OutputFcn',  @anatolog_OutputFcn, ...
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


% --- Executes just before anatolog is made visible.
function anatolog_OpeningFcn(hObject, eventdata, handles, varargin)

set(handles.axes_code,'Visible','off');
    set(handles.text_delta,'Visible','off');
    set(handles.edit_delta,'Visible','off');
    set(handles.edit_dp,'Visible','on');
    set(handles.edit_fz,'Visible','on');
    set(handles.text3,'Visible','on');
    set(handles.text6,'Visible','on');
% Choose default command line output for anatolog
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

function varargout = anatolog_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;



function edit_in_sig_Callback(hObject, eventdata, handles)

function edit_in_sig_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
list_val = get(handles.listbox1,'Value');
if list_val == 1
    set(handles.axes_code,'Visible','off');
    set(handles.text_delta,'Visible','off');
    set(handles.edit_delta,'Visible','off');
    set(handles.edit_dp,'Visible','on');
    set(handles.edit_fz,'Visible','on');
    set(handles.text3,'Visible','on');
    set(handles.text6,'Visible','on');
elseif list_val == 2
    set(handles.axes_code,'Visible','on');
    set(handles.edit_dp,'Visible','off');
    
    set(handles.text3,'Visible','off');
    
    set(handles.text_delta,'Visible','on');
    set(handles.edit_delta,'Visible','on');
end

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bt_quanti_Callback(hObject, eventdata, handles)
n_val = get(handles.edit_dp,'String');          %量化电平
n_val = str2num(n_val); 
n_bits = get(handles.edit_fz,'String');         %量化频率
n_bits =str2num(n_bits);

list_val = get(handles.listbox1,'Value')
if list_val == 1
    aver_func(handles,n_val,n_bits);
elseif list_val == 2
    deltaM_func(handles,n_val,n_bits);
end

function aver_func(handles,n_val,n_bits)
t = 0:0.01:2.*pi
slider2_val = get(handles.slider2,'Value');
slider1_val = get(handles.slider1,'Value');
f = slider2_val.*sin(slider1_val.*t)
MAX_VAL = max(slider2_val.*sin(slider1_val.*t));       %最大值
MIN_VAL = min(slider2_val.*sin(slider1_val.*t));    %最小值

count = MAX_VAL - MIN_VAL;
step_high = count/2^n_val;  %阶梯高度

for i=1:1:2^n_val+1
   step_val(i) = MIN_VAL+  (i-1).*step_high
end

F(1:2.*pi*100)=0
for i=1:fix(100/n_bits):2.*pi*100
    for j=1:1:2^n_val-1
        if f(i) >= step_val(j) && f(i) <= step_val(j+1)
            F(i)= (step_val(j)+step_val(j+1))/2
        elseif f(i)>= step_val(2^n_val)
            F(i)= (step_val(2^n_val)+step_val(2^n_val+1))/2;
        end
    end
end

for i=1:1:2.*pi*100
    if i>=2 && F(i) == 0
        F(i) = F(i-1);
    end
end

axes(handles.axes_quanti);
plot(F);

function deltaM_func(handles,n_val,n_bits)
t = 0:0.01:2.*pi
slider2_val = get(handles.slider2,'Value');
slider1_val = get(handles.slider1,'Value');
f = slider2_val.*sin(slider1_val.*t);
delta = get(handles.edit_delta,'String');
delta = str2num(delta);

F(1:2.*pi*100)=0;
F_old = 0;
F_code(1:2.*pi*100) = 0;
for i=2:fix(100/n_bits):2.*pi*100
    if f(i) >= f(i-1)
        F(i)= F_old+delta;
        F_code(i:i+fix(100/n_bits)-1) = 1;
    elseif f(i) < f(i-1) 
        F(i)= F_old-delta;
        F_code(i:i+fix(100/n_bits)-1) = 0;
    end
    F_old = F(i);
end

for i=1:1:2.*pi*100
    if i>=2 && F(i) == 0 && F(i-1) ~= 0
        F(i) = F(i-1);
    end
end

axes(handles.axes_quanti);
plot(F);
axes(handles.axes_code);
plot(F_code);


function bt_code_Callback(hObject, eventdata, handles)

function edit_dp_Callback(hObject, eventdata, handles)
val= get(handles.edit_dp,'String');
val = str2num(val);
if val >=6
    warndlg('数字过大，电脑可能需较长时间处理','warning');
end


% --- Executes during object creation, after setting all properties.
function edit_dp_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit_fz_Callback(hObject, eventdata, handles)
val= get(handles.edit_fz,'String');
val = str2num(val);
if val <1 || val> 100
    errordlg('请输入1到100的数字','error');
end



function edit_fz_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_back_Callback(hObject, eventdata, handles)

h = gcf;
logsel;
close(h);


function slider1_Callback(hObject, eventdata, handles)
slider2_val = get(handles.slider2,'Value');
slider_val = get(handles.slider1,'Value');
ang = int32(slider_val);  
set(handles.slider1,'Value',ang);
slider_val = get(handles.slider1,'Value');
set(handles.text_slider,'String',num2str(slider_val))
axes(handles.axes1)
t=0:0.01:2.*pi
f = slider2_val.*sin(slider_val.*t)
plot(t,f);



function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider2_Callback(hObject, eventdata, handles)
slider_val = get(handles.slider1,'Value');
slider2_val = get(handles.slider2,'Value');
ang = int32(slider2_val);  
set(handles.slider2,'Value',ang);
slider2_val = get(handles.slider2,'Value');
set(handles.text_slider2,'String',num2str(slider2_val))
axes(handles.axes1)
t=0:0.01:2.*pi
f = slider2_val.*sin(slider_val.*t)
plot(t,f);

function slider2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_delta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_delta as text
%        str2double(get(hObject,'String')) returns contents of edit_delta as a double


% --- Executes during object creation, after setting all properties.
function edit_delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
