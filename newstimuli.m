function varargout = newstimuli(varargin)
% NEWSTIMULI MATLAB code for newstimuli.fig
%      NEWSTIMULI, by itself, creates a new NEWSTIMULI or raises the existing
%      singleton*.
%
%      H = NEWSTIMULI returns the handle to a new NEWSTIMULI or the handle to
%      the existing singleton*.
%
%      NEWSTIMULI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWSTIMULI.M with the given input arguments.
%
%      NEWSTIMULI('Property','Value',...) creates a new NEWSTIMULI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newstimuli_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newstimuli_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newstimuli

% Last Modified by GUIDE v2.5 27-Sep-2018 19:24:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newstimuli_OpeningFcn, ...
                   'gui_OutputFcn',  @newstimuli_OutputFcn, ...
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


% --- Executes just before newstimuli is made visible.
function newstimuli_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newstimuli (see VARARGIN)

% Choose default command line output for newstimuli

%varargout{1} = handles.output;

guidata(hObject, handles);
    
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
set (gcf, 'WindowButtonMotionFcn', {@mouseMove, handles});
global signal_place newSignal s_test  s_red s_green k controlKey warning_sign ses
global s_A s_B  hapSignal ELSignal
global data_red data_green tempData_red tempData_green 
global velo_red velo_green 
global bias
global start
global axes redbutton greenbutton text3
axes=handles.axes2;

redbutton=handles.red;
greenbutton=handles.green;
text3=handles.text3;
start=0;
%% Screen info
ScreenWidth=1440; %pixel
ScreenHeight=900;
AnimationWidth=682;
AnimationHeight=458;
%% Force info
Lowforce=0.1; %Newton
Highforce=0.5; %Newton
%% Strings
PutFingerText='Put your finger on glass surface'; 
%% rectangle
d = [0 0] ;% corner of rectangle
RectWidth=100;
RectHeight=400;
Xrect = d(1)+[linspace(0,RectWidth) linspace(RectWidth,RectWidth) linspace(RectWidth,0) linspace(0,0)] ; %xpoints of rectangle
Yrect = d(1)+[linspace(0,0) linspace(0,RectHeight) linspace(RectHeight,RectHeight) linspace(RectHeight,0)] ; %ypoints of rectangle

d = [0 0] ;% corner of rectangle
PointerWidth=10;
PointerHeight=10;
Xpointer = d(1)+[linspace(0,PointerWidth) linspace(PointerWidth,PointerWidth) linspace(PointerWidth,0) linspace(0,0)] ; %xpoints of rectangle
Ypointer = d(1)+[linspace(0,0) linspace(0,PointerHeight) linspace(PointerHeight,PointerHeight) linspace(PointerHeight,0)] ; %ypoints of rectangle

%% Patch
xpatch=[0 RectWidth RectWidth 0];
ypatch=[Lowforce Lowforce Highforce Highforce]*1000;
%%
Xstart=(ScreenWidth-AnimationWidth)/2;

set(handles.trial, 'String', sprintf('Signal %d ', k));
set(handles.red,'Visible','Off') 
set(handles.green,'Visible','Off') 

redsucceed=0;
set(handles.text3,'String',PutFingerText)
ylim(handles.axes2,[0 800])

ylim(handles.axes2,[0 800])

h = plot(handles.axes2,Xpointer,Ypointer,'.') ; 
set(h,'Color','white');
set(handles.axes2,'Color',[0.24314 0.33333 0.38824]);
xlim(handles.axes2,[(ScreenWidth-AnimationWidth)/2 ScreenWidth-(ScreenWidth-AnimationWidth)/2])

ylim(handles.axes2,[0 800])
set(handles.axes2,'xtick',[])
set(handles.axes2,'xticklabel',[])
set(handles.axes2,'ytick',[])
set(handles.axes2,'yticklabel',[])
set(handles.axes2,'XColor','white');
set(handles.axes2,'YColor','white');
Xpatch=Xstart+xpatch;  
patch(handles.axes2,Xpatch,ypatch,[0.94902 0.32157 0.36863],'LineStyle','none');

align(handles.axes2,'HorizontalAlignment','VerticalAlignment')
set(handles.figure1,'WindowKeyPressFcn',@figure1_WindowKeyPressFcn);

%figure(handles.figure1)
%uicontrol(handles.figure1); 
%uiwait(handles.figure1);
set(0,'PointerLocation',[300 300]);
a=get(0,'PointerLocation');
set(gcf,'Pointer','custom','PointerShapeCData',NaN(16,16))
uiwait();

%RunFunction(handles);





%     
% UIWAIT makes newstimuli wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newstimuli_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure


handles.output = hObject;

% Update handles structure


varargout{1} = handles.output;


% --- Executes on button press in red.
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global reply decide signal_place 

