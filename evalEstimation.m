function [out1,out2] = evalEstimation(estPositions,nbrPositions,errors)
% Method to determine if we want to throw away the localization attempt.
% estPositions contains the estimated location of each beacon while the
% nbrPositions was generated from the everage of the X and Y components
% making up the 3 NNs. If the distance errror between this avg point and
% the estimated is greater than 8 meters (Try lower values) then we reject
% it and erase it from solsMat and ErrorMat

numBcns = numel(fieldnames(estPositions));
[er,ec] = size(errors);
for(i = 1:numBcns)
    fname = sprintf('B%d',i);
    [lastRow,lastCol] = size(estPositions.(fname)); % Newest location at the bottom ?!?!?1
    estX = estPositions.(fname)(lastRow,1);
    estY = estPositions.(fname)(lastRow,2);
    
    distMag = (sqrt(((estX-nbrPositions(i,1))^2) + ((estY - nbrPositions(i,2))^2)))/12; % Units; Feet
    
    % TRY DIFF VALUES OF TOLERANCE BELOW 8 METER !!!!
    if(distMag > 8)
        [numLocAtmpts,xx] = size(estPositions.(fname));
        if(numLocAtmpts > 1)
            estPositions.(fname)(lastRow,:) = [];
            errors(er,i) = errors(er-1,i); % Takes the value from before
        end
    end
end
    
out1 = estPositions;
out2 = errors;
end