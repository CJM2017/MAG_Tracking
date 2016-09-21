function mapFloor_BI_PIstatus()
% The purpose of this function is to map the current floor plan setup 
% of raspberry pis and ble static waypoints and then evaluate the accuracy
% visually by plotting the derived beacon locations

global sampleSize plotBCNs savePositionImage
global plotErrorCircles pixelFactor 
global locPiOne locPiTwo locPiThree... 
       locPiFour locPiFive locPiSix
global PiOne PiTwo PiThree PiFour PiFive PiSix
global savePositionImage
   

figure(10)
hold on
BIFP = imread('nolines.png');
BIFP = 1.4* flipud(BIFP);
[X,Y,Z] = size(BIFP);
image(BIFP)

set(gca,'YDir','normal');
set(gcf,'Units','pixels','Position',[570 150 0.5*X 0.7*Y]);
axis image
xlim([0,1100])
ylim([0,1250])

line([0,0],[0,1250],'LineWidth',4,'Color','k')
line([0,1100],[1250,1250],'LineWidth',4,'Color','k')
line([1100,1100],[1250,0],'LineWidth',4,'Color','k')
line([0,1100],[0,0],'LineWidth',4,'Color','k')
        
% Plotting the PIs
a = 200;
dx = -pixelFactor*25;
dy = -pixelFactor*35;

if(PiOne)
    P1C = [35 220 14] ./ 255;
else
    P1C = 'r';
end

if(PiTwo)
    P2C = [35 220 14] ./ 255;
else
    P2C = 'r';
end

if(PiThree)
    P3C = [35 220 14] ./ 255;
else
    P3C = 'r';
end

if(PiFour)
    P4C = [35 220 14] ./ 255;
else
    P4C = 'r';
end

if(PiFive)
    P5C = [35 220 14] ./ 255;
else
    P5C = 'r';
end

if(PiSix)
    P6C = [35 220 14] ./ 255;
else
    P6C = 'r';
end

PIlineWidth = 2;

dx = -pixelFactor*25;
dy = -pixelFactor*35;

SP1 = scatter(pixelFactor*locPiOne(1),pixelFactor*locPiOne(2),a,'s','filled','MarkerFaceColor',P1C,'MarkerEdgeColor','k','LineWidth',PIlineWidth);
text(pixelFactor*locPiOne(1)-pixelFactor*25,pixelFactor*locPiOne(2)+pixelFactor*35,'PI1','FontWeight','bold')

scatter(pixelFactor*locPiTwo(1),pixelFactor*locPiTwo(2),a,'s','filled','MarkerFaceColor',P2C,'MarkerEdgeColor','k','LineWidth',PIlineWidth);
text(pixelFactor*locPiTwo(1)-pixelFactor*25,pixelFactor*locPiTwo(2)-pixelFactor*35,'PI2','FontWeight','bold')

scatter(pixelFactor*locPiThree(1),pixelFactor*locPiThree(2),a,'s','filled','MarkerFaceColor',P3C,'MarkerEdgeColor','k','LineWidth',PIlineWidth);
text(pixelFactor*locPiThree(1)+pixelFactor*20,pixelFactor*locPiThree(2)+pixelFactor*35,'PI3','FontWeight','bold')

scatter(pixelFactor*locPiFour(1),pixelFactor*locPiFour(2),a,'s','filled','MarkerFaceColor',P4C,'MarkerEdgeColor','k','LineWidth',PIlineWidth);
text(pixelFactor*locPiFour(1)-pixelFactor*25,pixelFactor*locPiFour(2)-pixelFactor*35,'PI4','FontWeight','bold')

scatter(pixelFactor*locPiFive(1),pixelFactor*locPiFive(2),a,'s','filled','MarkerFaceColor',P5C,'MarkerEdgeColor','k','LineWidth',PIlineWidth);
text(pixelFactor*locPiFive(1)-pixelFactor*25,pixelFactor*locPiFive(2)+pixelFactor*35,'PI5','FontWeight','bold')

scatter(pixelFactor*locPiSix(1),pixelFactor*locPiSix(2),a,'s','filled','MarkerFaceColor',P6C,'MarkerEdgeColor','k','LineWidth',PIlineWidth);
text(pixelFactor*locPiSix(1)-pixelFactor*33,pixelFactor*locPiSix(2)-pixelFactor*35,'PI6','FontWeight','bold')

% Graph details and error vector 
title('Pi Locations')

% Saving Plot to Directory
if(savePositionImage)
    saveas(SP1,'C:\Users\cj836\Documents\Visual Studio 2012\Projects\Patient_Tracker\Patient_Tracker\Images\PiStatusImg.png')
    BIFP = [];
    close(10)
end

end