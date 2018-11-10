function plotData_green(src,event)
    global tempData_green;
    global data_green 
    if(isempty(tempData_green))
         tempData_green = [];
     end
     %plot(event.TimeStamps, event.Data)
     tempData_green = [tempData_green;event.Data];
     data_green = tempData_green;
end