function varargout = db_code(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @db_code_OpeningFcn, ...
                   'gui_OutputFcn',  @db_code_OutputFcn, ...
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


% --- Executes just before db_code is made visible.
function db_code_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to db_code (see VARARGIN)

% Choose default command line output for db_code
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes db_code wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = db_code_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_back.
function pushbutton_back_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
logsel;
close(h);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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



function edit2_Callback(hObject, eventdata, handles)
val=get(handles.edit2,'String');
dig_len=length(val);

global sig; 
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
print_digsig(sig,0,0)
axis([0 dig_len -1 1]);

%rz    0=不归零 1=归零
%polar 0=单极性 1=双极性
function print_digsig(sig,polar,rz)
sig_len=length(sig);
global slider_val;
x=0:slider_val:sig_len
if polar == 0
    y=0;
else
    y=-1;
    if rz == 1
        y=-1+heaviside(0.5)
    end
end
for i=1:1:sig_len
    if sig(i) == 1
        if polar == 0
            if rz == 0
                y=y+(heaviside(x-i+1)-heaviside(x-i))
            else
                y=y+(heaviside(x-i+1)-heaviside(x-i+0.5))
            end
        else
            if rz == 0
                y=y+2*(heaviside(x-i+1)-heaviside(x-i))
            else
                y=y+(heaviside(x-i+1)-heaviside(x-i+0.5))
            end
        end 
    else
        if polar ==1 && rz ==1
            y=y-(heaviside(x-i+1)-heaviside(x-i+0.5))
        end
    end
end

plot(x,y)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
pop_val = get(handles.popupmenu1,'Value')
axes(handles.axes2)
global sig;
global slider_val;
sig_len=length(sig);
switch pop_val
    case 1 %单极性不归零
        print_digsig(sig,0,0)
        axis([0 sig_len -1 1]);
    case 2 %双极性不归零
        print_digsig(sig,1,0)
        axis([0 sig_len -1 1]);
    case 3 %单极性归零
        print_digsig(sig,0,1)
        axis([0 sig_len -1 1]);
    case 4 %双极性归零
        print_digsig(sig,1,1)
        axis([0 sig_len -1 1]);
    case 5 %差分码
        y=1;
        x=0:slider_val:sig_len
        ifdoub = 0;
        for i=1:1:sig_len
            if sig(i) == 1
                if ifdoub == 0
                    y = y-2*heaviside(x-i+1);
                    ifdoub = 1; 
                else
                    y = y+2*heaviside(x-i+1);
                    ifdoub = 0;
                end
            end
        end
        plot(x,y)
        axis([0 sig_len -1 1]);
    case 6 %交替极性码
        y=0;
        x=0:slider_val:sig_len
        ifdoub = 0;
        for i=1:1:sig_len
            if sig(i) == 1
                if ifdoub == 0
                    y = y+(heaviside(x-i+1)-heaviside(x-i));
                    ifdoub = 1; 
                else
                    y = y-(heaviside(x-i+1)-heaviside(x-i));
                    ifdoub = 0;
                end
            end
        end
        plot(x,y)
        axis([0 sig_len -1 1]);
    case 7 %HDB3码
        y=0;
        x=0:slider_val:sig_len
        B_ifdoub = 0;
        V_ifdoub = 0;
        global flag_check;
        if sig_len <=3
            for i=1:1:sig_len
                if sig(i) == 1
                    if B_ifdoub == 0
                        y = y+(heaviside(x-i+1)-heaviside(x-i));
                        B_ifdoub = 1; 
                    else
                        y = y-(heaviside(x-i+1)-heaviside(x-i));
                        B_ifdoub = 0;
                    end
                end
            end %for
        else
            for i=1:1:3
                flag_check(i) = 0;
                if sig(i) == 1
                    if B_ifdoub == 0
                        y = y+(heaviside(x-i+1)-heaviside(x-i));
                        B_ifdoub = 1; 
                    else
                        y = y-(heaviside(x-i+1)-heaviside(x-i));
                        B_ifdoub = 0;
                    end
                end
            end %for
            for i=4:1:sig_len
                flag_check(i) = 0;
                if sig(i) == 1
                    if B_ifdoub == 0
                        y = y+(heaviside(x-i+1)-heaviside(x-i));
                        B_ifdoub = 1; 
                    else
                        y = y-(heaviside(x-i+1)-heaviside(x-i));
                        B_ifdoub = 0;
                    end
                else
                    rt = check4zero(sig,i);
                    if rt == 1
                        if V_ifdoub == B_ifdoub
                            if V_ifdoub == 0
                                y = y+(heaviside(x-i+1+3)-heaviside(x-i+3));
                                B_ifdoub = 1;
                            else
                                y = y-(heaviside(x-i+1+3)-heaviside(x-i+3));
                                B_ifdoub = 0;
                            end
                        end %V_ifdoub ~= B_ifdoub
                        if V_ifdoub == 0
                            y = y+(heaviside(x-i+1)-heaviside(x-i));
                            V_ifdoub = 1;
                        else
                            y = y-(heaviside(x-i+1)-heaviside(x-i));
                            V_ifdoub = 0
                        end
                    end
                end
            end %for
        end
           
        plot(x,y)
        axis([0 sig_len -1 1]);
end



function rt = check4zero(sig,i)
global flag_check
disp(flag_check);
if flag_check(i-1)==0 &&flag_check(i-2)==0 &&flag_check(i-3)==0
    if sig(i)==0 &&sig(i-1)==0 &&sig(i-2)==0 &&sig(i-3)==0 
        flag_check(i)=1;
        rt=1;
    else
        flag_check(i)=0;
        rt=0;
    end
else
    flag_check(i)=0;
    rt=0;
end
    


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global slider_val
slider = get(handles.slider1,'Value');
slider_val = (round(slider/0.01))*0.01;
strshow = ['当前精度为：',num2str(slider_val)];
set(handles.text4,'String',strshow);

set(handles.edit2,'String','');
global sig;
sig = 0;
cla(handles.edit2,'reset');
cla(handles.axes1,'reset');
cla(handles.axes2,'reset');


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
