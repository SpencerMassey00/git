clear 
clc

sample = readtable('breathing.csv');
t7 = sample{:,1}.';
y7 = sample{:,2}.';

time = t7;
resp = y7;
x = 30;
range1 = find(time > x);
            range2 = find(time > (x + 30));
            resp = resp(range1(1):range2(1));
            time = time(range1(1):range2(1));
        
        