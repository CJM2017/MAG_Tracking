function mapFloor_BI(varargin)
% The purpose of this function is to map the current floor plan setup 
% of raspberry pis and ble static waypoints and then evaluate the accuracy
% visually by plotting the derived beacon locations

global sampleSize plotBCNs savePositionImage

global plotErrorCircles pixelFactor deletePlots

global locPiOne locPiTwo locPiThree... 
       locPiFour locPiFive locPiSix
   
global locWP1 locWP2 locWP3 locWP4 locWP5...
       locWP6 locWP7 locWP8 locWP9 locWP10...
       locWP11 locWP12 locWP13 locWP14 locWP15...
       locWP16 locWP17 locWP18 locWP19 locWP20...
       locWP21 locWP22 locWP23 locWP24 locWP25...
       locWP26 locWP27 locWP28 locWP29 locWP30...
       locWP31 locWP32 
 
global locBCN1 locBCN2 locBCN3 locBCN4 locBCN5
   
WpLocMat = pixelFactor * [locWP1(1),locWP1(2);
                          locWP2(1),locWP2(2);
                          locWP3(1),locWP3(2);
                          locWP4(1),locWP4(2);
                          locWP5(1),locWP5(2);
                          locWP6(1),locWP6(2);
                          locWP7(1),locWP7(2);
                          locWP8(1),locWP8(2);
                          locWP9(1),locWP9(2);
                          locWP10(1),locWP10(2);
                          locWP11(1),locWP11(2);
                          locWP12(1),locWP12(2);
                          locWP13(1),locWP13(2);
                          locWP14(1),locWP14(2);
                          locWP15(1),locWP15(2);
                          locWP16(1),locWP16(2);
                          locWP17(1),locWP17(2);
                          locWP18(1),locWP18(2);
                          locWP19(1),locWP19(2);
                          locWP20(1),locWP20(2);
                          locWP21(1),locWP21(2);
                          locWP22(1),locWP22(2);
                          locWP23(1),locWP23(2);
                          locWP24(1),locWP24(2);
                          locWP25(1),locWP25(2);
                          locWP26(1),locWP26(2);
                          locWP27(1),locWP27(2);
                          locWP28(1),locWP28(2);
                          locWP29(1),locWP29(2);
                          locWP30(1),locWP30(2);
                          locWP31(1),locWP31(2);
                          locWP32(1),locWP32(2);
                          ];
% Function Arguments                    
coordStruct = varargin{1};
calcErrors = varargin{2};
if(length(varargin) == 4)
    trilatDists = varargin{3};
    closestPiMat = varargin{4};
end

% Background Floorplan
figure(1)
hold on
BIFP = 1.4*imread('nolines.png');    %'BI_Figures\nolines.png'
BIFP = flipud(BIFP);
%BIFPinfo = imfinfo('BImap.png');
[X,Y,Z] = size(BIFP);
image(BIFP)
set(gca,'YDir','normal');
axis image
set(gcf,'Units','pixels','Position',[570 150 0.5*X 0.7*Y]);
axis image

xlim([0,1100])
ylim([0,1250])

line([0,0],[0,1250],'LineWidth',4,'Color','k')
line([0,1100],[1250,1250],'LineWidth',4,'Color','k')
line([1100,1100],[1250,0],'LineWidth',4,'Color','k')
line([0,1100],[0,0],'LineWidth',4,'Color','k')
%==========================================================================
%                             Plotting
%==========================================================================
        
% Plotting the PIs
a = 100;
dx = 10;
dy = 10;

%SP1 = scatter(pixelFactor*locPiOne(1),pixelFactor*locPiOne(2),a,'s','black','filled');
%text(pixelFactor*locPiOne(1)+dx,pixelFactor*locPiOne(2)+dy,'PI1','FontWeight','bold')
%{
scatter(pixelFactor*locPiTwo(1),pixelFactor*locPiTwo(2),a,'s','black','filled')
text(pixelFactor*locPiTwo(1)+dx,pixelFactor*locPiTwo(2)+dy,'PI2','FontWeight','bold')

scatter(pixelFactor*locPiThree(1),pixelFactor*locPiThree(2),a,'s','black','filled')
text(pixelFactor*locPiThree(1)+dx,pixelFactor*locPiThree(2)+dy,'PI3','FontWeight','bold')

scatter(pixelFactor*locPiFour(1),pixelFactor*locPiFour(2),a,'s','black','filled')
text(pixelFactor*locPiFour(1)+dx,pixelFactor*locPiFour(2)+dy,'PI4','FontWeight','bold')

scatter(pixelFactor*locPiFive(1),pixelFactor*locPiFive(2),a,'s','black','filled')
text(pixelFactor*locPiFive(1)+dx,pixelFactor*locPiFive(2)+dy,'PI5','FontWeight','bold')

scatter(pixelFactor*locPiSix(1),pixelFactor*locPiSix(2),a,'s','black','filled')
text(pixelFactor*locPiSix(1)+dx,pixelFactor*locPiSix(2)+dy,'PI6','FontWeight','bold')
%}

% Plotting the WPs
%{
[r,c] = size(WpLocMat);
for(it = 1:r)
    scatter(WpLocMat(it,1),WpLocMat(it,2),'r','filled')
    tagID = sprintf('WP%d',it);
    text(WpLocMat(it,1)+dx,WpLocMat(it,2)+dy,tagID,'FontWeight','bold')
end
%}
% Plotting the known BCN locations 

