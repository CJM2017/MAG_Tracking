load('Accuracy_Test_12Aug16','ErrorMat');
[r,c] = size(ErrorMat);
for(i = 1:c)
    figure(1)
    subplot(3,2,i)
    if(i == 5)
        MAX = 30;
    else
        MAX = 10;
    end
    histogram(ErrorMat(:,i),[1:MAX])
    avgE = round(mean(ErrorMat(:,i)));
    plotTitle = sprintf('Beacon %d Avg Location Error: %d',i,avgE);
    title(plotTitle)
    xlabel('Distance (Feet)')
    ylabel('Frequency')
end