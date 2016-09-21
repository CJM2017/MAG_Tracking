function out = locationFromNbrs(nbrs)
% nbrs is a matrix of nearest neighbors
% Row = Beacon number
% Col = The 3 neighbors
% Could be used to set a bench mark of location accuracy...if the estimated 
% position falls outside of a 5 ft (?) radius from this nbr point, then the
% algorithm will discard the measurment.

% Ble Waypooint Coordinates
global locWP1 locWP2 locWP3 locWP4 locWP5...
       locWP6 locWP7 locWP8 locWP9 locWP10...
       locWP11 locWP12 locWP13 locWP14 locWP15...
       locWP16 locWP17 locWP18 locWP19 locWP20...
       locWP21 locWP22 locWP23 locWP24 locWP25...
       locWP26 locWP27 locWP28 locWP29 locWP30...
       locWP31 locWP32  
   
WpLocMat =  [locWP1(1),locWP1(2);
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

[numBcns,numNbrs] = size(nbrs);
locResults = [];
for(i = 1:numBcns)
    NBR1 = nbrs(i,1);
    locNBR1 = WpLocMat(NBR1,:);
    
    NBR2 = nbrs(i,2);
    locNBR2 = WpLocMat(NBR2,:);
    
    NBR3 = nbrs(i,3);
    locNBR3 = WpLocMat(NBR3,:);
    
    % Compute XY-coord as average of X-points and Y-points
    Xresult = mean([locNBR1(1),locNBR2(1),locNBR3(1)]);
    Yresult = mean([locNBR1(2),locNBR2(2),locNBR3(2)]);
    locResults(i,:) = [Xresult,Yresult];
end

out = locResults;
end
