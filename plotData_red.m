function plotData_red(src,event)
    global tempData_red;
    global data_red 
    if(isempty(tempData_red))
         tempData_red = [];
     end
     %plot(event.TimeStamps, event.Data)
     tempData_red = [tempData_red;event.Data];
     data_red = tempData_red;
end