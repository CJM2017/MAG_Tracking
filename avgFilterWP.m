function [avgStruct,counts] = avgFilterWP(allPiData)
% Script to filter the RSSI Scan Files of the waypoints
% Takes input nested struct
% First ouput is the same struct but with avg RSSI values now
% Secount output is the same struct but containing RSSI event counts

global sampleWithAvg

numPis = length(allPiData);
numWps = numel(fieldnames(allPiData));
eventCount = [numWps,numPis];

% Loops through each PI and then each beacon
% Each of those data point vectors will be averaged and replaced
% See line 42
for(i = 1:numPis)
    for(j = 1:numWps)
        fname = sprintf('WP%d',j);
        dataVec = allPiData(i).(fname);     
        eventCount(j,i) = numel(dataVec);
        if(~isempty(dataVec))
            med = median(dataVec);
            numVals = numel(dataVec);
            sorted = sort(dataVec);
            for(k = 1:numVals)
                if(sorted(k) >= med)
                    medIdx = k;
                    break;
                end
            end
            firstQrtData = sorted(medIdx:end);
            dataVariance = var(dataVec);
            if(dataVariance > 15)
                RSSIavg = mode(dataVec);
            else
                RSSIavg =  mean(dataVec);
            end
            % Override can be set from config
            if(sampleWithAvg)
                RSSIavg =  mean(dataVec);
            end
            allPiData(i).(fname) = RSSIavg;
        end
    end
end
avgStruct = allPiData;
counts = eventCount;            
end
