function varargout = ercode(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ercode_OpeningFcn, ...
                   'gui_OutputFcn',  @ercode_OutputFcn, ...
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


% --- Executes just before ercode is made visible.
function ercode_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ercode wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ercode_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)

function popupmenu1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
global sig;
global sig_len;
val=get(handles.edit1,'String');
sig_len=length(val);
sig = [];
for i=1:1:sig_len
    num = str2num(val(i));
    if num~=0 && num~=1
        errordlg('请输入数字0或1的数字信号','error');
        return;
    end
    sig=[sig,str2num(val(i))];
    disp(sig);
end


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_back.
function pushbutton_back_Callback(hObject, eventdata, handles)
h = gcf;
logsel;
close(h);


% --- Executes on button press in pushbutton_GO.
function pushbutton_GO_Callback(hObject, eventdata, handles)
global sig;
global sig_len;
rdio_jiou = get(handles.radiobutton_jiou,'Value');
if rdio_jiou == 1
    jiou_code(sig,sig_len,handles);
else
    liner_code(sig,sig_len,handles);
end

function jiou_code(sig,sig_len,handles)
code = 0;
for i=1:1:sig_len
    code = xor(code,sig(i));
end
coded_sig =[sig,code];
disp(coded_sig);
set(handles.text_code_out,'String',num2str(coded_sig));

function liner_code(sig,sig_len,handles)
if mod(sig_len,4)~= 0
    errordlg('请输入数字信号长度为4的倍数','error');
    set(handles.text_code_out,'String','');
    return;
end
loop_t = sig_len/4-1;
for i=0:1:loop_t
    a2 = xor(xor(sig(4*i+1),sig(4*i+2)),sig(4*i+3));
    a1 = xor(xor(sig(4*i+2),sig(4*i+1)),sig(4*i+4));
    a0 = xor(xor(sig(4*i+3),sig(4*i+4)),sig(4*i+1));
    if i==0
        coded_sig=num2str([sig(4*i+1:4*i+4),a2,a1,a0]);
    else
        coded_sig=[[coded_sig],' \ ',num2str([sig(4*i+1:4*i+4),a2,a1,a0])];
    end
end



set(handles.text_code_out,'String',coded_sig);


% --- Executes on button press in radiobutton_jiou.
function radiobutton_jiou_Callback(hObject, eventdata, handles)
set(handles.radiobutton_liner,'Value',0);


% --- Executes on button press in radiobutton_liner.
function radiobutton_liner_Callback(hObject, eventdata, handles)
set(handles.radiobutton_jiou,'Value',0);