reply = 1;
if (signal_place == reply)
    decide = 1;
   
else
    decide = 0;
   
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
   
else
    decide = 0;
   
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
global controlKey reply decide signal_place text3

 if (controlKey == 1)
     
    if strcmpi(eventdata.Key,'leftarrow')
       

        reply = 1;
        if (signal_place == reply)
            decide = 1;
            set(text3,'String','CORRECT')
            pause (1)
        else
            decide = 0;
            set(text3,'String','INCORRECT')
            pause (1)
        end
        assignin('base','results',reply)
        assignin('base','decide',decide)
        uiresume(gcf); 
        %close(handles.figure1)
        delete(gcbf)

    end
 
     if strcmpi(eventdata.Key,'rightarrow')
                  
        reply = 2;
        if (signal_place == reply)
            decide = 1;
            set(text3,'String','CORRECT')
            pause (1)
        else
            decide = 0;
           set(text3,'String','INCORRECT')
            pause (1)
        end
        assignin('base','results',reply)
        assignin('base','decide',decide)
        uiresume(gcf); 
        %close(handles.figure1)
        delete(gcbf)
    end

  
   
    
 end 
function mouseMove (object, eventdata,handles)
global start reply

if start==0
    start=1;
    
    RunFunction(handles)
end


function RunFunction(handles)
redsucceed=0;
global signal_place newSignal s_test  s_red s_green k controlKey warning_sign ses
global s_A s_B  hapSignal ELSignal
global data_red data_green tempData_red tempData_green 
global velo_red velo_green 
global bias
global axes redbutton greenbutton 
global sp
ScreenWidth=1440; %pixel
ScreenHeight=900;
AnimationWidth=682;
AnimationHeight=458;
%% Force info
Lowforce=0.1; %Newton
Highforce=0.5; %Newton
%% Strings
PutFingerText='Put your finger on glass surface'; 
%% rectangle
d = [0 0] ;% corner of rectangle
RectWidth=100;
RectHeight=400;
Xrect = d(1)+[linspace(0,RectWidth) linspace(RectWidth,RectWidth) linspace(RectWidth,0) linspace(0,0)] ; %xpoints of rectangle
Yrect = d(1)+[linspace(0,0) linspace(0,RectHeight) linspace(RectHeight,RectHeight) linspace(RectHeight,0)] ; %ypoints of rectangle

d = [0 0] ;% corner of rectangle
PointerWidth=10;
PointerHeight=10;
Xpointer = d(1)+[linspace(0,PointerWidth) linspace(PointerWidth,PointerWidth) linspace(PointerWidth,0) linspace(0,0)] ; %xpoints of rectangle
Ypointer = d(1)+[linspace(0,0) linspace(0,PointerHeight) linspace(PointerHeight,PointerHeight) linspace(PointerHeight,0)] ; %ypoints of rectangle

%% Patch
xpatch=[0 RectWidth RectWidth 0];
ypatch=[Lowforce Lowforce Highforce Highforce]*1000;
%%

Xstart=(ScreenWidth-AnimationWidth)/2;
Xpatch=Xstart+xpatch;  
%sp=patch(axes,Xpatch,ypatch,[0.94902 0.32157 0.36863],'LineStyle','none');
h = plot(axes,Xpointer,Ypointer,'.') ; 
set(h,'Color','white');


sp=patch(axes,Xpatch,ypatch,[0.94902 0.32157 0.36863],'LineStyle','none');%red
firstchi=get(axes, 'Children');
greensucceed=0;



