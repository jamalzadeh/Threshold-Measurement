 number = 1:1:k;
 reversal_amp = [];

 reversal_speed = [];
 
 reversal_normal = [];
 
 for j = 1:length(save_reversal)
     reversal_amp = [save_test_amp(save_reversal)];
 end
 
  for j = 1:length(save_normal)
     reversal_normal= [save_test_amp(save_normal)];
  end
 
   for j = 1:length(save_speed)
     reversal_speed= [save_test_amp(save_speed)];
 end
  
 plot(number,(save_test_amp(1:end-1)),'bx')
 hold on
 plot(save_reversal,(reversal_amp), 'ro')
 hold on
 plot(save_normal,(reversal_normal), 'ko')
 hold on
plot(save_speed,(reversal_speed), 'go')
 xlabel('Trial')
 ylabel('Amplitude (V/50)')  

