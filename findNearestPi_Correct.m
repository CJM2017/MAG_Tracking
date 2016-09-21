function [ClosestPIs,waypoints] = findNearestPi_Correct(nbrStruct, distMat)
% This method will receive the struct of neighbors 
% Arg 2 is a matrix of distances between WPs and PIs to find the closest PI
% to each WP (which is a neighbor to the beacon (#rows)
% This will allow us to use the appropriate nVal and noise values to convert 
% RSSI -> Distance

global PiOne PiTwo PiThree PiFour PiFive PiSix

% Replace zeros with 1000 (inches)
[r,c] = size(distMat);
for(i = 1:r)
    for(j = 1:c)
        if(distMat(i,j) == 0)
            distMat(i,j) = 1000; % otherwise the zero val is the slectecd minimum
        end
    end
end

% Vectors to contain the function results
closestPiMat = [];
waypointMatrix = [];
PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
PIvec = intersect([1:6],PisInUse);

% Find the closest PI to the specified neighbor
numBcns = numel(fieldnames(nbrStruct));
% For each beacon 
for(i = 1:numBcns)
    fname = sprintf('B%d',i);
    loopDistMat = distMat;
    dataMatrix = [];
    % For each of the 3 nbrs
    for(k = 1:numel(nbrStruct.(fname)))
        aNbr = nbrStruct.(fname){k};
        switch aNbr
            case 'WP1'
                WPnum = 1;
            case 'WP2'
                WPnum = 2;
            case 'WP3'
                WPnum = 3;
            case 'WP4'
                WPnum = 4;
            case 'WP5'
                WPnum = 5;
            case 'WP6'
                WPnum = 6;
            case 'WP7'
                WPnum = 7;
            case 'WP8'
                WPnum = 8;
            case 'WP9'
                WPnum = 9;
            case 'WP10'
                WPnum = 10;
            case 'WP11'
                WPnum = 11;
            case 'WP12'
                WPnum = 12;
            case 'WP13'
                WPnum = 13;
            case 'WP14'
                WPnum = 14;
            case 'WP15'
                WPnum = 15;
            case 'WP16'
                WPnum = 16;
            case 'WP17'
                WPnum = 17;
            case 'WP18'
                WPnum = 18;
            case 'WP19'
                WPnum = 19;
            case 'WP20'
                WPnum = 20;
            case 'WP21'
                WPnum = 21;
            case 'WP22'
                WPnum = 22;
            case 'WP23'
                WPnum = 23;
            case 'WP24'
                WPnum = 24;
            case 'WP25'
                WPnum = 25;
            case 'WP26'
                WPnum = 26;
            case 'WP27'
                WPnum = 27;
            case 'WP28'
                WPnum = 28;
            case 'WP29'
                WPnum = 29;
            case 'WP30'
                WPnum = 30;
            case 'WP31'
                WPnum = 31;
            case 'WP32'
                WPnum = 32;
        end 
        %waypointMatrix(i,k) = WPnum;
        [minVal,I] = min(loopDistMat(WPnum,:)); 
        dataMatrix = vertcat(dataMatrix,[PIvec(I),minVal,WPnum]);
        % Change
        loopDistMat(WPnum,I) = 1000;
    end
    
    % Below, we make sure that no PI is chosen more than once for each
    % beacon
    dataMatrix = sortrows(dataMatrix,2); % Second arg refers to the column
    waypointMatrix(i,:) = dataMatrix(:,3);
    closestPiMat(i,1) = dataMatrix(1,1);
    closestPiMat(i,2) = dataMatrix(2,1);

    if(numel(PIvec) > 3)
        while(closestPiMat(i,2) == closestPiMat(i,1))
            [minVal,I] = min(loopDistMat(dataMatrix(2,3),:)); % For said WP
            closestPiMat(i,2) = PIvec(I);
            loopDistMat(dataMatrix(2,3),I) = 1000; % So it cannot be chosen again
        end

        closestPiMat(i,3) = dataMatrix(3,1);
        while((closestPiMat(i,3) == closestPiMat(i,1)) || (closestPiMat(i,3) == closestPiMat(i,2)))
            [minVal,I] = min(loopDistMat(dataMatrix(3,3),:));
            closestPiMat(i,3) = PIvec(I);
            loopDistMat(dataMatrix(3,3),I) = 1000;   
        end

        % Prevent selection of 3 PIs which are in a column (BI)
        while((numel(intersect(closestPiMat(i,:),[4,5,6])) == 3) || (closestPiMat(i,3) == closestPiMat(i,1)) || (closestPiMat(i,3) == closestPiMat(i,2)))
            [minVal,I] = min(loopDistMat(dataMatrix(3,3),:));
            closestPiMat(i,3) = PIvec(I);
            loopDistMat(dataMatrix(3,3),I) = 1000; 
        end
    end
end
ClosestPIs = closestPiMat;
waypoints = waypointMatrix;
end