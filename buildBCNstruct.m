function out = buildBCNstruct(allPiData)
% Transforms the passed in struct
% Struct contains all data from each Pi 
% Each Pi contains data on each Waypoint
% We want each Waypoint to be a vector containing
% data from each Pi

numPis = length(allPiData);
numWps = numel(fieldnames(allPiData));
BCNstruct = struct;
dataVec = [];

% Loop through allPiData to form BCNstruct
for(i = 1:numWps)
    for(j = 1:numPis)
        fname = sprintf('B%d',i);
        val = allPiData(j).(fname);
        
        % Place a zero if that Pi did not pick up a signal (empty)
        if(isempty(val))
            val = 0;     
        else
            % Round to 2 decimals
            val = ceil(100*val)/100;
        end
        dataVec = [dataVec,val];
    end
        BCNstruct.(fname) = dataVec;
        dataVec = [];
end
out = BCNstruct;
end

        
        
        
        