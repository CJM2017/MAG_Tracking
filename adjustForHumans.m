function out1 = adjustForHumans(estPositions,closestPIs,WPs,trilatDists,nVals)
% estPositions is a struct where each fielname is the tage ID for one of
% the beacons
% TrilatDists is a matrix where each row corresponds to the distance
% between a PI and the corresponding RSSI -> Distance calculation

% Pi Coordinates
global locPiOne locPiTwo locPiThree... 
       locPiFour locPiFive locPiSix
   
global PiOne PiTwo PiThree...
       PiFour PiFive PiSix
   
numBcns = numel(fieldnames(estPositions));
distErrors = [];
% For each Beacon
for(i = 1:numBcns)
    fname = sprintf('B%d',i);
    BX = estPositions.(fname)(end,1);
    BY = estPositions.(fname)(end,2);
    [r,c] = size(closestPIs);
    for(j = 1:c)
        thisPI = closestPIs(i,j);
        switch thisPI
            case 1
                PX = locPiOne(1);
                PY = locPiOne(2);
            case 2
                PX = locPiTwo(1);
                PY = locPiTwo(2);
            case 3
                PX = locPiThree(1);
                PY = locPiThree(2);
            case 4
                PX = locPiFour(1);
                PY = locPiFour(2);
            case 5
                PX = locPiFive(1);
                PY = locPiFive(2);
            case 6
                PX = locPiSix(1);
                PY = locPiSix(2);
        end
        estDist = sqrt(((PX-BX)^2)+((PY-BY)^2)); % Inches
        distErrors(i,j) = (estDist-trilatDists(i,j))/12; % Feet
        % If the error is positive(+) then the trilateration distance is
        % falling short of the distance to the estimated location but if
        % the error is negative(-), then the trilateration distance over
        % shoots the distance to the estimated location.
        % Positive(+): decrease the n value to increase the trilat distance
        % Denative(-): increase the n value to decrease the trilat distance
    end
end

distErrors
PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
PIvec = intersect([1:6],PisInUse);

[r,c] = size(distErrors);
% For each Beacon
for(i = 1:r)
    % For each distance Error
    for(j = 1:c)
        thePI = closestPIs(i,j);
        for(k = 1:numel(PIvec))
            if(thePI == PIvec(k))
                nValIdx = k;
                break;
            end
        end
        theWP = WPs(i,j);
        if(distErrors(i,j) > 0)
            nVals(theWP,nValIdx) = nVals(theWP,nValIdx) - 0.2;
        else
            nVals(theWP,nValIdx) = nVals(theWP,nValIdx) + 0.2;
        end
    end
end
out1 = nVals;   
end
