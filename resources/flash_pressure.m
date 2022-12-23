% setting up the DAQ and electrolyse water
d = daq.getDevices;
d(1)
s = daq.createSession('ni');

% Set up input channels
ch1 = addAnalogInputChannel(s,'Dev1', 1, 'Voltage');        % scan signal from channel 1 (Pressure sensor)
ch1.TerminalConfig = 'SingleEnded'; 

ch2 = addAnalogInputChannel(s,'Dev1', 2, 'Voltage');        % scan signal from channel 2 (Input voltage)
ch2.TerminalConfig = 'SingleEnded';

ch3 = addAnalogInputChannel(s,'Dev1', 3, 'Voltage');        % scan signal from channel 3 (Input current) 
ch3.TerminalConfig = 'SingleEnded';

ch4 = addAnalogInputChannel(s,'Dev1', 4, 'Voltage');        % scan signal from channel 4 (Pressure sensor voltage) 
ch4.TerminalConfig = 'SingleEnded';

% Set up output channels
ch5 = addAnalogOutputChannel(s,'Dev1', 0, 'Voltage');       % Voltage reference for electrolysis
t = 0:0.0001:70;                                             % Time of the experiment 70s
w1 = 60;                                                    % Electrolysis time 60(s)
Set_Voltage = 9;
output_voltage_elec = (Set_Voltage * rectpuls(t - 33, w1)'); % -33 for 60s after 3s 

ch6 = addAnalogOutputChannel(s,'Dev1', 1, 'Voltage');       % Voltage to run pressure sensor
w2 = 62;
output_voltage_PressureSensor = (5 * rectpuls(t - 33, w2)');         % Amplitude of 5V run at second for 62s

queueOutputData(s,[output_voltage_elec,output_voltage_PressureSensor]);                                                       

%s.DurationInSeconds = 10;                                  % set ni daq run time in seconds
s.Rate = 10000;                                             % scan X time/s
[data,time] = s.startForeground;                            % Multiple scans 


%% Plot data
fig = figure(1);
subplot(2,2,1);
plot(time,data(:,1));                                       %Plotting Pressure sensor data
xlabel('Time (secs)');
ylabel('Voltage of Pressure Sensor');


subplot(2,2,2);
plot(time,data(:,2));                                       %Plotting Electrolysis Votage only
xlabel('Time (secs)');
ylabel('Voltage of Electrolysis (V)');

subplot(2,2,3);
plot(time,data(:,3));                                       %Plotting Electrolysis Current only
xlabel('Time (secs)');
ylabel('Current for Electrolysis (A)');

subplot(2,2,4);
plot(time,data(:,4));                                       %Plotting voltage to run pressure sensor only
xlabel('Time (secs)');
ylabel('Voltage to run pressure sensor (V)');

save('PS_9V_60s.mat', 'data');
save('PS_9V_time.mat', 'time');
saveas(fig,'Results_9V.fig');
