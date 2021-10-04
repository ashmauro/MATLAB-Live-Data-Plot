function varargout = PumpGUI(varargin)
% PUMPGUI MATLAB code for PumpGUI.fig
%      PUMPGUI, by itself, creates a new PUMPGUI or raises the existing
%      singleton*.
%
%      H = PUMPGUI returns the handle to a new PUMPGUI or the handle to
%      the existing singleton*.
%
%      PUMPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PUMPGUI.M with the given input arguments.
%
%      PUMPGUI('Property','Value',...) creates a new PUMPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PumpGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PumpGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PumpGUI

% Last Modified by GUIDE v2.5 04-Jun-2020 13:49:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PumpGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PumpGUI_OutputFcn, ...
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


% --- Executes just before PumpGUI is made visible.
function PumpGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PumpGUI (see VARARGIN)

% Choose default command line output for PumpGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PumpGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PumpGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in prerecordeddata.
function prerecordeddata_Callback(hObject, eventdata, handles)
% hObject    handle to prerecordeddata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of prerecordeddata


% --- Executes on button press in livedata.
function livedata_Callback(hObject, eventdata, handles)
% hObject    handle to livedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of livedata

% --- Executes on selection change in listbox1.
% --- Executes on selection change in filename.
function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns filename contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filename

% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in serialport.
function serialport_Callback(hObject, eventdata, handles)
% hObject    handle to serialport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns serialport contents as cell array
%        contents{get(hObject,'Value')} returns selected item from serialport

% --- Executes during object creation, after setting all properties.
function serialport_CreateFcn(hObject, eventdata, handles)
% hObject    handle to serialport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startbutton.
function startbutton_Callback(hObject, eventdata, handles)
% hObject    handle to startbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.prerecordeddata.Value == 1
    
     fileID = fopen(handles.filename.String{handles.filename.Value});
    
else
    
    disp('ERROR, Only pre-recorded data aviliable at this time')
    
end

handles.value = fileID;
guidata(hObject, handles);
PumpDataAnalysis(hObject);


% --- Executes on button press in stopbutton.
function stopbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stopbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PumpDataAnalysis(hObject)


% --- Executes during object creation, after setting all properties.
function pressurevstime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pressurevstime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate pressurevstime

% --- Executes during object creation, after setting all properties.
function flowratevstime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to flowratevstime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate flowratevstime

% --- Executes during object creation, after setting all properties.
function headvsflowrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headvsflowrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate headvsflowrate

% --- Executes during object creation, after setting all properties.
function hpowervsflowrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hpowervsflowrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate hpowervsflowrate