scatter(pixelFactor*locBCN1(1),pixelFactor*locBCN1(2),'g','filled','MarkerEdgeColor','k','LineWidth',1)
%text(pixelFactor*locBCN1(1)+dx,pixelFactor*locBCN1(2)+dy,'B1','FontWeight','bold')

scatter(pixelFactor*locBCN2(1),pixelFactor*locBCN2(2),'g','filled','MarkerEdgeColor','k','LineWidth',1)
%text(pixelFactor*locBCN2(1)+dx,pixelFactor*locBCN2(2)+dy,'B2','FontWeight','bold')

scatter(pixelFactor*locBCN3(1),pixelFactor*locBCN3(2),'g','filled','MarkerEdgeColor','k','LineWidth',1)
%text(pixelFactor*locBCN3(1)+dx,pixelFactor*locBCN3(2)+dy,'B3','FontWeight','bold')

scatter(pixelFactor*locBCN4(1),pixelFactor*locBCN4(2),'g','filled','MarkerEdgeColor','k','LineWidth',1)
%text(pixelFactor*locBCN4(1)+dx,pixelFactor*locBCN4(2)+dy,'B4','FontWeight','bold')

scatter(pixelFactor*locBCN5(1),pixelFactor*locBCN5(2),'g','filled','MarkerEdgeColor','k','LineWidth',1)
%text(pixelFactor*locBCN5(1)+dx,pixelFactor*locBCN5(2)+dy,'B5','FontWeight','bold')
%}

% Plotting the estimated positon of the BCNs 
if(plotBCNs)
    numBcns = numel(fieldnames(coordStruct));
    colorVec = {'r','o','y','g','b'};
    for(i = 1:numBcns)
        fname = sprintf('B%d',i);
        % Plotting only the most recent member of the position history
        [lastRow,lastCol] = size(coordStruct.(fname));
        
        xToPlot = pixelFactor*coordStruct.(fname)(lastRow,1); %lastRow *******************************
        if(xToPlot > 1100)
            xToPlot = 1100;
        end
        
        yToPlot = pixelFactor*coordStruct.(fname)(lastRow,2); %lastRow *******************************
        if(yToPlot > 1250)
            yToPlot = 1250;
        end
        
        SP1 = scatter(xToPlot,yToPlot,a+50,'b','filled');
        scatter(xToPlot,yToPlot,a,'w','filled')
        scatter(xToPlot,yToPlot,a-50,'b','filled'); %b
        text(xToPlot+dx,yToPlot+dy,fname,'FontWeight','bold')
    end
end

if((length(varargin) == 4) && plotErrorCircles)
    % Plotting Error circles around PIs
    colorVec = {'m','c','y','r'};
    [BCNs,PIs] = size(closestPiMat);
    % For each Beacons
    for(iterOne = 1:BCNs)
        if(iterOne > 4)
            color = 'k';
        else
            color = colorVec{iterOne};
        end
        % For each PI
        for(iterTwo = 1:PIs)
            aPoint = closestPiMat(iterOne,iterTwo);
            switch aPoint
                case 1
                    X = pixelFactor * locPiOne(1);
                    Y = pixelFactor * locPiOne(2);
                case 2
                    X = pixelFactor * locPiTwo(1);
                    Y = pixelFactor * locPiTwo(2);
                case 3
                    X = pixelFactor * locPiThree(1);
                    Y = pixelFactor * locPiThree(2);
                case 4
                    X = pixelFactor * locPiFour(1);
                    Y = pixelFactor * locPiFour(2);
                case 5
                    X = pixelFactor * locPiFive(1);
                    Y = pixelFactor * locPiFive(2);
                case 6
                    X = pixelFactor * locPiSix(1);
                    Y = pixelFactor * locPiSix(2);
            end
            radius = pixelFactor * trilatDists(iterOne,iterTwo);
            circle(X,Y,radius,color);
        end
    end
end

% Graph details and error vector 
title('Patient Beacons')


%--------------------------------------------------------------------------
figure(2)
B1=bar(calcErrors(end,:));
thisTitle = sprintf('Trilateration Location Error (%d Files Read)',sampleSize);
title(thisTitle)
xlabel('Beacon Number')
ylabel('Feet')
ylim([0,25])

[rr,cc] = size(calcErrors);
saveB2 = false;
if(rr > 1)
    figure(3)
    B2 = bar(mean(calcErrors));
    thisTitle = sprintf('Historical Trilateration Error (%d Files Read)',sampleSize);
    title(thisTitle)
    xlabel('Beacon Number')
    ylabel('Feet')
    ylim([0,25])
    saveB2 = true;
end
%--------------------------------------------------------------------------

% Saving Plot to Directory
if(savePositionImage)
    saveas(SP1,'C:\Users\cj836\Documents\Visual Studio 2012\Projects\Patient_Tracker\Patient_Tracker\Images\PositionUpdate.png')
    saveas(B1,'C:\Users\cj836\Documents\Visual Studio 2012\Projects\Patient_Tracker\Patient_Tracker\Images\errorBars.png')
    if(saveB2)
        saveas(B2,'C:\Users\cj836\Documents\Visual Studio 2012\Projects\Patient_Tracker\Patient_Tracker\Images\errorBarHist.png') % This needs to be changed to BarHist
    end
end
if(deletePlots)
    close(1)
    close(2)
    if(saveB2)
        close(3)
    end
end
end