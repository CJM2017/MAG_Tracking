function [out1,out2,out3,out4] = calibratePathLossExp_Fix(WPstruct,PiWpDist,vecRSSI,RSSI_0)
% Method to scan each WP from each PI in order to calibrate the path loss exponent
% (N) and minimize the distance errors derived from RSSI signals
% out1: all PLEs (N) for each WP for each PI
% out2: matrix of WP distances from each PI derived from RSSI -> Feet 
% out3: matrix of distance errrors after optimization 
% out4: estimated noise from variance of 1 meter calibration 

global PiOne PiTwo PiThree...
       PiFour PiFive PiSix
 
global pathLossExpRange valToReplaceZero
   
% Calibrate the WPs
    PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
    PIvec = intersect([1:6],PisInUse);
    numPIs = numel(PIvec);
    numWPs = numel(fieldnames(WPstruct)); % Arg_1
    
    % Set true to plot distance errors from nVals
    pleasePlot = false; 
    
    % Data to be extracted and saved
    errorsAfterN = [];
    nVals = [];
    distances = [];
    n = 2;
    
    % For each PI
    flag = false;
    for(i = 1:numPIs);
        n = 2;
        noise = 2.0*var(vecRSSI); % Still have the option to tweak 
        flagRSSI = false;
        % For each WP in the room 
        for(j = 1:numWPs)
            fname = sprintf('WP%d',j);
            liveRSSI = WPstruct.(fname)(i);
            % WPs which cannot be seen by a PI (0 RSSI)
            if(liveRSSI == 0)
                liveRSSI = valToReplaceZero; 
                flagRSSI = true; % Flags the condition below
            end
            
            % Minimization 
            knownDist = PiWpDist(PIvec(i),j); % Arg_2
            distError =@(n)abs(knownDist - (40*10^((1/(10*n))*(RSSI_0 - liveRSSI + noise))));
            [optNval,errorVal] = fminbnd(distError,0,pathLossExpRange); % WHAT IS THE MAX VALUE I SHOULD ACTUALLY ALLOW ?
            errorsAfterN(j,i) = errorVal/12; % units: Feet
            nVals(j,i) = optNval;
            % ------------------***04 Aug 2016***--------------------------
            if(flagRSSI)
                %nVals(j,i) = 0;
                %flagRSSI = false;
            end
            %--------------------------------------------------------------
            distances(j,i) = (40*10^((1/(10*optNval))*(RSSI_0 - liveRSSI + noise)));
        end
    end
    
    % Plotting
    if(pleasePlot)
        figure
        for(i = 1:numel(PisInUse))
            subplot(numel(PisInUse),1,i)
            bar([1:numWPs],errorsAfterN(:,i))
            ylim([0,8])
            plotTitle = sprintf('PI_%d',i);
            title(plotTitle)
            xlabel('WPs')
            ylabel('Dist. Error')
        end
    end
    out1 = nVals;
    out2 = distances;
    out3 = errorsAfterN;
    out4 = noise;
end