set(handles.text3,'String',PutFingerText)    
while redsucceed==0
         red_force_violation=0;
         
        % %% RED INTERVAL
             %pause(1.5)                                                  % wait for 1.5 seconds when the red sign is on
        lh = s_red.addlistener('DataAvailable',@plotData_red);      % add listener for red interval force data 
     queueOutputData(s_test,newSignal);                            % queue test signal
    
        %    
            set(axes,'Color',[0.24314 0.33333 0.38824]);
            set(sp,'Facecolor',[0.94902 0.32157 0.36863]); 
    xlim(axes,[(ScreenWidth-AnimationWidth)/2 ScreenWidth-(ScreenWidth-AnimationWidth)/2])
    ylim(axes,[0 800])
    set(axes,'xtick',[])
    set(axes,'xticklabel',[])
    set(axes,'ytick',[])
    set(axes,'yticklabel',[])
    set(axes,'XColor','white');
    set(axes,'YColor','white');
            redsucceed=1;
            %h = plot(handles.axes2,Xrect,Yrect,'.') ; 
            set(sp,'XData',Xpatch,'YData',ypatch);
            chi=get(axes, 'Children');
            if chi==firstchi
                set(axes, 'Children',flipud(chi));
            end
            drawnow  
            while(1)
                po=get(0,'PointerLocation');
                if(po(1)<475 && po(1)>379) 
                    set(handles.text3,'String','Start exploring surface')
                    break
                end
            end
            s_red.DurationInSeconds = 30;
            s_red.startBackground()
            intpo=po(1)+20;
            while(1)
                po=get(0,'PointerLocation');
                xpointer = po(1)+Xpointer ;
                ypointer = po(2)+Ypointer ;
                %xR=Xstart+Xrect;
                %yR=200+Yrect;

              if length(data_red)>0
                  force_red = convertForce(data_red(end,:),bias)*1000;
                  NormalForce=abs(force_red(3));
                  ypointer=abs(NormalForce)+Ypointer;
              end
               x=xpointer;% x=[xpointer xR];
               y=ypointer;% y=[ypointer yR];

              set(h,'XData',x,'YData',y) ;

              drawnow
                if(po(1)>=intpo)

                    break
                end
            end
            %system('start /b red.bat');                                  % start collecting force data for 2 seconds


            %set(h,'XLim',[0 1500],'YLim',[0 1500])
            %set(gcf, 'Position', get(0, 'Screensize'));
            controlKey = 0;


       if (signal_place == 1)                                          % if signal is at red interval
         s_test.startBackground()                                    % start signal at background
        end
               timerID = tic;
            sn=1;

     set(sp,'XData',Xpatch,'YData',ypatch);       
    %sp=patch(axes,Xpatch,ypatch,[0.94902 0.32157 0.36863],'LineStyle','none');
            while toc(timerID)<2
                a=get(0,'PointerLocation'); 
                loc(sn)=a(1);
                c(:,sn)=clock;
                sn=sn+1;
                %plot
                xpointer = a(1)+Xpointer ;
                ypointer = a(2)+Ypointer ;
                %xR=toc(timerID)/2*AnimationWidth+Xstart+Xrect;
                %yR=200+Yrect;
                Xpatch=toc(timerID)/2*AnimationWidth+Xstart+xpatch;
              if length(data_red)>0
                  force_red = convertForce(data_red(end,:),bias)*1000;
                  NormalForce=abs(force_red(3));
                  ypointer=NormalForce+Ypointer;
              end
              x=xpointer;%x=[xpointer xR];
              y=ypointer;% y=[ypointer yR];

              chi=get(axes, 'Children');

              set(sp,'XData',Xpatch,'YData',ypatch);
               set(h,'XData',x,'YData',y) ;
             % alpha(sp,0.3)
              drawnow
              
            end
            
                velo_red = [loc;c];
               
                 
                
          

           %miald pause(2.5)
            % stop daq cards
            %stop(s_test)
            wait(s_test)
            %release(s_test)

            stop(s_red)
            release(s_red)
            delete(lh)
            clear lh
if length(data_red)>25000
  data_red=data_red((end-25000:end),:);   
 end
 force_red = convertForce(data_red,bias);
 av_normal_red = mean(abs(force_red(:,3)))
 
 
 if av_normal_red<Lowforce || av_normal_red>Highforce
         redsucceed=0;
         set(handles.text3,'String','Force Violation')
         
         red_force_violation=1;
 else
    red_force_violation=0 ;
 end
 
 if red_force_violation==0
     red_speed = newvel_calc(velo_red);
     if (red_speed >= 37.5 && red_speed <=62.5)
         speed_check = 1;
     else
         speed_check = 0;
         redsucceed=0;
         if red_speed<37.5
             set(handles.text3,'String','Explore faster!')
         else
             set(handles.text3,'String','Explore slower!')
         end
     end
 end               
      Xpatch=Xstart+xpatch ;
              if redsucceed==1
                    set(sp,'Facecolor',[0.38824 0.73333 0.37255]); 
              end
            set(sp,'XData',Xpatch,'YData',ypatch);
  
     end
 
release(s_test)
    %% Green interval
