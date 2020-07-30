% Mahmudul Islam
% EEE,Bangladesh University of Engineering and Technology (BUET)
% Email: mahmudulislam299@gmail.com
% Project: Matlab Image Processing based Rock Paper Scissors Game

function varargout = main_file(varargin)
% MAIN_FILE MATLAB code for main_file.fig
%      MAIN_FILE, by itself, creates a new MAIN_FILE or raises the existing
%      singleton*.
%
%      H = MAIN_FILE returns the handle to a new MAIN_FILE or the handle to
%      the existing singleton*.
%
%      MAIN_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_FILE.M with the given input arguments.
%
%      MAIN_FILE('Property','Value',...) creates a new MAIN_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_file_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_file_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_file

% Last Modified by GUIDE v2.5 10-Jul-2017 02:07:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_file_OpeningFcn, ...
                   'gui_OutputFcn',  @main_file_OutputFcn, ...
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


% --- Executes just before main_file is made visible.
function main_file_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_file (see VARARGIN)

% Choose default command line output for main_file
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('rock.jpg'); imagesc(bg);
set(ah,'handlevisibility','off','visible','off')
uistack(ah, 'bottom');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[y1,Fs1] = audioread('opening.mp3');
sound(y1,Fs1);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_file wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_file_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function box_Callback(hObject, eventdata, handles)
% hObject    handle to box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of box as text
%        str2double(get(hObject,'String')) returns contents of box as a double


% --- Executes during object creation, after setting all properties.
function box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
value1 = get(handles.single, 'value');
value2 = get(handles.double, 'value');
if value1 == 1
    close all;
    play1
elseif value2 == 1
        close all;
        play2
        
end
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
