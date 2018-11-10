clear all  
clc
close all                                                                                                                                                                                                                       

%% CHANGE THESE VARIABLE BEFORE EACH EXPERIMENT 
    
subject = 'Ehsan';
experiment = 'threshold';
test_dur = 0.5;

test_freq = 125;

trial = 2;
%% Generate folder for experiment data collection
mkdir (['C:\Users\Milad\Google Drive\Milad_shared_folder\Data' '\' subject '_' experiment '_' num2str(test_dur) '_' num2str(test_freq) '_' num2str(trial)])

%% Determine Slidiime
slide_time = 2;       
                        
%% Load Mask and Test Signals and Response Matrix
         % Seconds 

load (['C:\Users\Milad\Google Drive\Milad_shared_folder\Signals' '\' experiment '_' num2str(test_dur) '_' num2str(test_freq) '\test_input'])
load (['C:\Users\Milad\Google Drive\Milad_shared_folder\Signals' '\' experiment '_' num2str(test_dur) '_' num2str(test_freq) '\matrix'])

%% Define Variables
 
global L decide k  newSignal  signal_place s_test s_hap ses
global test_duration s_red s_green tempData_red tempData_green warning_sign data_red data_green
global velo_red velo_green reply
global loc loc_time bias;%milad

k = 1;                                                 % trial number
i = 0;                                                 % check for while loop
correct = 0;                                           % check for correct answer 
not_correct = 0;                                       % check for uncorrect answer
count_reversal = 0;                                    % check for reversal count 
init = 0.4;                                              % initial voltage value is 50 V (50 comes from amplifier)
step_size = 1;                                         % step size in dB
test_amp_next = init;                                  % amplitude of next signal
test_amp_current = test_amp_next;                      % amplitude of current
save_test_amp = [test_amp_current];                    % array of test signal amplitude 
user_reply = [];                                       % user reply                                                         
save_reversal= [];                                     % reversal
save_normal = [];                                      % array for normal force violations
save_speed = [];                                       % array for speed violations
respose_total = [];                                    % array for all user responses
speed_red = [];                                        % array for all collected speeds in red interval
speed_green = [];                                      % array for all collected speeds in green interval
av_force_red_lateral = [];                             % array for all average lateral forces collected in red interval
av_force_red_normal = [];                              % array for all average normal forces collected in red interval
av_force_green_lateral = [];                           % array for all average lateral forces collected in green interval
av_force_green_normal = [];                            % array for all average normal forces collected in green interval

ramp_dur = 0.05;                                       % 50 ms cosine square ramps                      
action_old = 0;
action_new = 0;

%a = 0;
warning_sign = 0;                                      % warning sign for violations

%% Determine Experiment Variables 

test_duration = test_dur + ramp_dur;                   % second
newSignal = test_amp_next*testSignal;                   

%% Create DAQ Sessions

% test signal session
s_test = daq.createSession('ni');
s_test.DurationInSeconds = test_duration;
addAnalogOutputChannel(s_test, 'Dev2', 0, 'Voltage');
s_test.Rate = 10000;
% force signal session (red)
s_red = daq.createSession('ni');
s_red.DurationInSeconds = 2.5;
addAnalogInputChannel(s_red,'Dev4', 0, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_red,'Dev4', 1, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_red,'Dev4', 2, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_red,'Dev4', 3, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_red,'Dev4', 4, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_red,'Dev4', 5, 'Voltage');  
ch.TerminalConfig = 'Diff';
s_red.Rate=10000;

% force signal session (green)
s_green = daq.createSession('ni');
s_green.DurationInSeconds = 2.5;
addAnalogInputChannel(s_green,'Dev4', 0, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_green,'Dev4', 1, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_green,'Dev4', 2, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_green,'Dev4', 3, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_green,'Dev4', 4, 'Voltage');  
ch.TerminalConfig = 'Diff';
addAnalogInputChannel(s_green,'Dev4', 5, 'Voltage');  
ch.TerminalConfig = 'Diff';
s_green.Rate=10000;

%% SOUND SIGNAL 

fs_sound = 16000;
dt_sound = 1/fs_sound;
frequency_sound = 250;
time_sound = 0:dt_sound:(0.1-dt_sound);
ses = sin(2*pi*time_sound*frequency_sound)*5;
%% COLLECT DATA FOR BIAS 

lh = s_green.addlistener('DataAvailable',@plotData_green);   % to obtain force data 

s_green.startBackground();
pause(2)
stop(s_green)
release(s_green)
delete(lh)
clear lh
bias = data_green;
data_green = [];
tempData_green = [];
Start_Window
getkeywait(100)
close(Start_Window)

%% RUN EXPERIMENT CODE IN A LOOP

while (i == 0 )
    
  signal_place = L(k,1);            % the location of the signal (red or green)
     
  newstimuli                           % code to run experiment (signal etc.)
  
  %% check normal force component 
  
  force_red = convertForce(data_red,bias);
  force_green = convertForce(data_green,bias);

  av_normal_red = mean(abs(force_red(:,3)));
  av_lateral_red = mean(abs(force_red(:,1)));
  
  av_normal_green = mean(abs(force_green(:,3)));
  av_lateral_green = mean(abs(force_green(:,1)));
  
  % save average forces in arrays
  av_force_red_lateral = [av_force_red_lateral av_lateral_red];
  av_force_green_lateral = [av_force_green_lateral av_lateral_green];
  av_force_red_normal = [av_force_red_normal av_normal_red];
  av_force_green_normal = [av_force_green_normal av_normal_green];

  % check force violation
  if (av_normal_red >= 0.1 && av_normal_red <=0.6) && (av_normal_green >= 0.1 && av_normal_green <=0.6)
      normal_force_check = 1;       % there is no normal force violation  
  else   
      normal_force_check = 0;     % there is normal force violation
      av_total = mean(av_normal_red + av_normal_green);   
      if (av_total > 0.5)
         warning_sign = 1;   % violation force excessive normal force
      else
         warning_sign = 2;   % violation force less normal force 
      end  
  end
  
  %% check speed 
  %milad
  record_speed_red=[];
  record_speed_green=[];
  record_time_red=[];
  record_time_green=[];
  %end milad modification
  red_speed = newvel_calc(velo_red); 
  record_speed_red=loc;%milad
  record_time_red=loc_time;%milad
  
  green_speed = newvel_calc(velo_green);  
  
  record_speed_green=loc;%milad
  record_time_green=loc_time;%milad

  % save average speeds in arrays
  
  speed_red = [speed_red red_speed ];
  speed_green = [speed_green green_speed];
  
  % check speed violation
   if (red_speed >= 37.5 && red_speed <=62.5) && (green_speed >= 37.5 && green_speed <=62.5)
      speed_check = 1;    % there is no speed violation  
   else   
      speed_check = 0;  % there is a speed violation
      speed_total = mean(red_speed + green_speed);
%       if (speed_total> 60)
%          warning_sign = 3;   % violation speed excessive 
%       else
%          warning_sign = 4;   % violation speed less 
%       end  
  end
  
%% now adjust the amplitudes 

     % Correct Response
     if (decide == 1 && normal_force_check ==1 && speed_check == 1)   % subject gives correct response and there is not any violation
      
         correct  = correct+1;             % subject makes a correct choice
         normal_false = [];                % no normal force violation   
         speed_false = [];                 % no speed violation
         warning_sign = 0;                 % there is no violation
         
         if (correct == 3 && length(save_reversal) <1)           % subject makes 3 correct choices
                test_amp_next = test_amp_current/(10^(5/20)) ;   % decrease 5 dB (before first reversal)
                correct = 0;                                     % dogru cevaplar? s?f?rla
                action_new = 1; 
         elseif (correct == 3 && length(save_reversal) >= 1)     % subject makes 3 correct choices
                test_amp_next = test_amp_current/(10^(1/20)) ;   % decrease 1 dB  (after first reversal)
                correct = 0;                                     % dogru cevaplar? s?f?rla
                action_new = 1; 
         else
                test_amp_next = test_amp_current;                % subject does not make 3 correct choices, give same signal
         end

   % False Responses
      
     elseif (decide == 0 && normal_force_check ==1 && speed_check == 1)   % subject makes a false choice without any violation   
         %correct=0; %milad modification
         not_correct = 1;                                       % subject makes an incorrect choice
         normal_false = [];                                     % 
         speed_false = [];
         warning_sign = 0;

            if (length(save_reversal)<1)         
                 test_amp_next = test_amp_current*(10^(5/20)) ;                % increase 5 dB
                 not_correct = 0;
                 action_new = -1; 
            elseif (length(save_reversal)>=1)         
                 test_amp_next = test_amp_current*(10^(1/20)) ;                % increase 1 dB
                 not_correct = 0;
                 action_new = -1;
            end
         
     else
          test_amp_next = test_amp_current;                    % there is a violation
          
          if (normal_force_check == 0)
             normal_false = k;               % there is a normal force violation
             speed_false = [];
          elseif (speed_check == 0)
             speed_false = k;                % there is a speed violation
             normal_false = [];
          end
     end
    
    newSignal = testSignal*test_amp_next;   % amplitude of new signal
    
    %% Check stopping
    
    if (action_new*action_old < 0)
        reversal = k; 
        reversal_amp = test_amp_next;
    else
        reversal = [];
        reversal_amp = [];
    end
    
    %% Save results and go for next
    
    action_old = action_new;
    test_amp_current = test_amp_next;
    save_test_amp = [save_test_amp test_amp_next];
    save_reversal = [save_reversal reversal];
    save_normal = [save_normal normal_false];
    save_speed = [save_speed speed_false];
    user_reply = [user_reply reply];
    %milad
    save(['C:\Users\Milad\Google Drive\Milad_shared_folder\Data' '\' subject '_' experiment '_' num2str(test_dur) '_' num2str(test_freq) '_' num2str(trial) '\speed' num2str(k)],'record_speed_red','record_speed_green','record_time_red','record_time_green');
    save(['C:\Users\Milad\Google Drive\Milad_shared_folder\Data' '\' subject '_' experiment '_' num2str(test_dur) '_' num2str(test_freq) '_' num2str(trial) '\force_' num2str(k)],'force_red', 'force_green');
    save(['C:\Users\Milad\Google Drive\Milad_shared_folder\Data' '\' subject '_' experiment '_' num2str(test_dur) '_' num2str(test_freq) '_' num2str(trial) '\threshold_save'],'save_test_amp','save_reversal','save_normal','save_speed','k');

    k = k+1;
    data_red = [];
    tempData_red = [];
    data_green = [];
    tempData_green = [];
    loc_red = [];
    loc_time_red = [];
    loc_green = [];
    loc_time_green = [];
       
    % Stopping Part                 % stop after 20 trials in +- 1 dB
    if length(save_reversal) > 4
        
        E5 = (20*log10(save_test_amp(save_reversal(end-4))));
        E4 = (20*log10(save_test_amp(save_reversal(end-3))));
        E3 = (20*log10(save_test_amp(save_reversal(end-2))));
        E2 = (20*log10(save_test_amp(save_reversal(end-1))));
        E1 = (20*log10(save_test_amp(save_reversal(end))));
        
        check_reversal_array = [E1 E2 E3 E4 E5];
        stop_check = abs(max(check_reversal_array) - min(check_reversal_array));
       
        if ((stop_check)<=2)
            i = 1;
        end                            
    end
    
end

Finishing

save(['C:\Users\Milad\Google Drive\Milad_shared_folder\Data' '\' subject '_' experiment '_' num2str(test_dur) '_' num2str(test_freq) '_' num2str(trial) '\final']);

%% SHOW RESULTS

 number = 1:1:k;
 reversal_amp = [];
 
 for j = 1:length(save_reversal)
     reversal_amp = [save_test_amp(save_reversal)];
 end
 
  for j = 1:length(save_normal)
     reversal_normal= [save_test_amp(save_normal)];
  end
 
   for j = 1:length(save_speed)
     reversal_speed= [save_test_amp(save_speed)];
 end
  
 plot(number,(save_test_amp*50),'bx')
 hold on
 hold on
 plot(save_reversal,(reversal_amp*50), 'ro')
 hold on
plot(save_normal,(reversal_normal*50), 'ko')
 hold on
 plot(save_speed,(reversal_speed*50), 'go')
 xlabel('Trial')
 ylabel('Amplitude (V/50)')
 
 threshold_index_array = save_reversal(1, end-4: end);
 threshold_array = [];
 
 for h = 1:5
     threshold_array = [save_test_amp(threshold_index_array)]
 end
 
 threshold = mean(threshold_array)*50;
 
 %xlim([1 87])