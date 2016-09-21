
load('Location_Estimates');
Patient_Tracker_Config;

global sampleSize plotBCNs savePositionImage

global plotErrorCircles pixelFactor

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
coordStruct = solsMat;

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
a = 50;
dx = 10;
dy = 10;

% Plotting the estimated positon of the BCNs 

numBcns = numel(fieldnames(coordStruct));
%colorVec = {'r','c','y','g','b'};
colorVec = {[1,0,0],[1,0.5,0],[1,1,0],[0,1,0],[0,0,1]};
for(i = 1:numBcns)
    fname = sprintf('B%d',i);
    [lastRow,lastCol] = size(coordStruct.(fname));

    xToPlot = pixelFactor*coordStruct.(fname)(:,1); %lastRow *******************************

    yToPlot = pixelFactor*coordStruct.(fname)(:,2); %lastRow *******************************

    SP1 = scatter(xToPlot,yToPlot,a,colorVec{i},'filled','MarkerEdgeColor','k','LineWidth',1.5);
end

disp('Looping through second data file...')

load('Location_Estimates_2.mat')
coordStruct = solsMat;
%{
% Plotting the estimated positon of the BCNs 
for(i = 1:numBcns)
    fname = sprintf('B%d',i);
    [lastRow,lastCol] = size(coordStruct.(fname));

    xToPlot = pixelFactor*coordStruct.(fname)(:,1); %lastRow *******************************
   
    yToPlot = pixelFactor*coordStruct.(fname)(:,2); %lastRow *******************************

    scatter(xToPlot,yToPlot,a,colorVec{i},'filled','MarkerEdgeColor','k','LineWidth',1.5);
end
%}

% Plotting the known BCN locations 

scatter(pixelFactor*locBCN1(1),pixelFactor*locBCN1(2),100,'k','filled','MarkerEdgeColor','w')

scatter(pixelFactor*locBCN2(1),pixelFactor*locBCN2(2),100,'k','filled','MarkerEdgeColor','w')

scatter(pixelFactor*locBCN3(1),pixelFactor*locBCN3(2),100,'k','filled','MarkerEdgeColor','w')

scatter(pixelFactor*locBCN4(1),pixelFactor*locBCN4(2),100,'k','filled','MarkerEdgeColor','w')

scatter(pixelFactor*locBCN5(1),pixelFactor*locBCN5(2),100,'k','filled','MarkerEdgeColor','w')

% Graph details and error vector 
title('Patient Beacons')

saveas(SP1,'Plot_Of_Location_Estimates_24.png')


