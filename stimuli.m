function varargout = stimuli(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stimuli_OpeningFcn, ...
                   'gui_OutputFcn',  @stimuli_OutputFcn, ...
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

% --- Executes just before figure1 is made visible.
function stimuli_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to figure1 (see VARARGIN)

% Choose default command line output for figure1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
%jf = get(handle(gcf), 'JavaFrame');
%jf.setMaximized(true)

global signal_place newSignal s_test  s_red s_green k controlKey warning_sign ses
global data_red data_green tempData_red tempData_green
global velo_red velo_green

set(handles.red,'Visible','Off') 
set(handles.green,'Visible','off') 
set(handles.text2,'Visible','Off') 
set(handles.text3,'Visible','off')

%milad deleted this    set(handles.axes1,'Color','red');     % Hint: place code in OpeningFcn to populate axes1

% warning signs 
axes(handles.axes2);
if warning_sign == 0
imshow('cap1.png')
elseif warning_sign == 1
    imshow('press_less.png')
    warning_sign = 0;
    pause(1)
    imshow('cap1.png')
elseif warning_sign == 2
    imshow('press_more.png')
    warning_sign = 0;
    pause(1)
    imshow('cap1.png')
% elseif warning_sign == 3
%     imshow('move_slower.png')
%     warning_sign = 0;
%     pause(1)
%     imshow('cap1.png')    
% elseif warning_sign == 4
%     imshow('move_faster.png')
%     warning_sign = 0;
%     pause(1)
%     imshow('cap1.png')   
end
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])

%% RED INTERVAL
    %milad pause(1.5)                                                   % wait for 1.5 seconds when the red sign is on
    lh = s_red.addlistener('DataAvailable',@plotData_red);      % add listener for red interval force data 
    queueOutputData(s_test,newSignal);                           % queue test signal
    %sound(ses)
    while(1)
        po=get(0,'PointerLocation');
        if(po(1)<475 && po(1)>379)
            
            break
        end
    end
    intpo=po(1)+20;
    while(1)
        po=get(0,'PointerLocation');
        if(po(1)>=intpo)
            
            break
        end
    end
    system('start /b red.bat');                                % play video for finger scanning for 2 seconds                         
    s_red.startBackground()                                    % start collecting force data for 2 seconds
    controlKey = 0;
    
    if (signal_place == 1)                                          % if signal is at red interval
        s_test.startBackground()                                    % start signal at background
    end

    timerID = tic;
    sn=1;

    while toc(timerID)<2
        a=get(0,'PointerLocation'); 
        loc(sn)=a(1);
        c(:,sn)=clock;
        sn=sn+1;
    end
    
        velo_red = [loc;c];
        
    pause(2.1)
    % stop daq cards
    stop(s_test)
    release(s_test)
    stop(s_red)
    release(s_red)
    delete(lh)
    clear lh

 %% GREEN INTERVAL
 
   %milad set(handles.axes1,'Color','green');                             % Hint: place code in OpeningFcn to populate axes1
   %milad pause(1.5)
    lh = s_green.addlistener('DataAvailable',@plotData_green);     % add listener for red interval force data 
    queueOutputData(s_test,newSignal);                           % queue test signal
    while(1)
        po=get(0,'PointerLocation');
        if(po(1)<475 && po(1)>379) 
            break
        end
   end
    intpo=po(1)+20;
    while(1)
        po=get(0,'PointerLocation');
        if(po(1)>=intpo)
            
            break
        end
    end
     system('start /b green.bat');
      set(handles.text4,'Visible','off')                                   % play video for finger scanning for 2 seconds                         
    s_green.startBackground() 

    controlKey = 0;
    
    if (signal_place == 2)                                          % if signal is at green interval
        s_test.startBackground()                                    % start signal at background
    end
    
    timerID2 = tic;
    sn=1;

    while toc(timerID2)<2
        a=get(0,'PointerLocation'); 
        loc(sn)=a(1);
        c(:,sn)=clock;
        sn=sn+1;
    end
    
    velo_green = [loc;c];
    
    pause(2.1)
    % stop daq cards
    stop(s_test)
    release(s_test)
    stop(s_green)
    release(s_green)
    delete(lh)
    clear lh
    
   
   %milad set(handles.axes1,'Color','yellow'); % Hint: place code in OpeningFcn to populate axes1
    set(handles.axes2,'Visible','Off') 
    set(handles.red,'Visible','On') 
    set(handles.green,'Visible','On') 

    %figure(handles.figure1)

    set(0,'PointerLocation',[82 163])  
    import java.awt.Robot;  %click
    import java.awt.event.*;
    mouse = Robot;
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    pause(0.2)
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    
    controlKey = 1;
    uiwait();


% --- Outputs from this function are returned to the command line.
function varargout = stimuli_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;

% --- Executes on button press in red.
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reply decide signal_place 

reply = 1;
if (signal_place == reply)
    decide = 1;
    set(handles.text2,'Visible','On') 
    pause (1)
else
    decide = 0;
    set(handles.text3,'Visible','On') 
    pause (1)
end
assignin('base','results',reply)
assignin('base','decide',decide)
uiresume(gcf); 
%close(handles.figure1)
delete(gcbf)

% --- Executes on button press in green.
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reply decide signal_place 
reply = 2;
if (signal_place == reply)
    decide = 1;
    set(handles.text2,'Visible','On') 
   pause (1)
else
    decide = 0;
    set(handles.text3,'Visible','On') 
    pause (1)
end
assignin('base','results',reply)
assignin('base','decide',decide)
uiresume(gcf); 
%close(handles.figure1)
delete(gcbf)


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global controlKey
 if (controlKey == 1)
if strcmpi(eventdata.Key,'leftarrow')
    global reply decide signal_place 

reply = 1;
if (signal_place == reply)
    decide = 1;
    set(handles.text2,'Visible','On') 
    pause (1)
else
    decide = 0;
    set(handles.text3,'Visible','On') 
    pause (1)
end
assignin('base','results',reply)
assignin('base','decide',decide)
uiresume(gcf); 
%close(handles.figure1)
delete(gcbf)
 end
 
  if strcmpi(eventdata.Key,'rightarrow')
  global reply decide signal_place 
reply = 2;
if (signal_place == reply)
    decide = 1;
    set(handles.text2,'Visible','On') 
   pause (1)
else
    decide = 0;
    set(handles.text3,'Visible','On') 
    pause (1)
end
assignin('base','results',reply)
assignin('base','decide',decide)
uiresume(gcf); 
%close(handles.figure1)
delete(gcbf)
  end

 end
