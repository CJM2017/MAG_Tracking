function [out1,out2,out3,out4,out5] = evalTrackingErrors(ErrorMat)
% The rows represent different location iterations
% The cols represent different Beacons

[r,numBCNs] = size(ErrorMat);
for(i = 1:numBCNs)
    dataVec = ErrorMat(:,i);
    avg(i) = mean(dataVec);
    med(i) = median(dataVec);
    vecMode(i) = mode(dataVec);
    vecMin(i) = min(dataVec);
    vecMax(i) = max(dataVec);
end

figure
bar([1:numBCNs],avg,'r')
xlabel('Beacon Number')
ylabel('Feet')
title('Average Distance Error')

figure
bar([1:numBCNs],med,'b')
xlabel('Beacon Number')
ylabel('Feet')
title('Average Distance Error')

figure
bar([1:numBCNs],vecMode,'g')
xlabel('Beacon Number')
ylabel('Feet')
title('Average Distance Error')

figure
bar([1:numBCNs],vecMin,'m')
xlabel('Beacon Number')
ylabel('Feet')
title('Average Distance Error')

figure
bar([1:numBCNs],vecMax,'c')
xlabel('Beacon Number')
ylabel('Feet')
title('Average Distance Error')

out1 = avg;
out2 = med;
out3 = vecMode;
out4 = vecMin;
out5 = vecMax;
