function varargout = Start_Window(varargin)
% START_WINDOW MATLAB code for Start_Window.fig
%      START_WINDOW, by itself, creates a new START_WINDOW or raises the existing
%      singleton*.
%
%      H = START_WINDOW returns the handle to a new START_WINDOW or the handle to
%      the existing singleton*.
%
%      START_WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in START_WINDOW.M with the given input arguments.
%
%      START_WINDOW('Property','Value',...) creates a new START_WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Start_Window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Start_Window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Start_Window

% Last Modified by GUIDE v2.5 22-Mar-2017 15:45:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Start_Window_OpeningFcn, ...
                   'gui_OutputFcn',  @Start_Window_OutputFcn, ...
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


% --- Executes just before Start_Window is made visible.
function Start_Window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Start_Window (see VARARGIN)

% Choose default command line output for Start_Window
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% UIWAIT makes Start_Window wait for user response (see UIRESUME)




% --- Outputs from this function are returned to the command line.
function varargout = Start_Window_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%uiresume(gcbf)
global s_red data_red s_green data_green
 delete(gcbf)


% --- Executes on key press with focus on Start_Window or any of its controls.
function Start_Window_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Start_Window (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
 if strcmpi(eventdata.Key,'uparrow')
     % set focus to the button
     uicontrol(handles.pushbutton1);
     % call the callback
     %uiwait(gcf)
     pushbutton1_Callback
 end

 
