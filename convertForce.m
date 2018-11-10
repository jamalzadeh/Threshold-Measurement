function forceV = convertForce(data,bias)

fs = 10000;

% data_1, data_2, data_3, data_4, data_5, data_6 voltage COLUMNS!!! PLEASE
% ARRANGE YOUR DATA ACCORDINGLY
data_1=data(:,1);
data_2=data(:,2);
data_3=data(:,3);
data_4=data(:,4);
data_5=data(:,5);
data_6=data(:,6);

bias_1=bias(:,1);
bias_2=bias(:,2);
bias_3=bias(:,3);
bias_4=bias(:,4);
bias_5=bias(:,5);
bias_6=bias(:,6);

% remove initial mean for bias
bias1_mean = mean(bias_1(1:100));
bias2_mean = mean(bias_2(1:100));
bias3_mean = mean(bias_3(1:100));
bias4_mean = mean(bias_4(1:100));
bias5_mean = mean(bias_5(1:100));
bias6_mean = mean(bias_6(1:100));

data1 = data_1-bias1_mean;
data2 = data_2-bias2_mean;
data3 = data_3-bias3_mean;
data4 = data_4-bias4_mean;
data5 = data_5-bias5_mean;
data6 = data_6-bias6_mean;


% convert voltages to forces 
voltages = [data1 data2 data3 data4 data5 data6];
voltages= transpose(voltages);
forceV = convertVtoF(voltages)';

% f_x = forceV(:,1);
% f_y = forceV(:,2);
% f_z = forceV(:,3);
% 
% len = length(f_y);
% t = 0:1/fs:(len-1)/fs;