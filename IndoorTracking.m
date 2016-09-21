function IndoorTracking()
% Find beacon location based on its signal
clc; home;
close all hidden
clear;
addpath(genpath('D:/Oleg/Work/MyMatlabFunctions'));

% Load data file
Data = xlsread('BBX3_Model_View.xlsx');

% Prepare test datasets
row0 = 3;
V = Data(row0:end, 2);
X = Data(row0:end,4:end);   
Xq = Data(row0-1, 4:end);

% Run test interpolation
[Vq, Ebest, nFbest] = OM_Interpolate(Xq, V, X);


return;




