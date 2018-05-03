function varargout = four_p(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @four_p_OpeningFcn, ...
                   'gui_OutputFcn',  @four_p_OutputFcn, ...
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

function init_sel(hObject, eventdata, handles)
    set(handles.listbox_func1,'visible','off');
    set(handles.listbox_func2,'visible','off');
    set(handles.text1,'visible','off');
    set(handles.text2,'visible','off');
    set(handles.edit1,'visible','off');
    set(handles.edit2,'visible','off');
    set(handles.text_val_1,'visible','off');
    set(handles.text_val_2,'visible','off');
    
    set(handles.edit1,'String','');
    set(handles.edit2,'String','');
    set(handles.text_val_1,'String','����1');
    set(handles.text_val_2,'String','����2');
    set(handles.text1,'String','�ź�1');
    set(handles.text2,'String','�ź�2');

function four_p_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
init_sel(hObject, eventdata, handles);
axes(handles.axes1)
title('ʱ��');
axes(handles.axes2)
title('Ƶ��');
guidata(hObject, handles);


function varargout = four_p_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function bt_exe_Callback(hObject, eventdata, handles)
global val;

if val == 0
    errordlg('��ѡ����','error');
end

switch val
    case 1 %���Ե�������
        liner_func(handles);
    case 2 %�Գ�����
        minor_func(handles);
    case 3 %ʱ������
        time_shift_func(handles);
    case 4 %Ƶ������
        freq_shift_func(handles);
    case 5 %��������
        modu_func(handles);
    case 6 %ʱ����
        time_cond_func(handles);
    case 7 %Ƶ����
        freq_cond_func(handles);
end

%--------------------------------------------------------------------------------------------------���Ե��Ӻ���
function liner_func(handles)
sig_val1 = get(handles.listbox_func1,'Value');
sig_val2 = get(handles.listbox_func2,'Value');
var1 = get(handles.edit1,'String');
V1 = str2num(var1)
var2 = get(handles.edit2,'String');
V2 = str2num(var2)

Fs = 256                %����Ƶ��
T = 1/256             %����ʱ��
L=2048;					%�źų���
t=(0:L-1)*T
switch sig_val1
    case 1
        sig1 = sin(t);
    case 2
        sig1 = cos(t);
    case 3
        sig1 = heaviside(t+1)-heaviside(t-1);
    case 4
        sig1 = 1+0*t;
    case 5
        sig1 = (t == 0);  
end
switch sig_val2
    case 1
        sig2 = sin(t);
    case 2
        sig2 = cos(t);
    case 3
        sig2 = heaviside(t+1)-heaviside(t-1);
    case 4
        sig2 = 1+0*t;
    case 5
        sig2 = (t == 0);  
end

N = 2^nextpow2(L); %������������������Խ�󣬷ֱ��Ƶ��Խ��ȷ��N>=L�������Ĳ����źŲ�Ϊ0
F1 = fft(sig1,N)/N*2
F2 = fft(sig2,N)/N*2
f = Fs/N*(0:1:N-1); %Ƶ��
A1 = abs(V1.*F1);     %��ֵ
A2 = abs(V2.*F2);     %��ֵ
A_liner = A1+A2
P1 = angle(F1);   %��ֵ
axes(handles.axes2);
plot(f(1:N/2),A1(1:N/2),'.-g',f(1:N/2),A2(1:N/2),'.-r',f(1:N/2),A_liner(1:N/2),'*-')
legend('�ź�1Ƶ��','�ź�2Ƶ��','���Ե��Ӻ��ź�')
xlim([0 5]);

%--------------------------------------------------------------------------------------------------�Գ����ʺ���
function minor_func(handles)
sig_val1 = get(handles.listbox_func1,'Value');
sig_val2 = get(handles.listbox_func2,'Value');

Fs = 128                %����Ƶ��
T = 1/128               %����ʱ��
L=1024;					%�źų���
t=(0:L-1)*T
switch sig_val1
    case 1
        sig1 = sin(t);
    case 2
        sig1 = cos(t);
    case 3
        sig1 = heaviside(t+1)-heaviside(t-1);
    case 4
        sig1 = 1+0*t;
    case 5
        sig1 = (t == 0);  
end

N = 2^nextpow2(L); %������������������Խ�󣬷ֱ��Ƶ��Խ��ȷ��N>=L�������Ĳ����źŲ�Ϊ0
F1 = fft(sig1,N)/N*2
f = Fs/N*(0:1:N-1); %Ƶ��
A1 = abs(F1);     %��ֵ
if sig_val2 == 1
    axes(handles.axes2);
    plot(f(1:N/2),A1(1:N/2),'.-r');
    legend('Ƶ���ź�');
elseif sig_val2 == 2
    axes(handles.axes1);
    plot(f(1:N/2),2.*pi.*A1(1:N/2),'.-r');
    legend('ʱ���ź�');
else
    errordlg('ѡ���ź�������','error');
    return;
end

%--------------------------------------------------------------------------------------------------ʱ�����ʺ���
function time_shift_func(handles)
sig_val1 = get(handles.listbox_func1,'Value');
sig_ts = 0;
ts_val  = get(handles.edit1,'String');
ts_val = str2num(ts_val);

Fs = 128                %����Ƶ��
T = 1/128               %����ʱ��
L=2048;					%�źų���
t=(0:L-1)*T
switch sig_val1
    case 1
        sig1 = sin(t);
        sig_ts = sin(t-ts_val);
    case 2
        sig1 = heaviside(t+1)-heaviside(t-1);
        sig_ts = heaviside(t+1-ts_val)-heaviside(t-1-ts_val);
    case 3
        sig1 = 1+0*t;
        sig_ts = 1+0*(t-ts_val);
    case 4
        sig1 = (t == 0);
        sig_ts = (t == 0-ts_val);
end

N = 2^nextpow2(L); %������������������Խ�󣬷ֱ��Ƶ��Խ��ȷ��N>=L�������Ĳ����źŲ�Ϊ0
F1 = fft(sig1,N)/N*2
F2 = fft(sig_ts,N)/N*2
f = Fs/N*(0:1:N-1); %Ƶ��
A1 = abs(F1);     %��ֵ
A2 = abs(F2);
axes(handles.axes2);
plot(f(1:N/2),A1(1:N/2),'.-r',f(1:N/2),A2(1:N/2),'.-b');
legend('ԭ�ź�Ƶ��','ʱ���ź�Ƶ��')
xlim([0,5])

%--------------------------------------------------------------------------------------------------Ƶ�����ʺ���
function freq_shift_func(handles)
sig_val1 = get(handles.listbox_func1,'Value');
sig_ts = 0;
fs_val  = get(handles.edit1,'String');
fs_val = str2num(fs_val);

Fs = 256                %����Ƶ��
T = 1/256              %����ʱ��
L=1024;					%�źų���
t=(0:L-1)*T
j=sqrt(-1);
switch sig_val1
    case 1
        sig1 = sin(t);
        sig_fs = sin(t).*cos(2*pi*fs_val*t);
    case 2
        sig1 = heaviside(t+1)-heaviside(t-1);
        sig_fs = (heaviside(t+1)-heaviside(t-1)).*cos(2*pi*fs_val*t);
    case 3
        sig1 = 1+0*t;
        sig_fs = (1+0*t).*cos(2*pi*fs_val*t);
    case 4
        sig1 = (t == 0);
        sig_fs = (t == 0).*cos(2*pi*fs_val*t);
end

N = 2^nextpow2(L); %������������������Խ�󣬷ֱ��Ƶ��Խ��ȷ��N>=L�������Ĳ����źŲ�Ϊ0
F1 = fft(sig1,N)/N*2
F2 = fft(sig_fs,N)/N*2
f = Fs/N*(0:1:N-1); %Ƶ��
A1 = abs(F1);     %��ֵ
A2 = abs(F2);
axes(handles.axes2);
plot(f(1:N/2),A1(1:N/2),'.-r',f(1:N/2),A2(1:N/2),'.-b');
legend('ԭ�ź�Ƶ��','ʱ���ź�Ƶ��')
%xlim([0,5])
%--------------------------------------------------------------------------------------------------�������ʺ���
function modu_func(handles)
sig_val1 = get(handles.listbox_func1,'Value');
sig_val2 = get(handles.listbox_func2,'Value');

Fs = 512                %����Ƶ��
T = 1/512               %����ʱ��
L=2048;					%�źų���
t=(0:L-1)*T
j=sqrt(-1);
switch sig_val1
    case 1
        sig1 = sin(t);
    case 2
        sig1 = cos(t);
    case 3
        sig1 = heaviside(t+1)-heaviside(t-1);
    case 4
        sig1 = 1+0*t;
    case 5
        sig1 = (t == 0);  
end
switch sig_val2
    case 1
        sig2 = sin(2*10.*pi.*t)
    case 2
        sig2 = cos(2*5.*pi.*t)
end

sig_mod = sig1.*sig2;

N = 2^nextpow2(L); %������������������Խ�󣬷ֱ��Ƶ��Խ��ȷ��N>=L�������Ĳ����źŲ�Ϊ0
F1 = fft(sig1,N)/N*2
F2 = fft(sig_mod,N)/N*2
f = Fs/N*(0:1:N-1); %Ƶ��
A1 = abs(F1);     %��ֵ
A2 = abs(F2);
axes(handles.axes2);
plot(f(1:N/2),A1(1:N/2),'.-r',f(1:N/2),A2(1:N/2),'.-b');
legend('ԭ�ź�Ƶ��','ʱ���ź�Ƶ��')
xlim([0,12])

%--------------------------------------------------------------------------------------------------ʱ�������ʺ���
function time_cond_func(handles)
sig_val1 = get(handles.listbox_func1,'Value');
sig_val2 = get(handles.listbox_func2,'Value');
Fs = 512                %����Ƶ��
T = 1/512               %����ʱ��
L=2048;					%�źų���
t=(0:L-1)*T
j=sqrt(-1);
switch sig_val1
    case 1
        sig1 = sin(t);
    case 2
        sig1 = cos(t);
    case 3
        sig1 = heaviside(t+1)-heaviside(t-1);
    case 4
        sig1 = 1+0*t;
end
switch sig_val2
    case 1
        sig2 = sin(t);
    case 2
        sig2 = cos(t);
    case 3
        sig2 = heaviside(t+1)-heaviside(t-1);
    case 4
        sig2 = 1+0*t;
end
N = 2^nextpow2(L); %������������������Խ�󣬷ֱ��Ƶ��Խ��ȷ��N>=L�������Ĳ����źŲ�Ϊ0
F1 = fft(sig1,N)/N*2
F2 = fft(sig2,N)/N*2
F_conv1 =fft(conv(sig2,sig1),N+(N-1))/(N+N-1)*2/666
f = Fs/N*(0:1:N-1); %Ƶ��
A1 = abs(F_conv1);     %��ֵ
A2 = abs(F1.*F2);
axes(handles.axes2);
plot(f(1:N/2),A1(1:N/2),'.-r',f(1:N/2),A2(1:N/2),'.-b');
legend('�������Ҷ�任','����Ҷ�任�����')
xlim([0,12])

%--------------------------------------------------------------------------------------------------Ƶ�������ʺ���
function freq_cond_func(handles)
sig_val1 = get(handles.listbox_func1,'Value');
sig_val2 = get(handles.listbox_func2,'Value');
Fs = 512                %����Ƶ��
T = 1/512               %����ʱ��
L=2048;					%�źų���
t=(0:L-1)*T
j=sqrt(-1);
switch sig_val1
    case 1
        sig1 = sin(t);
    case 2
        sig1 = cos(t);
    case 3
        sig1 = heaviside(t+1)-heaviside(t-1);
    case 4
        sig1 = 1+0*t;
end
switch sig_val2
    case 1
        sig2 = sin(t);
    case 2
        sig2 = cos(t);
    case 3
        sig2 = heaviside(t+1)-heaviside(t-1);
    case 4
        sig2 = 1+0*t;
end
N = 2^nextpow2(L); %������������������Խ�󣬷ֱ��Ƶ��Խ��ȷ��N>=L�������Ĳ����źŲ�Ϊ0
F1 = fft(sig1,N)/N*2
F2 = fft(sig2,N)/N*2
F_conv1 =fft(sig2.*sig1,N)/N*2
f = Fs/N*(0:1:N-1); %Ƶ��
A1 = abs(F_conv1);     %��ֵ
A2 = abs(conv(F1,F2));
axes(handles.axes2);
plot(f(1:N/2),A1(1:N/2),'.-r',f(1:N/2),A2(1:N/2),'.-b');
legend('�������Ҷ�任','����Ҷ�任�����')
xlim([0,12])



function popupmenu1_Callback(hObject, eventdata, handles)
global val;
val=get(handles.popupmenu1,'Value');
switch val
    case 1   %���Ե�������
        init_sel(hObject, eventdata, handles);
        
        set(handles.listbox_func1,'visible','on');
        str = '���Ǻ���(sinx)|���Ǻ���(cosx)|�ź���|ֱ���ź�|����ź�';
        set(handles.listbox_func1,'String',str);
        
        set(handles.listbox_func2,'visible','on');
        str = '���Ǻ���(sinx)|���Ǻ���(cosx)|�ź���|ֱ���ź�|����ź�';
        set(handles.listbox_func2,'String',str);
        
        set(handles.text1,'visible','on');
        set(handles.text2,'visible','on');
        set(handles.edit1,'visible','on');
        set(handles.edit2,'visible','on');
        set(handles.text_val_1,'visible','on');
        set(handles.text_val_2,'visible','on');

    case 2   %�Գ�����
        init_sel(hObject, eventdata, handles);
        
        set(handles.listbox_func1,'visible','on');
        str = '���Ǻ���(sinx)|���Ǻ���(cosx)|�ź���|ֱ���ź�|����ź�';
        set(handles.listbox_func1,'String',str);
        
        set(handles.text2,'String','��');
        str = 'ʱ��|Ƶ��';
        set(handles.listbox_func2,'String',str);
        set(handles.listbox_func2,'visible','on');
        
        set(handles.text1,'visible','on');
        set(handles.text2,'visible','on');
    case 3   %ʱ������
        init_sel(hObject, eventdata, handles);
        
        set(handles.listbox_func1,'visible','on');
        str = '���Ǻ���|�ź���|ֱ���ź�|����ź�';
        set(handles.listbox_func1,'String',str);
        set(handles.text1,'visible','on');
        
        set(handles.text_val_1,'String','ʱ�� t');
        set(handles.text_val_1,'visible','on');
        set(handles.edit1,'visible','on');
        
    case 4   %Ƶ������
        init_sel(hObject, eventdata, handles);
        set(handles.listbox_func1,'visible','on');
        str = '���Ǻ���|�ź���|ֱ���ź�|����ź�';
        set(handles.listbox_func1,'String',str);
        set(handles.text1,'visible','on');
        
        set(handles.text_val_1,'String','Ƶ�� w');
        set(handles.text_val_1,'visible','on');
        set(handles.edit1,'visible','on');

    case 5   %��������
        init_sel(hObject, eventdata, handles);
        
        set(handles.listbox_func1,'visible','on');
        str = '���Ǻ���(sinx)|���Ǻ���(cosx)|�ź���|ֱ���ź�|����ź�';
        set(handles.listbox_func1,'String',str);
        
        set(handles.listbox_func2,'visible','on');
        str = '���Ǻ���(sin(20x))|���Ǻ���(cos(10x))';
        set(handles.listbox_func2,'String',str);
        
        set(handles.text1,'visible','on');
        set(handles.text2,'String','���ƺ���');
        set(handles.text2,'visible','on');

    case 6   %ʱ����
        init_sel(hObject, eventdata, handles);
        set(handles.listbox_func1,'visible','on');
        str = '���Ǻ���(sinx)|���Ǻ���(cosx)|�ź���|ֱ���ź�';
        set(handles.listbox_func1,'String',str);
        
        set(handles.listbox_func2,'visible','on');
        str = '���Ǻ���(sinx)|���Ǻ���(cosx)|�ź���|ֱ���ź�';
        set(handles.listbox_func2,'String',str);
        
        set(handles.text1,'String','ʱ����');
        set(handles.text2,'String','ʱ����');
        set(handles.text1,'visible','on');
        set(handles.text2,'visible','on');

    case 7   %Ƶ����
        init_sel(hObject, eventdata, handles);
        init_sel(hObject, eventdata, handles);
        set(handles.listbox_func1,'visible','on');
        str = '���Ǻ���(sinx)|���Ǻ���(cosx)|�ź���|ֱ���ź�';
        set(handles.listbox_func1,'String',str);
        
        set(handles.listbox_func2,'visible','on');
        str = '���Ǻ���(sinx)|���Ǻ���(cosx)|�ź���|ֱ���ź�';
        set(handles.listbox_func2,'String',str);
        
        set(handles.text1,'String','Ƶ����');
        set(handles.text2,'String','Ƶ����');
        set(handles.text1,'visible','on');
        set(handles.text2,'visible','on');
end



function popupmenu1_CreateFcn(hObject, eventdata, handles)
global val;
val = 0;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function listbox_func1_Callback(hObject, eventdata, handles)

global sel_sig1;
global sel_sig2;
global val_list1;
sel_sig1 = 1;

val_list1=get(handles.listbox_func1,'Value');
val_pop =get(handles.popupmenu1,'Value');
axes(handles.axes1);
switch val_pop
    case 1   %���Ե�������
        sel_sig1 = 0;
        switch val_list1
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig1 = sin(t);
                plot(t,sel_sig1);
                legend('�ź�1�������ź�');
            case 2  %cosx
                t=-5:0.001:5;
                sel_sig1 = cos(t);
                plot(t,sel_sig1);
                legend('�ź�1�������ź�');
            case 3  %�ź���
                t=-5:0.001:5;
                sel_sig1=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig1)
                legend('�ź�1���ź���');
            case 4  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig1='1';
                fplot(sel_sig1,[0 5])
                legend('�ź�1��ֱ���ź�');
            case 5  %����ź�
                t=-5:0.001:5;
                sel_sig1 = (t==0);
                plot(t,sel_sig1)
                legend('�ź�1������ź�');
        end
    case 2  %�Գ�����
        sel_sig1 = 0;
        if sel_sig2 == 'Ƶ��'
            axes(handles.axes2);
        else
            axes(handles.axes1);
        end
        switch val_list1  
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig1 = sin(t);
                plot(t,sel_sig1);
                legend('�ź�1�������ź�');
            case 2  %cosx
                t=-5:0.001:5;
                sel_sig1 = cos(t);
                plot(t,sel_sig1);
                legend('�ź�1�������ź�');
            case 3  %�ź���
                t=-5:0.001:5;
                sel_sig1=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig1)
                legend('�ź�1���ź���');
            case 4  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig1='1';
                fplot(sel_sig1,[0 5])
                legend('�ź�1��ֱ���ź�');
            case 5  %����ź�
                t=-5:0.001:5;
                sel_sig1 = (t==0);
                plot(t,sel_sig1)
                legend('�ź�1������ź�');
        end
    case 3 %ʱ������
        sel_sig1 = 0;
        switch val_list1
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig1 = sin(t);
                plot(t,sel_sig1);
                legend('�ź�1��sin(t)');
            case 2  %�ź���
                t=-5:0.001:5;
                sel_sig1=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig1)
                legend('�ź�1���ź���');
            case 3  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig1='1';
                fplot(sel_sig1,[0 5])
                legend('�ź�1��ֱ���ź�');
            case 4  %����ź�
                t=-5:0.001:5;
                sel_sig1 = (t==0);
                plot(t,sel_sig1);
                legend('�ź�1������ź�');
        end
    case 4 %Ƶ������
        sel_sig1 = 0;
        switch val_list1
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig1 = sin(t);
                plot(t,sel_sig1);
                legend('�ź�1��sin(t)');
            case 2  %�ź���
                t=-5:0.001:5;
                sel_sig1=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig1)
                legend('�ź�1���ź���');
            case 3  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig1='1';
                fplot(sel_sig1,[0 5])
                legend('�ź�1��ֱ���ź�');
            case 4  %����ź�
                t=-5:0.001:5;
                sel_sig1 = (t==0);
                plot(t,sel_sig1);
                legend('�ź�1������ź�');
        end
    case 5 %��������
        sel_sig1 = 0;
        switch val_list1  
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig1 = sin(t);
                plot(t,sel_sig1);
                legend('�ź�1�������ź�');
            case 2  %cosx
                t=-5:0.001:5;
                sel_sig1 = cos(t);
                plot(t,sel_sig1);
                legend('�ź�1�������ź�');
            case 3  %�ź���
                t=-5:0.001:5;
                sel_sig1=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig1)
                legend('�ź�1���ź���');
            case 4  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig1='1';
                fplot(sel_sig1,[0 5])
                legend('�ź�1��ֱ���ź�');
            case 5  %����ź�
                t=-5:0.001:5;
                sel_sig1 = (t==0);
                plot(t,sel_sig1)
                legend('�ź�1������ź�');
        end
    case 6 %ʱ����
        sel_sig1 = 0;
        switch val_list1  
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig1 = sin(t);
                plot(t,sel_sig1);
                legend('�ź�1�������ź�');
            case 2  %cosx
                t=-5:0.001:5;
                sel_sig1 = cos(t);
                plot(t,sel_sig1);
                legend('�ź�1�������ź�');
            case 3  %�ź���
                t=-5:0.001:5;
                sel_sig1=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig1)
                legend('�ź�1���ź���');
            case 4  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig1='1';
                fplot(sel_sig1,[0 5])
                legend('�ź�1��ֱ���ź�');
        end
    case 7 %Ƶ����
        sel_sig1 = 0;
        switch val_list1  
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig1 = sin(t);
                plot(t,sel_sig1);
            case 2  %cosx
                t=-5:0.001:5;
                sel_sig1 = cos(t);
                plot(t,sel_sig1);
            case 3  %�ź���
                t=-5:0.001:5;
                sel_sig1=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig1)
            case 4  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig1='1';
                fplot(sel_sig1,[0 5])
