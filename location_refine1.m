function [out1,out2] = location_refine1(closestPiMat,nVals,BCNstruct,theWPs,RSSI_0,noise)
% Method to localize a patient carrying a mobile beacon 
% out1: a structure containing the (x,y) coordinates 
% out2: a vector of known location errors for testing

global locPiOne locPiTwo locPiThree...
       locPiFour locPiFive locPiSix
   
global locBCN1 locBCN2 locBCN3 locBCN4 locBCN5

global PiOne PiTwo PiThree...
       PiFour PiFive PiSix
   
global valToReplaceZero
   
% Calibrate the WPs
PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
PIvec = intersect([1:6],PisInUse);
trilatDists = [];
    
% Building the necesary N-value matrix for each beacon
[row,col] = size(closestPiMat); % Arg_1
numBCNs = row;
numNBRs = col;
N = [];

% Compute path loss exponent for each Beacon
for(m = 1:numBCNs)
    % For each neighbor
    for(r = 1:numNBRs)
        NvalSum = [];
        for(p = 1:numNBRs)
            WPindex = theWPs(m,p);
            PIval = closestPiMat(m,r); 
            % Finding its proper index
            for(iter = 1:numel(PIvec))
                if(PIval == PIvec(iter))
                    PIindex = iter;
                    break;
                end
            end
            NvalSum = [NvalSum, nVals(WPindex,PIindex)]; % Arg_2
        end
        % Taking the average of all 3 nVals
         N(m,r) = mean(NvalSum);
    end 
end

% For each beacon in the struct
solution = struct;
ErrorVec = [];
for(itOne = 1:numBCNs)
    fname = sprintf('B%d',itOne);

    % The actual PI number as written on the PIs
    firstPI = closestPiMat(itOne,1);
    switch firstPI
        case 1
            x1 = locPiOne(1);
            y1 = locPiOne(2);
        case 2
            x1 = locPiTwo(1);
            y1 = locPiTwo(2);
        case 3
            x1 = locPiThree(1);
            y1 = locPiThree(2);
        case 4
            x1 = locPiFour(1);
            y1 = locPiFour(2);
        case 5
            x1 = locPiFive(1);
            y1 = locPiFive(2);
        case 6
            x1 = locPiSix(1);
            y1 = locPiSix(2);
    end
    secondPI = closestPiMat(itOne,2);
    switch secondPI
        case 1
            x2 = locPiOne(1);
            y2 = locPiOne(2);
        case 2
            x2 = locPiTwo(1);
            y2 = locPiTwo(2);
        case 3
            x2 = locPiThree(1);
            y2 = locPiThree(2);
        case 4
            x2 = locPiFour(1);
            y2 = locPiFour(2);
        case 5
            x2 = locPiFive(1);
            y2 = locPiFive(2);
        case 6
            x2 = locPiSix(1);
            y2 = locPiSix(2);
    end
    thirdPI = closestPiMat(itOne,3);
    switch thirdPI
        case 1
            x3 = locPiOne(1);
            y3 = locPiOne(2);
        case 2
            x3 = locPiTwo(1);
            y3 = locPiTwo(2);
        case 3
            x3 = locPiThree(1);
            y3 = locPiThree(2);
        case 4
            x3 = locPiFour(1);
            y3 = locPiFour(2);
        case 5
            x3 = locPiFive(1);
            y3 = locPiFive(2);
        case 6
            x3 = locPiSix(1);
            y3 = locPiSix(2);
    end

    % Convert the PI numbers back to vector indices 
    for(R1 = 1:numel(PIvec))
        if(firstPI == PIvec(R1))
            firstPI = R1;
            break;
        end
    end
    for(R2 = 1:numel(PIvec))
        if(secondPI == PIvec(R2))
            secondPI = R2;
            break;
        end
    end
    for(R3 = 1:numel(PIvec))
        if(thirdPI == PIvec(R3))
            thirdPI = R3;
            break;
        end
    end
    %======================================================================
    %                      *** Added on 04 Aug 2016 ***
    %======================================================================
    bcnSig1 = BCNstruct.(fname)(firstPI); % Arg_3
    if(bcnSig1 == 0)
        bcnSig1 = valToReplaceZero;
    end
    bcnSig2 = BCNstruct.(fname)(secondPI);
    if(bcnSig2 == 0)
        bcnSig2 = valToReplaceZero;
    end
    bcnSig3 = BCNstruct.(fname)(thirdPI);
    if(bcnSig3 == 0)
        bcnSig3 = valToReplaceZero;
    end
    nVal1 = N(itOne,1);
    if(nVal1 == 0)
        nVal1 = 10;
    end
    nVal2 = N(itOne,2);
    if(nVal2 == 0)
        nVal2 = 10;
    end
    nVal3 = N(itOne,3);
    if(nVal3 == 0)
        nVal3 = 10;
    end

    d1 = (40*10^((1/(10*nVal1))*(RSSI_0 - bcnSig1 + noise)));
    d2 = (40*10^((1/(10*nVal2))*(RSSI_0 - bcnSig2 + noise)));
    d3 = (40*10^((1/(10*nVal3))*(RSSI_0 - bcnSig3 + noise)));
    
    % Fminsearch to select optimal (X,Y) location per beacon
    di = [d1,d2,d3];    % inches
    Xi = [x1,x2,x3];    % inches
    Yi = [y1,y2,y3];    % inches
    X = [500,500];      % inches
    
    squareError = @(X) sum(((((X(1)-Xi).^2) + ((X(2)-Yi).^2)) - di.^2).^2);
    [X, fval, exitFlag] = fminsearch(squareError,X);
    
    locBcn = X;
    solution.(fname) = locBcn;

    % Calculate the Error
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
    ErrorVec(itOne) = (sqrt((locBcn(1) - toCompare(1))^2 + (locBcn(2)-toCompare(2))^2))/12;
end
out1 = solution;
out2 = ErrorVec;
end