function out = buildWPstruct(allPiData)
% Pass in the struct
% Struct contains all data from each Pi (6)
% Each Pi contains data on each Waypoint
% We want each Waypoint to be a vector containing
% data from each Pi

numPis = length(allPiData);
numWps = numel(fieldnames(allPiData));
WPstruct = struct;
dataVec = [];

% Loop through allPiData to form WPstruct
for(i = 1:numWps)
    for(j = 1:numPis)
        fname = sprintf('WP%d',i);
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
        WPstruct.(fname) = dataVec;
        dataVec = [];
end
out = WPstruct;
end

        
        
        
        