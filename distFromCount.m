function out = distFromCount(countWP,countBCN)
% Method to search for correlation betweeen distance and Beacon Count
% Both arguments are matrices 
% Rows: WPs
% Cols: PIs

global PiOne PiTwo PiThree PiFour PiFive PiSix

global locPiOne locPiTwo locPiThree...
       locPiFour locPiFive locPiSix

global locWP1 locWP2 locWP3 locWP4 locWP5...
       locWP6 locWP7 locWP8 locWP9 locWP10...
       locWP11 locWP12 locWP13 locWP14 locWP15...
       locWP16 locWP17 locWP18 locWP19 locWP20...
       locWP21 locWP22 locWP23 locWP24 locWP25...
       locWP26 locWP27 locWP28 locWP29 locWP30...
       locWP31 locWP32 
   
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

PisInUse = [1:6] .* [PiOne,PiTwo,PiThree,PiFour,PiFive,PiSix];
PIvec = intersect([1:6],PisInUse);

[numWPs,numPIs] = size(countWP);
dataMat = [];
dist = [];
count = [];
for(i = 1:numPIs)
    thisPI = PIvec(i);
    switch thisPI
        case 1
            Px = locPiOne(1);
            Py = locPiOne(2);
        case 2
            Px = locPiTwo(1);
            Py = locPiTwo(2);
        case 3
            Px = locPiThree(1);
            Py = locPiThree(2);
        case 4
            Px = locPiFour(1);
            Py = locPiFour(2);
        case 5
            Px = locPiFive(1);
            Py = locPiFive(2);
        case 6
            Px = locPiSix(1);
            Py = locPiSix(2);
    end 
    for(j = 1:numWPs)
        % Calc the distance between one PI and each WP
        % Then associate that distance with the number of counts that the
        % PI picked up for said WP
        dist = [dist,sqrt((Px-WpLocMat(j,1))^2 + (Py-WpLocMat(j,2))^2)/12];
        count = [count,countWP(j,i)];  
    end
end
dataMat = [dist',count'];
figure(3)
X = dataMat(:,1);
Y = dataMat(:,2);
scatter(X,Y,'r','*')
xlabel('Distance (Feet)')
ylabel('Number of Counts')
title('Distance vs. Counts')

coeffs = polyfit(X, Y, 1);
% Get fitted values
fittedX = linspace(min(X), max(X), 200);
fittedY = polyval(coeffs, fittedX);
% Plot the fitted line
hold on;
plot(fittedX, fittedY, 'k');

out = dataMat;
end
