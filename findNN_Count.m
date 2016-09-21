function out = findNN_Count(matWP,matBCN)
% This method will recieve 2 matrices of data
% Each row represents either a waypoint or a beacon
% Each column corresponds with the PI which collected the data

[rBCN,cBCN] = size(matBCN);
[rWP,cWP] = size(matWP);
topThree = {};
neighbors = struct;
desiredNeighborNum = 3;

for (i = 1:rBCN)
    distances = [];
    for(j = 1:rWP)
        delta = matBCN(i,:)- matWP(j,:);
        deltaSQ = delta.^2;
        runSum = sum(deltaSQ);
        distances(j) = sqrt(runSum);  
    end
    for(m = 1:desiredNeighborNum) 
        [minDist,I] = min(distances);
        WPnbr = sprintf('WP%d',I);
        topThree{1,m} = WPnbr;
        %topThree{2,m} = minDist;
        distances(I) = 100*distances(I); % Fix this with proper sorting index algorithmw which can be found in matlab TxB if i cannot recall!
    end
    fname = sprintf('B%d',i);
    neighbors.(fname) = topThree;
end
out = neighbors;
end
