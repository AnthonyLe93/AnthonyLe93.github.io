%% setting up the DAQ
d = daq.getDevices;
d(1)
release(s1)
s = daq.createSession('ni');
ch = addAnalogInputChannel(s,'Dev1', 1, 'Voltage') % scan signal from channel 1
ch.TerminalConfig = 'SingleEnded'; 
s.DurationInSeconds = 10; % set ni daq run time
s.Rate = 10000; % scan X time/s
%data = s.inputSingleScan % one scan

%% Preallocate space for results
 force_results = [];
 voltage_results = [];
 
 %% Run experiment multiple times and saving data
 
    figure(1)
    [data,time] = s.startForeground; % Multiple scans
    plot(time,data, '-x'); % plot the scanned data
    xlabel('Time (secs)');
    ylabel('Voltage');
%     offset = 0.1882; % voltage at zero load
%     average_voltage = (sum(data) / (s1.Rate*s1.DurationInSeconds)) - offset; % devided by the scanning rate
%     weight = average_voltage / 1.1376; % calculate weight from voltage
%     force = weight * 9.8; % Newton
%     
%     force_results = [force_results, force];
%     voltage_results = [voltage_results, average_voltage];
    Average_voltage = sum(data(:,1))/10000;
%% Max value and max force
% Min_Value = min(data);
% Max_Value = max(data);
%  
%% plot data

% figure(2)
% plot(voltage_results, force_results, '-x', 'MarkerSize', 10);
% xlabel('Voltage (V)');
% ylabel('Force (N)');

%%
