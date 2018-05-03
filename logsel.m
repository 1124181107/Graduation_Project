function varargout = logsel(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @logsel_OpeningFcn, ...
                   'gui_OutputFcn',  @logsel_OutputFcn, ...
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


% --- Executes just before logsel is made visible.
function logsel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to logsel (see VARARGIN)

% Choose default command line output for logsel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes logsel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = logsel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ha=axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'down')
II=imread('backgroud2.jpg');  
image(II)  
colormap gray  
set(ha,'handlevisibility','off','visible','off'); 
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in bt_exit.
function bt_exit_Callback(hObject, eventdata, handles)

close(gcf); 
% hObject    handle to bt_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bt_back.
function bt_back_Callback(hObject, eventdata, handles)

h = gcf;
logface;
close(h);

% hObject    handle to bt_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in four_w.
function four_w_Callback(hObject, eventdata, handles)

h = gcf;
four_w;
close(h);
% hObject    handle to four_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bt_four_p.
function bt_four_p_Callback(hObject, eventdata, handles)
% hObject    handle to bt_four_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
four_p;
close(h)




% --- Executes on button press in bt_ratio.
function bt_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to bt_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
distribute;
close(h)


% --- Executes on button press in bt_analog_sig.
function bt_analog_sig_Callback(hObject, eventdata, handles)
% hObject    handle to bt_analog_sig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
analog_sig;
close(h)


% --- Executes on button press in bt_anatodig.
function bt_anatodig_Callback(hObject, eventdata, handles)
% hObject    handle to bt_anatodig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
anatolog;
close(h)

% --- Executes on button press in bt_bbcode.
function bt_bbcode_Callback(hObject, eventdata, handles)
% hObject    handle to bt_bbcode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
db_code;
close(h)


% --- Executes on button press in bt_digmod.
function bt_digmod_Callback(hObject, eventdata, handles)
% hObject    handle to bt_digmod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
digmod;
close(h)



% --- Executes on button press in bt_mlist.
function bt_mlist_Callback(hObject, eventdata, handles)
% hObject    handle to bt_mlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
mlist;
close(h)


% --- Executes on button press in bt_ercode.
function bt_ercode_Callback(hObject, eventdata, handles)
% hObject    handle to bt_ercode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = gcf;
ercode;
close(h)
