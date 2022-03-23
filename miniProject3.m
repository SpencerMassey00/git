clear 
clc
close all

% connect arduino
a = arduino();

% define variables and call pressureSensor function
sampleTime = 300;
thresh = 3;
livePlot = false;
pauseTime = 0;
[data] = pressureSensor(a,sampleTime,thresh,livePlot,pauseTime);

% save pressureSensor output table to a csv in your data folder
writetable(data,'C:\Users\Spenc\Documents\GitHub\git\mini_project3(4).csv')

% plot voltage over time
figure
plot(data.time,data.voltage)

% calcuate data acqusition rate
fs = 0;

% calculate R2 using R1, Vin, and Vout
Vo = mean(data{:,2}.')
r2 = ((Vo) .* 100) ./ (5 - (Vo))



