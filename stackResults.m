function [out1,out2,out3] = stackResults(solution,beacons,error,firstRun,solsMat,ErrorMat)
% The newest locations are on BOTTOM ***

global setPastLocSize

for(i = 1:numel(fieldnames(beacons)))
    if(firstRun)
        solsMat = solution;
        firstRun = false;
        break;
    else
        
        % Storing the position estimate
        fname = sprintf('B%d',i);
        solsMat.(fname) = vertcat(solsMat.(fname),solution.(fname));
        
        % Trimming stored solutions to 10
        if(setPastLocSize)
            [r,c] = size(solsMat.(fname));
            if(r > 10)
                solsMat.(fname)(1,:) = []; % Delete the top most entry (oldest)
            end
        end
    end
end

ErrorMat = vertcat(ErrorMat,error);

% Error Data
if(setPastLocSize)
    [er,ec] = size(ErrorMat);
    if(er > 10)
        ErrorMat(1,:) = []; % Deleting the top most position
    end
end

out1 = solsMat;
out2 = ErrorMat;
out3 = firstRun;
end