%             case 5  %����ź�
%                 t=-5:0.001:5;
%                 sel_sig1 = (t==0);
%                 plot(t,sel_sig1)
        end
end
        


% --- Executes during object creation, after setting all properties.
function listbox_func1_CreateFcn(hObject, eventdata, handles)
global sel_sig1;
sel_sig1 = 1;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_func2.
function listbox_func2_Callback(hObject, eventdata, handles)
global sel_sig1;
global sel_sig2;
global val_list2;
sel_sig2 = 1;

val_list2=get(handles.listbox_func2,'Value');
val_pop =get(handles.popupmenu1,'Value');
axes(handles.axes1);
switch val_pop
    case 1   %���Ե�������
        sel_sig2 = 0;
        switch val_list2
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig2 = sin(t);
                plot(t,sel_sig2);
                legend('�ź�2�������ź�');
            case 2  %cosx
                t=-5:0.001:5;
                sel_sig2 = cos(t);
                plot(t,sel_sig2);
                legend('�ź�2�������ź�');
            case 3  %�ź���
                t=-5:0.001:5;
                sel_sig2=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig2)
                legend('�ź�2���ź���');
            case 4  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig2='1';
                fplot(sel_sig2,[0 5])
                legend('�ź�2��ֱ���ź�');
            case 5  %����ź�
                t=-5:0.001:5;
                sel_sig2 = (t==0);
                plot(t,sel_sig2)
                legend('�ź�2������ź�');
        end
    case 2 %�Գ�����
        sel_sig2 = 0;
        switch val_list2
            case 1
                sel_sig2 = 'ʱ��'
                axes(handles.axes2);
                cla reset;
                axes(handles.axes1);
                if sel_sig1 ~= '1'
                    t=-5:0.001:5;
                    plot(t,sel_sig1)
                    legend('ʱ���ź�');
                else
                    fplot(sel_sig1,[0 5])
                    legend('ʱ���ź�');
                end
            case 2
                sel_sig2 = 'Ƶ��'
                axes(handles.axes1);
                cla reset;
                axes(handles.axes2);
                if sel_sig1 ~= '1'
                    t=-5:0.001:5;
                    plot(t,sel_sig1)
                    legend('Ƶ���ź�');
                else
                    fplot(sel_sig1,[0 5])
                    legend('Ƶ���ź�');
                end
        end
    case 3 %ʱ������
    case 4 %Ƶ������
    case 5 %��������
    case 6 %ʱ����
        sel_sig2 = 0;
        switch val_list2
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig2 = sin(t);
                plot(t,sel_sig2);
            case 2  %cosx
                t=-5:0.001:5;
                sel_sig2 = cos(t);
                plot(t,sel_sig2);
            case 3  %�ź���
                t=-5:0.001:5;
                sel_sig2=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig2)
            case 4  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig2='1';
                fplot(sel_sig2,[0 5])
        end
    case 7 %Ƶ����
        sel_sig2 = 0;
        switch val_list2
            case 1  %sinx
                t=-5:0.001:5;
                sel_sig2 = sin(t);
                plot(t,sel_sig2);
            case 2  %cosx
                t=-5:0.001:5;
                sel_sig2 = cos(t);
                plot(t,sel_sig2);
            case 3  %�ź���
                t=-5:0.001:5;
                sel_sig2=heaviside(t+1)-heaviside(t-1);
                plot(t,sel_sig2)
            case 4  %ֱ���ź�
                t=-5:0.001:5;
                sel_sig2='1';
                fplot(sel_sig2,[0 5])
%             case 5  %����ź�
%                 t=-5:0.001:5;
%                 sel_sig2 = (t==0);
%                 plot(t,sel_sig2)
        end
end


% --- Executes during object creation, after setting all properties.
function listbox_func2_CreateFcn(hObject, eventdata, handles)
global sel_sig2;
sel_sig2 = 1;


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_back.
function bt_back_Callback(hObject, eventdata, handles)

h = gcf;
logsel;
close(h);



function edit1_Callback(hObject, eventdata, handles)
global sel_edit1;
sel_edit1 = 0;

sel_edit1 = get(handles.edit1,'String');
str1=str2num(sel_edit1);
sel_edit1 = str1;
if isempty(str1)
  errordlg('����1������������','error');
end

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
global sel_edit2;
sel_edit2 = 0;

sel_edit2 = get(handles.edit2,'String');
str1=str2num(sel_edit2);
sel_edit2 = str1;
if isempty(str1)
  errordlg('����2������������','error');
end



function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
