%==========================================================================
% Name    : Dynamic Path Loss Localization Script
% Company : MAG
% Author  : Connor McCann
% Date    : 29 Jun 2016
%==========================================================================

             

%==========================================================================
%                            Main Program Loop
%==========================================================================
    
% Get the most recent data
[waypoints,beacons,fileTimes] = grabRecent(samplesToOpen);

% Start File Checking--------------------------------------------------
% *** Some of these variables are located at the start of P_T_run.m ***
if(~firstProgramRun)
    [keepGoing,grabFilesAgain,mustQuit] = checkFileTimes_Best2(fileTimes,previousFiles);
    
    % Do we need to quit the program?
    if(mustQuit)
        return
    end
    
    % Get the most recent data since a PI was turned back on
    if(grabFilesAgain)
        [waypoints,beacons,fileTimes] = grabRecent(samplesToOpen);
        previousFiles = fileTimes; 
    end
    
    % Storing previous files for checking
    if(keepGoing)
        storePastFiles = true;
    end
    fprintf('checking...\n')
else
    firstProgramRun = false;
    keepGoing = true;
end

% Starts (true) in PT_run.m File
if(storePastFiles) 
    previousFiles = fileTimes;
    storePastFiles = false;
    fprintf('Just Saved Past Files\n')
end
% End File Checking----------------------------------------------------

if(keepGoing)
    
    % Grab file time data for website update string
    %fileTimeForWebsite = datestr(fileTimes(1,1));
    %fid = fopen('C:\Users\cj836\Documents\Visual Studio 2012\Projects\Patient_Tracker\Patient_Tracker\App_Data\websiteData.csv','w');
    %fprintf(fid,'%s\n',fileTimeForWebsite);
    %fclose(fid);
    
    % Waypoints
    [avgWps,countWP] = avgFilterWP(waypoints);
    WPstruct = buildWPstruct(avgWps);

    % Beacons
    [avgBcns,countBCN] = avgFilterBCN(beacons);
    BCNstruct = buildBCNstruct(avgBcns);

    % Finding neighbors
    nbrsRSSI = findNN_RSSI(WPstruct,BCNstruct);
    nbrsCount = findNN_Count(countWP,countBCN);
    combNbrs = chooseClosestNbrs(nbrsRSSI,nbrsCount);

    % Calculating Distance matrix
    PiWpDist = calcDist(WPstruct);

    % Measuring Distance from RSSI Path Loss
    [vecRSSI,RSSI_0] = oneMeterCal();

    % Calibrate the WPs
    [nVals,distances,errorsAfterN,noise] = calibratePathLossExp_FIX(WPstruct,PiWpDist,vecRSSI,RSSI_0);

    % Find the PI which is closest to each neighbor (3)
    [closestPiMat,theWPs] = findNearestPi_Correct(nbrsRSSI,distances); % *** nbrsRSSI Orig ***

    % Build the N-value matrix for each beacon
    [solution,ErrorVec,trilatDists] = Localize_Nbrs(closestPiMat,nVals,BCNstruct,theWPs,RSSI_0,noise,PiWpDist');

    % Dyanmic Localization based on Error
    secClosestPiMat = choosePiByStrength(BCNstruct);
    [secSolution,secErrorVec,secTrilatDists] = Localize_Fix(secClosestPiMat,nVals,BCNstruct,theWPs,RSSI_0,noise);
    numE = numel(ErrorVec);
    for(nn = 1:numE)
        fname = sprintf('B%d',nn);
        solution.(fname) = 0.5*secSolution.(fname)+0.5*solution.(fname); % Taking the avg
    end
    
    % Calculating the NEW correct ERROR 
    bcnNUM = numel(fieldnames(solution));
    for(kk = 1:bcnNUM)
        fname = sprintf('B%d',kk);
        Xpos = solution.(fname)(1);
        Ypos = solution.(fname)(2);
        switch fname
            case 'B1'
                toCompare = locBCN1;
            case 'B2'
                toCompare = locBCN2;
            case 'B3'
                toCompare = locBCN3;
            case 'B4'
                toCompare = locBCN4;
            case 'B5'
                toCompare = locBCN5;
        end
        ErrorVec(kk) = (sqrt((Xpos - toCompare(1))^2 + (Ypos-toCompare(2))^2))/12;
    end
    
    % Stacking the solution and error vecs into matrices
    [solsMat,ErrorMat,firstRun] = stackResults(solution,BCNstruct,...
                                      ErrorVec,firstRun,...
                                      solsMat,ErrorMat);
    
                                  
                                  
    % Determine if we want to keep the estimated poistion 
    %posFromNbrs = locationFromNbrs(theWPs);
    %[solsMat,ErrorMat] = evalEstimation(solsMat,posFromNbrs,ErrorMat);
    
    %----------------------------------------------------------------------
    %                           NEW 9/21/2016
    %----------------------------------------------------------------------
    [POS,ERR] = location_refine1(secClosestPiMat,nVals,BCNstruct,theWPs,RSSI_0,noise)
    
    
    
    [numRUNS,~] = size(ErrorMat);
    fprintf('the %d program run\n',numRUNS)
                                
    % Determining which ROOM the Patient is in
    room = findRoom(solsMat);
    Patients = {};
    Locations = {};
    for(ii = 1:numel(fieldnames(room)))
        fname = sprintf('P%d',ii);
        name = sprintf('Patient-%d',ii);
        Patients{ii} = name;
        Locations{ii} = room.(fname);
    end
    
    % Grabing data for website location table
    %locationTable = table;
    %locationTable.Patient = Patients';
    %locationTable.Location = Locations';
    %writetable(locationTable,'C:\Users\cj836\Documents\Visual Studio 2012\Projects\Patient_Tracker\Patient_Tracker\App_Data\Patient_Position.csv')
    
    % Visualizing the results (mapFloor_BI) for alternative view
    if(mapWithFloorPlan)
        mapFloor_BI(solsMat,ErrorMat,trilatDists,closestPiMat) % Plots the most recent iteration ***
    else
        mapFloor(solsMat,ErrorMat,trilatDists,closestPiMat) 
    end
    
    if(evalErrors)
        evalTrackingErrors(ErrorMat);
    end
% Condition when waiting on new files to be uploaded
else
    fprintf('No update: lacking new files\n')
    
    % Send website PI status
    %fid = fopen('C:\Users\cj836\Documents\Visual Studio 2012\Projects\Patient_Tracker\Patient_Tracker\App_Data\PiStatus.csv','w');
    %fprintf('%d,%d,%d,%d,%d,%d\n',PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix);
    %fclose(fid);
    %mapFloor_BI_PIstatus()
end
   


    