set(handles.text3,'String',PutFingerText)
while greensucceed==0
    green_force_violation=0;
    chi=get(axes, 'Children');
    set(sp,'Facecolor',[0.38824 0.73333 0.37255]);
    chi=get(axes, 'Children');
    lh = s_green.addlistener('DataAvailable',@plotData_green);      % add listener for red interval force data 
        %    
        
            set(axes,'Color',[0.24314 0.33333 0.38824]);

    xlim(axes,[(ScreenWidth-AnimationWidth)/2 ScreenWidth-(ScreenWidth-AnimationWidth)/2])
    ylim(axes,[0 800])
    set(axes,'xtick',[])
    set(axes,'xticklabel',[])
    set(axes,'ytick',[])
    set(axes,'yticklabel',[])
    set(axes,'XColor','white');
    set(axes,'YColor','white');
    greensucceed=1;
    drawnow
                queueOutputData(s_test,newSignal);                            % queue test signal
            %h = plot(handles.axes2,Xrect,Yrect,'.') ; 

            %sp=patch(axes,Xpatch,ypatch,[0.38824 0.73333 0.37255],'LineStyle','none');%Green
            %chi=get(axes, 'Children')
            %set(axes, 'Children',flipud(chi));
            while(1)
                po=get(0,'PointerLocation');
                if(po(1)<475 && po(1)>379) 
                     set(handles.text3,'String','Start exploring surface')
                    break
                end
            end
            s_green.DurationInSeconds = 30;
            s_green.startBackground()
            intpo=po(1)+20;
            while(1)
                po=get(0,'PointerLocation');
                xpointer = po(1)+Xpointer ;
                ypointer = po(2)+Ypointer ;
                %xR=Xstart+Xrect;
                %yR=200+Yrect;

              if length(data_green)>0
                  force_red = convertForce(data_green(end,:),bias)*1000;
                  NormalForce=abs(force_red(3));
                  ypointer=abs(NormalForce)+Ypointer;
              end
               x=xpointer;% x=[xpointer xR];
               y=ypointer;% y=[ypointer yR];

              set(h,'XData',x,'YData',y) ;

              drawnow
                if(po(1)>=intpo)

                    break
                end
            end
            %system('start /b red.bat');                                  % start collecting force data for 2 seconds


            %set(h,'XLim',[0 1500],'YLim',[0 1500])
            %set(gcf, 'Position', get(0, 'Screensize'));
            controlKey = 0;


         if (signal_place == 2)                                          % if signal is at green interval
                 s_test.startBackground()                                    % start signal at background
         end
    
               timerID = tic;
            sn=1;

     set(sp,'XData',Xpatch,'YData',ypatch);       
    %sp=patch(axes,Xpatch,ypatch,[0.94902 0.32157 0.36863],'LineStyle','none');
            while toc(timerID)<2
                a=get(0,'PointerLocation'); 
                loc(sn)=a(1);
                c(:,sn)=clock;
                sn=sn+1;
                %plot
                xpointer = a(1)+Xpointer ;
                ypointer = a(2)+Ypointer ;
                %xR=toc(timerID)/2*AnimationWidth+Xstart+Xrect;
                %yR=200+Yrect;
                Xpatch=toc(timerID)/2*AnimationWidth+Xstart+xpatch;
              if length(data_green)>0
                  force_green = convertForce(data_green(end,:),bias)*1000;
                  NormalForce=abs(force_green(3));
                  ypointer=NormalForce+Ypointer;
              end
              x=xpointer;%x=[xpointer xR];
              y=ypointer;% y=[ypointer yR];

              chi=get(axes, 'Children');

              set(sp,'XData',Xpatch,'YData',ypatch);
               set(h,'XData',x,'YData',y) ;
             % alpha(sp,0.3)
              drawnow
              
            end

                velo_green = [loc;c];
                
               
              Xpatch=Xstart+xpatch ;

            set(sp,'XData',Xpatch,'YData',ypatch);

           %miald pause(2.5)
            % stop daq cards
            %stop(s_test)
            wait(s_test)
            %release(s_test)

            stop(s_green)
            release(s_green)
            delete(lh)
            clear lh
if length(data_green)>25000
  data_green=data_green((end-25000:end),:);   
 end
 force_green = convertForce(data_green,bias);
 av_normal_green= mean(abs(force_green(:,3)))
 if av_normal_green<Lowforce || av_normal_green>Highforce
     greensucceed=0;
     set(handles.text3,'String','Force Violation')
     green_force_violation=1;
 else
     green_force_violation=0 ;
 end
 
 if green_force_violation==0
     green_speed = newvel_calc(velo_green);
     if (green_speed >= 37.5 && green_speed <=62.5)
         speed_check = 1;
     else
         speed_check = 0;
         greensucceed=0;
         if green_speed<37.5
             set(handles.text3,'String','Explore faster!')
         else
             set(handles.text3,'String','Explore slower!')
         end
     end
 end   
 drawnow
end  %while greensucceed end        
 % set(handles.axes1,'Color','yellow'); % Hint: place code in OpeningFcn to populate axes1
 stop(s_test)   
 release(s_test)
  delete(sp)
 set(h,'XData',[],'YData',[]) ;
    pause(1)
    set(axes,'Visible','Off') 
    set(redbutton,'Visible','On') 
    set(greenbutton,'Visible','On') 
    set(handles.text3,'String','Which interval includes tactile stimuli?')
    set(0,'PointerLocation',[300 300]) ;
    
    import java.awt.Robot;  %click
    import java.awt.event.*;
    mouse = Robot;
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
    pause(0.2)
    mouse.mousePress(InputEvent.BUTTON1_MASK);
    mouse.mouseRelease(InputEvent.BUTTON1_MASK);
  
    
    controlKey = 1;
    
