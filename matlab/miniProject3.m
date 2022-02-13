clear 
clc
close all

% connect arduino
a = arduino();

% define variables and call pressureSensor function
sampleTime = 10;
thresh = 3;
livePlot = true;
pauseTime = 0;
[data] = pressureSensor(a,sampleTime,thresh,livePlot,pauseTime);

% save pressureSensor output table to a csv in your data folder
writetable(data,'C:\Users\Spenc\Desktop\mini_project3.csv')

% plot voltage over time
figure
plot(data.time,data.voltage)

% calcuate data acqusition rate
fs = 0;
print(len(data))

% calculate R2 using R1, Vin, and Vout
r2 = 0;