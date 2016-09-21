function out = findNN_RSSI(Wstruct,Bstruct)

% This method wil lbe used to find the NN from live sample signal
% compared to the live WP values

% Wstruct:
% This contains all RSSI vectors for each WP
% Dependent on the # PIs present

% Bstruct:
% This contains all the RSSI vectors of the PIs
% Dependent on the # PIs present

global desiredNeighborNum
global valToReplaceZero
global preventThreeInaRow

numWps = numel(fieldnames(Wstruct));
numBcns = numel(fieldnames(Bstruct));
topThree = {};
neighbors = struct;
% For each beacon
for(i = 1:numBcns)
    distances = [];
    % Test against each waypoint
    for(j = 1:numWps)
        BcnFname = sprintf('B%d',i);
        BcnRSSI = Bstruct.(BcnFname);
        WpFname = sprintf('WP%d',j);
        WpRSSI = Wstruct.(WpFname);
        vecSize = numel(WpRSSI);
        delta = [];
        nnzCount = 0;
        
        for(k = 1:vecSize)
            if(BcnRSSI(k) == 0)
                BcnRSSI(k) = valToReplaceZero;
            end
            if(WpRSSI(k) == 0)
                WpRSSI(k) = valToReplaceZero;
            end
            delta(k) = BcnRSSI(k) - WpRSSI(k);
        end
        
        deltaSQ = delta.^2;
        deltaSum = sum(deltaSQ);
        distances(j) = sqrt(deltaSum);
        
        % *** This overrides what is above... ***
        for(k = 1:vecSize)
            if((BcnRSSI(k) == 0) || (WpRSSI(k) == 0))
                delta(k) = 0;
            else
                delta(k) = BcnRSSI(k) - WpRSSI(k);
                nnzCount = nnzCount+1;
            end
        end
        deltaSQ = delta.^2;
        deltaSum = sum(deltaSQ);
        distances(j) = sqrt(deltaSum)/nnzCount;
        %---------------------------------------
        %           POSSIBLE ALT METHOD
        %---------------------------------------
        %{
        for(k = 1:vecSize)
            if((BcnRSSI(k) == 0) && (WpRSSI(k) == 0))
                delta(k) = 0;
                nnzCount = nnzCount+1;
            elseif( ((BcnRSSI(k) == 0) && (WpRSSI(k) ~= 0)) || ((BcnRSSI(k) ~= 0) && (WpRSSI(k) == 0)) )
                delta(k) = 0;
            else
                delta(k) = BcnRSSI(k) - WpRSSI(k);
                nnzCount = nnzCount+1;
            end
        end
        deltaSQ = delta.^2;
        deltaSum = sum(deltaSQ);
        distances(j) = sqrt(deltaSum)/nnzCount;
        %}
    end

    indexVecOfIs = [];
    for(m = 1:desiredNeighborNum)
        [minDist,I] = min(distances);
        indexVecOfIs(m) = I;
        WPnbr = sprintf('WP%d',I);
        topThree{1,m} = WPnbr;
        %topThree{2,m} = minDist;
        distances(I) = 1000*distances(I); 
    end
    
    % Check to see if we ended up with 3 NN in a row...Change
    if(preventThreeInaRow)
        threeInaRowMat = [1 2 3; 2 3 4; 3 4 5; 4 5 6; 5 6 7;...
                          8 9 10; 9 10 11; 10 11 12; 11 12 13;12 13 14;...
                          15 16 17; 16 17 18;17 18 19; 18 19 20; 19 20 21;...
                          22 23 24; 23 24 25; 24 25 26; 25 26 27;26 27 28;...
                          29 30 31;30 31 32;...
                          29 22 15;22 15 8;15 8 1;...
                          30 23 16; 23 16 9; 16 9 2;...
                          31 24 17; 24 17 10; 17 10 3;...
                          25 18 11; 18 11 2;...
                          26 19 12; 19 12 5;...
                          27 20 13; 20 13 6;...
                          28 21 14; 21 14 7];
        [rows,cols] = size(threeInaRowMat);
        for(it = 1:rows)
            if(all(ismember(indexVecOfIs,threeInaRowMat(it,:))))
                [minDist,I] = min(distances);
                WPnbr = sprintf('WP%d',I);
                % Un-comment to place this loop into action...(-) affects DPL_fmin
                topThree{3} = WPnbr;
                distances(I) = 1000*distances(I);
            end
        end
    end
    
    % Saving the top three neighbors to the Beacon
    fname = sprintf('B%d',i);
    neighbors.(fname) = topThree;
end
out = neighbors;
end