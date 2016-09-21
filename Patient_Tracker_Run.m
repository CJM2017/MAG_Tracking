%==========================================================================
% Name    : Patient Tracker Program
% Company : MAG
% Author  : Connor McCann
% Date    : 18 Jul 2016
%==========================================================================

% Setting up the environment
clear
clear checkFileTimes_Best               % For the persistent variables
format long g
pause(2)

% Configure the environment further
Patient_Tracker_Config;                 % Sets all of the necessary variables 

firstRun = true;
samplesToOpen = sampleSize;

% Data Collection Vars
ErrorMat = [];                          % Found in Patient_Tracker
solsMat = [];                           % Found in Patient_Tracker
firstProgramRun = true;                 % Found in Patient_Tracker
storePastFiles = true;                  % Found in Patient_Tracker

%==========================================================================
%                           Program Start/Loop
%==========================================================================
if(runCtd)
    while(true)
        Patient_Tracker
        fprintf('pausing...\n')
        pause(5)                % seconds
    end
else
    Patient_Tracker
end  
%==========================================================================
%                               Program End
%==========================================================================

