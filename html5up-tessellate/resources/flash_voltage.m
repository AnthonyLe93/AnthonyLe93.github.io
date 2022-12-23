
% setting up the DAQ and electrolyse water
d = daq.getDevices;
d(1)
s = daq.createSession('ni');

% Set up input channels
ch1 = addAnalogInputChannel(s,'Dev1', 1, 'Voltage');        % scan signal from channel 1 (load cell)
ch1.TerminalConfig = 'SingleEnded'; 

ch2 = addAnalogInputChannel(s,'Dev1', 2, 'Voltage');        % scan signal from channel 2 (input voltage)
ch2.TerminalConfig = 'SingleEnded';

ch3 = addAnalogInputChannel(s,'Dev1', 3, 'Voltage');        % scan signal from channel 3 (input current) 
ch3.TerminalConfig = 'SingleEnded';

ch4 = addAnalogInputChannel(s,'Dev1', 4, 'Voltage');        % scan signal from channel 4 (spark voltage) 
ch4.TerminalConfig = 'SingleEnded';

% Set up output channels
ch5 = addAnalogOutputChannel(s,'Dev1', 0, 'Voltage');       % Voltage reference for electrolysis
t = 0:0.0001:10;                                            % Time of the experiment 70s
w1 = 60;                                                    % Electrolysis time 60(s)
Set_Voltage = 5;
output_voltage_elec = (Set_Voltage * rectpuls(t - 33, w1)');         
                                                            % -33 for 60s after 3s  

ch6 = addAnalogOutputChannel(s,'Dev1', 1, 'Voltage');       % Voltage to drive sparker
w2 = 1;
output_voltage_spark = (5 * rectpuls(t - 68.5, w2)');      % Amplitude of 5V run at second 68th for 1s/ 68.5

queueOutputData(s,[output_voltage_elec,output_voltage_spark]);



%s.DurationInSeconds = 10;                                  % set ni daq run time in seconds
s.Rate = 10000;                                             % scan X time/s
 
   
[data,time] = s.startForeground;                            % Multiple scans 
X = lowpass(data(:,1),20,10000);                            % Filter out loadcell resonance
% Max_Value = max(data(:,1));
Max_Value_filter = max(X);

%% Plot data
fig = figure(1);
subplot(2,2,1);
plot(time,data(:,1));                                       %Plotting load cell data
xlim([67 69]);
xlabel('Time (secs)');
ylabel('Voltage of Loadcell');
% hold on;
% plot(time,X);
% hold off;

subplot(2,2,2);
plot(time,data(:,2));                                       %Plotting votage only
xlabel('Time (secs)');
ylabel('Voltage of Electrolysis (V)');

subplot(2,2,3);
plot(time,data(:,3));                                       %Plotting current only
xlabel('Time (secs)');
ylabel('Current for Electrolysis (A)');

subplot(2,2,4);
plot(time,data(:,4));                                       %Plotting spark voltage only
xlabel('Time (secs)');
ylabel('Voltage of Spark (V)');

% save('Sample2_rawdata_freq.mat', 'data');
% save('Sample2_rawdata_time.mat', 'time');
% saveas(fig,'Results_Sample2_freq.fig');
% save('Vertical_test1_60s.mat', 'data');
% save('Vertical_test_time_60s.mat', 'time');
% saveas(fig,'Vertical_test_plot_60s.fig');

%% 
% % Impulse = sum(data(x:y,1));                               % Sum different values in a column
% average_current = sum(data(30000:1800000,3) / (10000*180));
% Sum_of_force = sum(data(2450000:2460000,1)/ (10000*1));
% Average_voltage = sum(data(:,1))/10000;
% Average_Current = sum(data(30000:630000,3))/(10000*60);
