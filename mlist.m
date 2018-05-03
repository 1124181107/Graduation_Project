function varargout = mlist(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mlist_OpeningFcn, ...
                   'gui_OutputFcn',  @mlist_OutputFcn, ...
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


% --- Executes just before mlist is made visible.
function mlist_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mlist (see VARARGIN)

% Choose default command line output for mlist
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mlist wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mlist_OutputFcn(hObject, eventdata, handles) 

set(handles.popupmenu1,'Value',1);
L5_ctr(handles,0);
L6_ctr(handles,0);
L7_ctr(handles,0);
L8_ctr(handles,0);
set(handles.radiobutton_c0,'Value',1);
set(handles.radiobutton_c1,'Value',1);
set(handles.radiobutton_c2,'Value',1);
set(handles.radiobutton_c3,'Value',1);
set(handles.radiobutton_c4,'Value',1);
set(handles.radiobutton_c5,'Value',1);
set(handles.radiobutton_c6,'Value',1);
set(handles.radiobutton_c7,'Value',1);
set(handles.text_c3_a3,'Visible','on');
set(handles.text_c2_a2,'Visible','on');
set(handles.text_c1_a1,'Visible','on');
varargout{1} = handles.output;


function radiobutton_c0_Callback(hObject, eventdata, handles)
val_c0 = get(handles.radiobutton_c0,'Value');
if val_c0 == 1
    set(handles.text_c0_a0,'Visible','on');
else
    set(handles.text_c0_a0,'Visible','off');
end

function radiobutton_c1_Callback(hObject, eventdata, handles)
val_c1 = get(handles.radiobutton_c1,'Value');
if val_c1 == 1
    set(handles.text_c1_a1,'Visible','on');
else
    set(handles.text_c1_a1,'Visible','off');
end

function radiobutton_c2_Callback(hObject, eventdata, handles)
val_c2 = get(handles.radiobutton_c2,'Value');
if val_c2 == 1
    set(handles.text_c2_a2,'Visible','on');
else
    set(handles.text_c2_a2,'Visible','off');
end

function radiobutton_c3_Callback(hObject, eventdata, handles)
val_c3 = get(handles.radiobutton_c3,'Value');
if val_c3 == 1
    set(handles.text_c3_a3,'Visible','on');
else
    set(handles.text_c3_a3,'Visible','off');
end

function radiobutton_c4_Callback(hObject, eventdata, handles)
val_c4 = get(handles.radiobutton_c4,'Value');
if val_c4 == 1
    set(handles.text_c4_a4,'Visible','on');
else
    set(handles.text_c4_a4,'Visible','off');
end

function radiobutton_c5_Callback(hObject, eventdata, handles)
val_c5 = get(handles.radiobutton_c5,'Value');
if val_c5 == 1
    set(handles.text_c5_a5,'Visible','on');
else
    set(handles.text_c5_a5,'Visible','off');
end

function radiobutton_c6_Callback(hObject, eventdata, handles)
val_c6 = get(handles.radiobutton_c6,'Value');
if val_c6 == 1
    set(handles.text_c6_a6,'Visible','on');
else
    set(handles.text_c6_a6,'Visible','off');
end

function radiobutton_c7_Callback(hObject, eventdata, handles)
val_c7 = get(handles.radiobutton_c7,'Value');
if val_c7 == 1
    set(handles.text_c7_a7,'Visible','on');
else
    set(handles.text_c7_a7,'Visible','off');
end

function edit_a0_Callback(hObject, eventdata, handles)




function edit_a0_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a1_Callback(hObject, eventdata, handles)

function edit_a1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a2_Callback(hObject, eventdata, handles)

function edit_a2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a3_Callback(hObject, eventdata, handles)

function edit_a3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a4_Callback(hObject, eventdata, handles)

function edit_a4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a5_Callback(hObject, eventdata, handles)

function edit_a5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a6_Callback(hObject, eventdata, handles)

function edit_a6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a7_Callback(hObject, eventdata, handles)

function edit_a7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
h = gcf;
logsel;
close(h);

function popupmenu1_Callback(hObject, eventdata, handles)
pop_val = get(handles.popupmenu1,'Value');
switch pop_val
    case 1  %4级
        L5_ctr(handles,0);
        L6_ctr(handles,0);
        L7_ctr(handles,0);
        L8_ctr(handles,0);
    case 2  %5级
        L5_ctr(handles,1);
        L6_ctr(handles,0);
        L7_ctr(handles,0);
        L8_ctr(handles,0);
    case 3  %6级
        L5_ctr(handles,1);
        L6_ctr(handles,1);
        L7_ctr(handles,0);
        L8_ctr(handles,0);
    case 4  %7级
        L5_ctr(handles,1);
        L6_ctr(handles,1);
        L7_ctr(handles,1);
        L8_ctr(handles,0);
    case 5  %8级
        L5_ctr(handles,1);
        L6_ctr(handles,1);
        L7_ctr(handles,1);
        L8_ctr(handles,1);
end

function L5_ctr(handles,vis_set)
if vis_set == 1
    set(handles.radiobutton_c4,'Visible','on')
    set(handles.text_c3_c4,'Visible','on')
    set(handles.text_c4_a4,'Visible','on')
    set(handles.edit_a4,'Visible','on')
    set(handles.text_a4_a5,'Visible','on')
else
    set(handles.radiobutton_c4,'Visible','off')
    set(handles.text_c3_c4,'Visible','off')
    set(handles.text_c4_a4,'Visible','off')
    set(handles.edit_a4,'Visible','off')
    set(handles.text_a4_a5,'Visible','off')
end

function L6_ctr(handles,vis_set)
if vis_set == 1
    set(handles.radiobutton_c5,'Visible','on')
    set(handles.text_c4_c5,'Visible','on')
    set(handles.text_c5_a5,'Visible','on')
    set(handles.edit_a5,'Visible','on')
    set(handles.text_a5_a6,'Visible','on')
else
    set(handles.radiobutton_c5,'Visible','off')
    set(handles.text_c4_c5,'Visible','off')
    set(handles.text_c5_a5,'Visible','off')
    set(handles.edit_a5,'Visible','off')
    set(handles.text_a5_a6,'Visible','off')
end

function L7_ctr(handles,vis_set)
if vis_set == 1
    set(handles.radiobutton_c6,'Visible','on')
    set(handles.text_c5_c6,'Visible','on')
    set(handles.text_c6_a6,'Visible','on')
    set(handles.edit_a6,'Visible','on')
    set(handles.text_a6_a7,'Visible','on')
else
    set(handles.radiobutton_c6,'Visible','off')
    set(handles.text_c5_c6,'Visible','off')
    set(handles.text_c6_a6,'Visible','off')
    set(handles.edit_a6,'Visible','off')
    set(handles.text_a6_a7,'Visible','off')
end

function L8_ctr(handles,vis_set)
if vis_set == 1
    set(handles.radiobutton_c7,'Visible','on')
    set(handles.text_c6_c7,'Visible','on')
    set(handles.text_c7_a7,'Visible','on')
    set(handles.edit_a7,'Visible','on')
    set(handles.text_a7_out,'Visible','on')
else
    set(handles.radiobutton_c7,'Visible','off')
    set(handles.text_c6_c7,'Visible','off')
    set(handles.text_c7_a7,'Visible','off')
    set(handles.edit_a7,'Visible','off')
    set(handles.text_a7_out,'Visible','off')
end
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_GO.
function pushbutton_GO_Callback(hObject, eventdata, handles)
val_a=get_a_val(handles);
flag_c=get_c_flag(handles);
m_list_func(val_a,flag_c,handles)
%-------------------------------------------------------------------------------------------GO----


function val_a = get_a_val(handles)
a0=get(handles.edit_a0,'String');
a0=str2num(a0);
a1=get(handles.edit_a1,'String');
a1=str2num(a1);
a2=get(handles.edit_a2,'String');
a2=str2num(a2);
a3=get(handles.edit_a3,'String');
a3=str2num(a3);
a4=get(handles.edit_a4,'String');
a4=str2num(a4);
a5=get(handles.edit_a5,'String');
a5=str2num(a5);
a6=get(handles.edit_a6,'String');
a6=str2num(a6);
a7=get(handles.edit_a7,'String');
a7=str2num(a7);

val_a = [a0,a1,a2,a3,a4,a5,a6,a7];

function flag_c = get_c_flag(handles)
c0=get(handles.radiobutton_c0,'Value');
c1=get(handles.radiobutton_c1,'Value');
c2=get(handles.radiobutton_c2,'Value');
c3=get(handles.radiobutton_c3,'Value');
c4=get(handles.radiobutton_c4,'Value');
c5=get(handles.radiobutton_c5,'Value');
c6=get(handles.radiobutton_c6,'Value');
c7=get(handles.radiobutton_c7,'Value');

flag_c =[c0,c1,c2,c3,c4,c5,c6,c7];

function m_list_func(val_a,flag_c,handles)
pop_val = get(handles.popupmenu1,'Value');
switch pop_val
    case 1
        m_list_loop(val_a,flag_c,handles,4);
    case 2
        m_list_loop(val_a,flag_c,handles,5);
    case 3
        m_list_loop(val_a,flag_c,handles,6);
    case 4
        m_list_loop(val_a,flag_c,handles,7);
    case 5
        m_list_loop(val_a,flag_c,handles,8);
end
     

function m_list_loop(val_a,flag_c,handles,vtr)

for i=vtr:-1:2
    if i==vtr
        val_out = val_a(i)
        val_a0 = val_a(i)
        val_a(i)=val_a(i-1)
    else
        if flag_c(i) == 1 
            val_a0 = xor(val_a(i),val_a0);
            val_a(i) = val_a(i-1);
        else
            val_a(i) = val_a(i-1);
        end
    end
end
if flag_c(1)==1
    val_a0 = xor(val_a(1),val_a0);
end
val_a(1)= val_a0;

set(handles.text_print_out,'String',val_out);
set(handles.edit_a0,'String',val_a(1))
set(handles.edit_a1,'String',val_a(2))
set(handles.edit_a2,'String',val_a(3))
set(handles.edit_a3,'String',val_a(4))
if vtr >= 5
    set(handles.edit_a4,'String',val_a(5));
    if vtr >= 6
        set(handles.edit_a5,'String',val_a(6));
        if vtr >= 7
            set(handles.edit_a6,'String',val_a(7));
            if vtr >= 8
                  set(handles.edit_a7,'String',val_a(8));
            end
        end
    end    
end
%disp(val_a)
%disp(flag_c)
