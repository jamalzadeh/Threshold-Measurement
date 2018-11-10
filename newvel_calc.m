function speed = vel_calc(velo) 
%385>>1000 whole glass range
%563>>790 middle area

    global loc loc_time;%milad
    loc= velo(1,:);
     loc=loc+1440;
    loc= (loc*212)/1440; %212 mm IR frame length, 1444: pixel number
    
    clock_hour = velo(5,:).*36000000;
    clock_min = velo(6,:).*600000;
    clock_sec = velo(7,:).*10000;  
    loc_time = (clock_min+clock_sec+clock_hour)-(clock_min(1)+clock_sec(1)+clock_hour(1)); %ilk datanýn saniyesini sýfýrla
    loc_time = loc_time./10000; %saniyenin onda biri

    in_loc = length(loc);
 
    in_loc_time = length(loc_time);
    Xmax=max(loc);
    Xmin=min(loc);
    MaxIndex = find(loc>=Xmax,1,'first');
    MinIndex = find(loc<=Xmin,1,'last');
    StartIndex=floor(MinIndex+(MaxIndex-MinIndex)/4);
    EndIndex=floor(MaxIndex-(MaxIndex-MinIndex)/4);
    speed = abs((loc(EndIndex)-loc(StartIndex))/(loc_time(EndIndex)-loc_time(StartIndex)));  