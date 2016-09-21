function out = calcDist(allPiData)
% Method to calculate the distance between each PI and each WP from known
% locations
% Used within dynamicPathLoss.m

global PiOne PiTwo PiThree PiFour PiFive PiSix

global locPiOne locPiTwo locPiThree... 
       locPiFour locPiFive locPiSix
   
% Ble Waypooint Coordinates
global locWP1 locWP2 locWP3 locWP4 locWP5...
       locWP6 locWP7 locWP8 locWP9 locWP10...
       locWP11 locWP12 locWP13 locWP14 locWP15...
       locWP16 locWP17 locWP18 locWP19 locWP20...
       locWP21 locWP22 locWP23 locWP24 locWP25...
       locWP26 locWP27 locWP28 locWP29 locWP30...
       locWP31 locWP32 

% MEthod to create vector of PIs which are currently in use
% If PI 2 and 5 are off...vector should = [1 3 4 6]
PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
PIvec = intersect([1:6],PisInUse);
numWPS = numel(fieldnames(allPiData));

% Matrix: Each row represents a PI and each column represents a WP
distMat = [];
   
for(i = 1:6)%numel(PIvec)
    %fprintf('matching PIs in calcDist and i = %d\n',i)
    %PInum = PIvec(i);
    PInum = i;
    switch PInum
        case 1
            locPI = locPiOne;
        case 2 
            locPI = locPiTwo;
        case 3
            locPI = locPiThree;
        case 4
            locPI = locPiFour;
        case 5
            locPI = locPiFive;
        case 6
            locPI = locPiSix;
    end
    for(j = 1:numWPS)
        switch j
            case 1
                locBcn = locWP1;
            case 2 
                locBcn = locWP2;
            case 3
                locBcn = locWP3;
            case 4
                locBcn = locWP4;
            case 5
                locBcn = locWP5;
            case 6
                locBcn = locWP6;
            case 7
                locBcn = locWP7;
            case 8
                locBcn = locWP8;
            case 9
                locBcn = locWP9;
            case 10
                locBcn = locWP10;
            case 11
                locBcn = locWP11;
            case 12 
                locBcn = locWP12;
            case 13
                locBcn = locWP13;
            case 14
                locBcn = locWP14;
            case 15
                locBcn = locWP15;
            case 16
                locBcn = locWP16;
            case 17
                locBcn = locWP17;
            case 18
                locBcn = locWP18;
            case 19
                locBcn = locWP19;
            case 20
                locBcn = locWP20;
            case 21
                locBcn = locWP21;
            case 22
                locBcn = locWP22;
            case 23
                locBcn = locWP23;
            case 24
                locBcn = locWP24;
            case 25
                locBcn = locWP25;
            case 26
                locBcn = locWP26;
            case 27
                locBcn = locWP27;
            case 28
                locBcn = locWP28;
            case 29
                locBcn = locWP29;
            case 30
                locBcn = locWP30;
            case 31
                locBcn = locWP31;
            case 32
                locBcn = locWP32;
        end
        dist = sqrt((locPI(1)-locBcn(1))^2 + (locPI(2)-locBcn(2))^2);
        distMat(i,j) = dist;
    end
    out = distMat;
end