function out = choosePiByStrength(BCNstruct)
% Method to select the 3 strongest PIs for each beacon to be used in
% trilateration.
% I Figured this would help close PIs which have 0 RSSI detection from
% being chosen and then having to substitute the global RSSI value in

global PiOne PiTwo PiThree...
       PiFour PiFive PiSix

% Variables to be used
PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
PIvec = intersect([1:6],PisInUse);
numBcns = numel(fieldnames(BCNstruct));
finalPisOut = [];

% For each beacon 
for(i = 1:numBcns)
    tempMat = [];
    fname = sprintf('B%d',i);
    tempMat = vertcat(PIvec,BCNstruct.(fname))';
    tempMat = (sortrows(tempMat,-2))';
    found = 0;
    iter = 1;
    % Find what we are looking for
    thePis = [];
    while(found ~= 3)
        if(tempMat(2,iter) ~= 0) %Ignores signal values of 0
            thePis = [thePis,tempMat(1,iter)]; % Build the 3 strongest PI vec
            iter = iter+1;
            found = found+1;
        else
            iter = iter+1;
        end
        % Break out of the loop before we extend beyond vector length ***
        if(iter > numel(PIvec))
            break;
        end
    end
    
    % Prevent 3 PIs in a vertical row according to BI current layout
    if(all(ismember([4,5,6],thePis)) || (all(ismember([1,2,3],thePis))))
        if(iter <= numel(PIvec))
            thePis(3) = tempMat(1,iter); % since iter was incremented after the last element was entered
        else
            switch (numel(PIvec) - 3)
                case 1
                    thePis(3) = tempMat(1,1);
                case 2
                    thePis(2) = tempMat(1,2);
                case 3
                    thePis(3) = tempMat(1,3);
            end
        end
    end
    % Error Check
    numPisChosen = nnz(BCNstruct.(fname));
    switch numPisChosen
        case 0
            fprintf('Exiting...Beacon w/no Signal\n')
            %quit...***************************************************************
        case 1
            % we found one nonzero element and the other two are 0s which
            % will have to recieve the substituted value later on
            thePis(2) = tempMat(1,end-1);
            thePis(3) = tempMat(1,end-2);
        case 2
            thePis(3) = tempMat(1,end-2);
    end
    finalPisOut(i,:) = thePis;
end

out = finalPisOut;
end
