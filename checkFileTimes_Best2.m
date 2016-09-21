function [out1,out2,out3] = checkFileTimes_Best2(recentTimes,pastTimes)
% Method to make sure each of the most recent files in the matrix is not a
% duplicate


% Variable to keep track of the number of times this function has been
% called...it will automatically resent back to 0 when reaching 100
persistent functionRunCount;
if(isempty(functionRunCount))
    functionRunCount = 0;
end

% Variable to keep track how many PIs have been turned off since the start
% of the main program
persistent PiOffCount;
if(isempty(PiOffCount))
    PiOffCount = zeros(1,6);
end

% Persistent variables hold the values of past filetimes for off pis to be
% compared against new files
persistent oldPiOneFiles; 
persistent oldPiTwoFiles; 
persistent oldPiThreeFiles;
persistent oldPiFourFiles; 
persistent oldPiFiveFiles; 
persistent oldPiSixFiles; 

if(isempty(oldPiOneFiles))
    oldPiOneFiles = 0;
end
if(isempty(oldPiTwoFiles))
    oldPiTwoFiles = 0;
end
if(isempty(oldPiThreeFiles))
    oldPiThreeFiles = 0;
end
if(isempty(oldPiFourFiles))
    oldPiFourFiles = 0;
end
if(isempty(oldPiFiveFiles))
    oldPiFiveFiles = 0;
end
if(isempty(oldPiSixFiles))
    oldPiSixFiles = 0;
end

% Increments the function run number by 1
functionRunCount = functionRunCount+1; 
if(functionRunCount > 100)
    functionRunCount = 1;
end

% Necessary global functions for execution 
global sampleSize
global PiOne PiTwo PiThree PiFour PiFive PiSix


% Original PIs in use at program run time
persistent origPisOn
if(isempty(origPisOn))
    PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
    origPisOn = intersect([1:6],PisInUse);
end

% Current PIs which are in use
PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
currentPisOn = intersect([1:6],PisInUse);

% Function Members
reRunGrabRecent = false;
mustQuit = false;

% Test to see if we have all new files and can run another localization
% attempt
[r,c] = size(recentTimes);
% For each row of recent(PI)
for(i = 1:r)
    rowData = ~ismember(recentTimes(i,:),pastTimes(i,:));
    if(all(rowData))
        continueProgram = true;
    else
        continueProgram = false;
        break; % So we dont rewrite the bool True
    end
end



% Test to see if we need to turn a PI OFF
if(rem(functionRunCount,5) == 0)                   
    [MR,MC] = size(recentTimes);
    % For every row (PI)
    for(nn = 1:MR)
        if(all(ismember(recentTimes(nn,:),pastTimes(nn,:))))
            PiOffCount(currentPisOn(nn)) = PiOffCount(currentPisOn(nn))+1;
        end
        for(jj = 1:numel(PiOffCount))
            if(PiOffCount(jj) > 5)
                switch jj
                    case 1
                        PiOne = 0;
                        oldPiOneFiles = recentTimes(nn,:);
                        PiOffCount(1) = 0;
                        reRunGrabRecent = true;
                        fprintf('Just Shut Down PI 1\n')
                    case 2
                        PiTwo = 0;
                        oldPiTwoFiles = recentTimes(nn,:);
                        PiOffCount(2) = 0;
                        reRunGrabRecent = true;
                        fprintf('Just Shut Down PI 2\n')
                    case 3
                        PiThree = 0;
                        oldPiThreeFiles = recentTimes(nn,:);
                        PiOffCount(3) = 0;
                        reRunGrabRecent = true;
                        fprintf('Just Shut Down PI 3\n')
                    case 4
                        PiFour = 0;
                        oldPiFourFiles = recentTimes(nn,:);
                        PiOffCount(4) = 0;
                        reRunGrabRecent = true;
                        fprintf('Just Shut Down PI 4\n')
                    case 5
                        PiFive = 0;
                        oldPiFiveFiles = recentTimes(nn,:);
                        PiOffCount(5) = 0;
                        reRunGrabRecent = true;
                        fprintf('Just Shut Down PI 5\n')
                    case 6
                        PiSix = 0;
                        oldPiSixFiles = recentTimes(nn,:);
                        PiOffCount(6) = 0;
                        reRunGrabRecent = true;
                        fprintf('Just Shut Down PI 6\n')
                end
            end
        end
    end
end


% Test to see if we should turn an OFF, PI back ON
numPisOff = numel(origPisOn) - numel(currentPisOn)
if((numPisOff > 0) && (rem(functionRunCount,5) == 0))
    missingPis = ismember(origPisOn,currentPisOn);
    PiNumsOff = find(~missingPis); % looks for indices zeros(Actual PI number) 
    for(xx = 1:numel(PiNumsOff))
        switch PiNumsOff(xx)
            case 1
                PiOne = 1;
                [a,b,files] = grabRecent(sampleSize);
                if(all(ismember(oldPiOneFiles,files)))
                    PiOne = 0; % Keep it off
                else
                    reRunGrabRecent = true;
                end
            case 2
                PiTwo = 1;
                [a,b,files] = grabRecent(sampleSize);
                if(all(ismember(oldPiTwoFiles,files)))
                    PiTwo = 0; % Keep it off
                else
                    reRunGrabRecent = true;
                end
            case 3
                PiThree = 1;
                [a,b,files] = grabRecent(sampleSize);
                if(all(ismember(oldPiThreeFiles,files)))
                    PiThree = 0; % Keep it off
                else
                    reRunGrabRecent = true;
                end
            case 4
                PiFour = 1;
                [a,b,files] = grabRecent(sampleSize);
                if(all(ismember(oldPiFourFiles,files)))
                    PiFour = 0; % Keep it off
                else
                    reRunGrabRecent = true;
                end
            case 5
                PiFive = 1;
                [a,b,files] = grabRecent(sampleSize);
                if(all(ismember(oldPiFiveFiles,files)))
                    PiFive = 0; % Keep it off
                else
                    reRunGrabRecent = true;
                end
            case 6
                PiSix = 1;
                [a,b,files] = grabRecent(sampleSize);
                if(all(ismember(oldPiSixFiles,files)))
                    PiSix = 0; % Keep it off
                else 
                    reRunGrabRecent = true;
                end
        end
    end
end

% Test to see if we should no longer be running the program...commented out
% now so it wont quit MATLAB
%=====*****************************************************
%***************************************************=======
%{
if(numel(currentPisOn) < 3)
    fprintf('Too many RPIs down...Must Terminate\n')
    mustQuit = true;
end
%}
fprintf('CHECK FILE COUNT:  %d\n',functionRunCount)
out1 = continueProgram;
%==========================================================================
%                           ***** FIX BACK *****
%==========================================================================
out2 = reRunGrabRecent;
out3 = mustQuit;
end

