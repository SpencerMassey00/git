clear 
clc

%% Opening the trials
object1 = readtable('mini_project3(1).csv');
t1 = object1{:,1}.';
y1 = object1{:,2}.';

object2 = readtable('mini_project3(2).csv');
t2 = object2{:,1}.';
y2 = object2{:,2}.';

object3 = readtable('mini_project3(3).csv');
t3 = object3{:,1}.';
y3 = object3{:,2}.';

object4 = readtable('mini_project3(4).csv');
t4 = object4{:,1}.';
y4 = object4{:,2}.';

object5 = readtable('mini_project3(5).csv');
t5 = object5{:,1}.';
y5 = object5{:,2}.';

object6 = readtable('mini_project3(6).csv');
t6 = object6{:,1}.';
y6 = object6{:,2}.';
%% Plotting Trials
sample = readtable('breathing.csv');
t7 = sample{:,1}.';
y7 = sample{:,2}.';

range1 = find(t7 > 120);
range2 = find(
range1(1)
t7(range1(1))
