function speed = vel_calc(velo) 
%385>>1000 whole glass range
%563>>790 middle area

    global loc loc_time;%milad
    loc= velo(1,:);
    
    newloc=[];
    newvelo=[];
    if max(loc)>=700 && loc(1,1)<400 %this means we have started from left and moved to the right side
    for j=1:length(loc)
        if loc(1,j)>=800
            
            newloc=loc(1,1:j);
            newvelo=velo(:,1:j);
            break
        end
    end
    loc=newloc;
    velo=newvelo;
    end
    
    loc=loc+1440;
    loc= (loc*212)/1440; %212 mm IR frame length, 1444: pixel number
    
    clock_hour = velo(5,:).*36000000;
    clock_min = velo(6,:).*600000;
    clock_sec = velo(7,:).*10000;  
                     
    loc_time = (clock_min+clock_sec+clock_hour)-(clock_min(1)+clock_sec(1)+clock_hour(1)); %ilk datanýn saniyesini sýfýrla
    loc_time = loc_time./10000; %saniyenin onda biri

    in_loc = length(loc);
 
    in_loc_time = length(loc_time)
  

  speed = abs((loc(in_loc-floor(in_loc/4))-loc(floor(in_loc/4)))/(loc_time(in_loc_time-floor(in_loc_time/4))-loc_time(floor(in_loc_time/4))));  