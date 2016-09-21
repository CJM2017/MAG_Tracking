function mapFloor(varargin)
% The purpose of this function is to map the current floor plan setup 
% of raspberry pis and ble static waypoints and then evaluate the accuracy
% visually by plotting the derived beacon locations

%==========================================================================
%                             DO NOT TOUCH
%==========================================================================
coordStruct = varargin{1};
calcErrors = varargin{2};

if(length(varargin) == 4)
    trilatDists = varargin{3};
    closestPiMat = varargin{4};
end

Patient_Tracker_Config;

global plotErrorCircles plotBCNs sampleSize savePositionImage

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
   
WpLocMat = [locWP1(1),locWP1(2);
            locWP2(1),locWP2(2);
            locWP3(1),locWP3(2);
            locWP4(1),locWP4(2);
            locWP5(1),locWP5(2);
            locWP6(1),locWP6(2);
            locWP7(1),locWP7(2);
            locWP8(1),locWP8(2);
            locWP9(1),locWP9(2);
            locWP10(1),locWP10(2);
            locWP11(1),locWP11(2)
            locWP12(1),locWP12(2)
            locWP13(1),locWP13(2)
            locWP14(1),locWP14(2);
            locWP15(1),locWP15(2)
            locWP16(1),locWP16(2)
            locWP17(1),locWP17(2)
            locWP18(1),locWP18(2);
            locWP19(1),locWP19(2)
            locWP20(1),locWP20(2)
            locWP21(1),locWP21(2)
            locWP22(1),locWP22(2)
            locWP23(1),locWP23(2)
            locWP24(1),locWP24(2)
            locWP25(1),locWP25(2)
            locWP26(1),locWP26(2)
            locWP27(1),locWP27(2)
            locWP28(1),locWP28(2)
            locWP29(1),locWP29(2)
            locWP30(1),locWP30(2)
            locWP31(1),locWP31(2)
            locWP32(1),locWP32(2)
            ];
%==========================================================================
%                             DO NOT TOUCH
%==========================================================================
        
% Plotting the PIs
figure(1)
hold on

a = 150;
dx = 5;
dy = 5;

SP1 = scatter(locPiOne(1),locPiOne(2),a,'s','black','filled');
text(locPiOne(1)+dx,locPiOne(2)+dy,'PI_1')

scatter(locPiTwo(1),locPiTwo(2),a,'s','black','filled')
text(locPiTwo(1)+dx,locPiTwo(2)+dy,'PI_2')

scatter(locPiThree(1),locPiThree(2),a,'s','black','filled')
text(locPiThree(1)+dx,locPiThree(2)+dy,'PI_3')

scatter(locPiFour(1),locPiFour(2),a,'s','black','filled')
text(locPiFour(1)+dx,locPiFour(2)+dy,'PI_4')

scatter(locPiFive(1),locPiFive(2),a,'s','black','filled')
text(locPiFive(1)+dx,locPiFive(2)+dy,'PI_5')

scatter(locPiSix(1),locPiSix(2),a,'s','black','filled')
text(locPiSix(1)+dx,locPiSix(2)+dy,'PI_6')

% Plotting the WPs
[r,c] = size(WpLocMat);
for(it = 1:r)
    scatter(WpLocMat(it,1),WpLocMat(it,2),'r','filled')
    tagID = sprintf('WP%d',it);
    text(WpLocMat(it,1)+dx,WpLocMat(it,2)+dy,tagID)
end

% Plotting the known BCN locations
scatter(locBCN1(1),locBCN1(2),'g','filled')
text(locBCN1(1)+dx,locBCN1(2)+dy,'B1')
scatter(locBCN2(1),locBCN2(2),'g','filled')
text(locBCN2(1)+dx,locBCN2(2)+dy,'B2')
scatter(locBCN3(1),locBCN3(2),'g','filled')
text(locBCN3(1)+dx,locBCN3(2)+dy,'B3')
scatter(locBCN4(1),locBCN4(2),'g','filled')
text(locBCN4(1)+dx,locBCN4(2)+dy,'B4')
scatter(locBCN5(1),locBCN5(2),'g','filled')
text(locBCN5(1)+dx,locBCN5(2)+dy,'B5')

% Plotting the estimated positon of the BCNs 
if(plotBCNs)
    numBcns = numel(fieldnames(coordStruct));
    for(i = 1:numBcns)
        fname = sprintf('B%d',i);
        xToPlot = coordStruct.(fname)(:,1);
        yToPlot = coordStruct.(fname)(:,2);
        scatter(xToPlot,yToPlot,a,'d','b','filled')
        text(xToPlot+dx,yToPlot+dy,fname)
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
                    X = locPiOne(1);
                    Y = locPiOne(2);
                case 2
                    X = locPiTwo(1);
                    Y = locPiTwo(2);
                case 3
                    X = locPiThree(1);
                    Y = locPiThree(2);
                case 4
                    X = locPiFour(1);
                    Y = locPiFour(2);
                case 5
                    X = locPiFive(1);
                    Y = locPiFive(2);
                case 6
                    X = locPiSix(1);
                    Y = locPiSix(2);
            end
            radius = trilatDists(iterOne,iterTwo);
            circle(X,Y,radius,color);
        end
    end
end

% Graph details and error vector 
title('Beacon & Pi Locations')
xlabel('X-Coordinate (inches)')
ylabel('Y-Coordinate (inches)')
hold off
figure(2)
[r,c] = size(calcErrors);
avgBcnError = [];
for(k = 1:c)
    avgBcnError(k) = mean(calcErrors(:,k));
end
bar(avgBcnError)
thisTitle = sprintf('Average Location Error (%d Files Read)',sampleSize);
title(thisTitle)
xlabel('Beacon Number')
ylabel('Feet')

% Saving Plot to Directory
if(savePositionImage)
    saveas(SP1,'C:\Users\cy911\Documents\Visual Studio 2012\Projects\Patient_Tracker\Patient_Tracker\Images\PositionUpdate.png')
end
end