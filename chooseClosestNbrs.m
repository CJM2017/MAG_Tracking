function out = combineNbrs(RssiNbrs,countNbrs)
% Method to take in the neighbors based on signal strength and count,
% determine all of the possible 3 paired neighbor combination that can be
% made, and choose the 3 paired combination which is the most compact or
% densely located.
% This is repeated for each beacon

global locWP1 locWP2 locWP3 locWP4 locWP5...
       locWP6 locWP7 locWP8 locWP9 locWP10...
       locWP11 locWP12 locWP13 locWP14 locWP15...
       locWP16 locWP17 locWP18 locWP19 locWP20...
       locWP21 locWP22 locWP23 locWP24 locWP25...
       locWP26 locWP27 locWP28 locWP29 locWP30...
       locWP31 locWP32  
   
numBcns = numel(fieldnames(RssiNbrs));
for(i = 1:numBcns)
    fname = sprintf('B%d',i);
    duplicates = ismember(countNbrs.(fname),RssiNbrs.(fname));
    reducedCellAr = RssiNbrs.(fname);
    for(n = 1:numel(duplicates))
        if(duplicates(n) == 0)
            reducedCellAr{numel(reducedCellAr)+ 1} = countNbrs.(fname){n};
        end
    end
    
    % Convert into a integer vector
    NbrVec = [];
    for(k = 1:numel(reducedCellAr))
        NBR = reducedCellAr{k};
        switch NBR
            case 'WP1'
                NBR = 1;
            case 'WP2'
                NBR = 2;
            case 'WP3'
                NBR = 3;
            case 'WP4'
                NBR = 4;
            case 'WP5'
                NBR = 5;
            case 'WP6'
                NBR = 6;
            case 'WP7'
                NBR = 7;
            case 'WP8'
                NBR = 8;
            case 'WP9'
                NBR = 9;
            case 'WP10'
                NBR = 10;
            case 'WP11'
                NBR = 11;
            case 'WP12'
                NBR = 12;
            case 'WP13'
                NBR = 13;
            case 'WP14'
                NBR = 14;
            case 'WP15'
                NBR = 15;
            case 'WP16'
                NBR = 16;
            case 'WP17'
                NBR = 17;
            case 'WP18'
                NBR = 18;
            case 'WP19'
                NBR = 19;
            case 'WP20'
                NBR = 20;
            case 'WP21'
                NBR = 21;
            case 'WP22'
                NBR = 22;
            case 'WP23'
                NBR = 23;
            case 'WP24'
                NBR = 24;
            case 'WP25'
                NBR = 25;
            case 'WP26'
                NBR = 26;
            case 'WP27'
                NBR = 27;
            case 'WP28'
                NBR = 28;
            case 'WP29'
                NBR = 29;
            case 'WP30'
                NBR = 30;
            case 'WP31'
                NBR = 31;
            case 'WP32'
                NBR = 32;
        end
        NbrVec = [NbrVec,NBR];
    end
    
    % Combination matrix where each row is a combination (HARD CODE)
    totalCombs = combnk(NbrVec,3);
    [r,c] = size(totalCombs);
    totalDist = [];
    for(it1 = 1:r)
        firstNbr = totalCombs(it1,1);
        switch firstNbr
            case 1
                firstNbrLoc = locWP1;
            case 2
                firstNbrLoc = locWP2;
            case 3
                firstNbrLoc = locWP3;
            case 4
                firstNbrLoc = locWP4;
            case 5
                firstNbrLoc = locWP5;
            case 6
                firstNbrLoc = locWP6;
            case 7
                firstNbrLoc = locWP7;
            case 8
                firstNbrLoc = locWP8;
            case 9
                firstNbrLoc = locWP9;
            case 10
                firstNbrLoc = locWP10;
            case 11
                firstNbrLoc = locWP11;
            case 12
                firstNbrLoc = locWP12;
            case 13
                firstNbrLoc = locWP13;
            case 14
                firstNbrLoc = locWP14;
            case 15
                firstNbrLoc = locWP15;
            case 16
                firstNbrLoc = locWP16;
            case 17
                firstNbrLoc = locWP17;
            case 18
                firstNbrLoc = locWP18;
            case 19
                firstNbrLoc = locWP19;
            case 20
                firstNbrLoc = locWP20;
            case 21
                firstNbrLoc = locWP21;
            case 22
                firstNbrLoc = locWP22;
            case 23
                firstNbrLoc = locWP23;
            case 24
                firstNbrLoc = locWP24;
            case 25
                firstNbrLoc = locWP25;
            case 26
                firstNbrLoc = locWP26;
            case 27
                firstNbrLoc = locWP27;
            case 28
                firstNbrLoc = locWP28;
            case 29
                firstNbrLoc = locWP29;
            case 30
                firstNbrLoc = locWP30;
            case 31
                firstNbrLoc = locWP31;
            case 32
                firstNbrLoc = locWP32;
        end
        secondNbr = totalCombs(it1,2);
        switch secondNbr
            case 1
                secondNbrLoc = locWP1;
            case 2
                secondNbrLoc = locWP2;
            case 3
                secondNbrLoc = locWP3;
            case 4
                secondNbrLoc = locWP4;
            case 5
                secondNbrLoc = locWP5;
            case 6
                secondNbrLoc = locWP6;
            case 7
                secondNbrLoc = locWP7;
            case 8
                secondNbrLoc = locWP8;
            case 9
                secondNbrLoc = locWP9;
            case 10
                secondNbrLoc = locWP10;
            case 11
                secondNbrLoc = locWP11;
            case 12
                secondNbrLoc = locWP12;
            case 13
                secondNbrLoc = locWP13;
            case 14
                secondNbrLoc = locWP14;
            case 15
                secondNbrLoc = locWP15;
            case 16
                secondNbrLoc = locWP16;
            case 17
                secondNbrLoc = locWP17;
            case 18
                secondNbrLoc = locWP18;
            case 19
                secondNbrLoc = locWP19;
            case 20
                secondNbrLoc = locWP20;
            case 21
                secondNbrLoc = locWP21;
            case 22
                secondNbrLoc = locWP22;
            case 23
                secondNbrLoc = locWP23;
            case 24
                secondNbrLoc = locWP24;
            case 25
                secondNbrLoc = locWP25;
            case 26
                secondNbrLoc = locWP26;
            case 27
                secondNbrLoc = locWP27;
            case 28
                secondNbrLoc = locWP28;
            case 29
                secondNbrLoc = locWP29;
            case 30
                secondNbrLoc = locWP30;
            case 31
                secondNbrLoc = locWP31;
            case 32
                secondNbrLoc = locWP32;
        end
        thirdNbr = totalCombs(it1,3);
        switch thirdNbr
            case 1
                thirdNbrLoc = locWP1;
            case 2
                thirdNbrLoc = locWP2;
            case 3
                thirdNbrLoc = locWP3;
            case 4
                thirdNbrLoc = locWP4;
            case 5
                thirdNbrLoc = locWP5;
            case 6
                thirdNbrLoc = locWP6;
            case 7
                thirdNbrLoc = locWP7;
            case 8
                thirdNbrLoc = locWP8;
            case 9
                thirdNbrLoc = locWP9;
            case 10
                thirdNbrLoc = locWP10;
            case 11
                thirdNbrLoc = locWP11;
            case 12
                thirdNbrLoc = locWP12;
            case 13
                thirdNbrLoc = locWP13;
            case 14
                thirdNbrLoc = locWP14;
            case 15
                thirdNbrLoc = locWP15;
            case 16
                thirdNbrLoc = locWP16;
            case 17
                thirdNbrLoc = locWP17;
            case 18
                thirdNbrLoc = locWP18;
            case 19
                thirdNbrLoc = locWP19;
            case 20
                thirdNbrLoc = locWP20;
            case 21
                thirdNbrLoc = locWP21;
            case 22
                thirdNbrLoc = locWP22;
            case 23
                thirdNbrLoc = locWP23;
            case 24
                thirdNbrLoc = locWP24;
            case 25
                thirdNbrLoc = locWP25;
            case 26
                thirdNbrLoc = locWP26;
            case 27
                thirdNbrLoc = locWP27;
            case 28
                thirdNbrLoc = locWP28;
            case 29
                thirdNbrLoc = locWP29;
            case 30
                thirdNbrLoc = locWP30;
            case 31
                thirdNbrLoc = locWP31;
            case 32
                thirdNbrLoc = locWP32;
        end
        d1 = sqrt((firstNbrLoc(1)-secondNbrLoc(1))^2 + (firstNbrLoc(2)-secondNbrLoc(2))^2);
        d2 = sqrt((firstNbrLoc(1)-thirdNbrLoc(1))^2 + (firstNbrLoc(2)-thirdNbrLoc(2))^2);
        d3 = sqrt((secondNbrLoc(1)-thirdNbrLoc(1))^2 + (secondNbrLoc(2)-thirdNbrLoc(2))^2);
        totalDist(it1) = d1+d2+d3;
    end
    % Converting back to string name
    [bestNbrComb,bestI] = min(totalDist);
    switch totalCombs(bestI,1)
        case 1
            NBR1 = 'WP1';
        case 2
            NBR1 = 'WP2';
        case 3
            NBR1 = 'WP3';
        case 4
            NBR1 = 'WP4';
        case 5
            NBR1 = 'WP5';
        case 6
            NBR1 = 'WP6';
        case 7
            NBR1 = 'WP7';
        case 8
            NBR1 = 'WP8';
        case 9
            NBR1 = 'WP9';
        case 10
            NBR1 = 'WP10';
        case 11
            NBR1 = 'WP11';
        case 12
            NBR1 = 'WP12';
        case 13
            NBR1 = 'WP13';
        case 14
            NBR1 = 'WP14';
        case 15
            NBR1 = 'WP15';
        case 16
            NBR1 = 'WP16';
        case 17
            NBR1 = 'WP17';
        case 18
            NBR1 = 'WP18';
        case 19
            NBR1 = 'WP19';
        case 20
            NBR1 = 'WP20';
        case 21
            NBR1 = 'WP21';
        case 22
            NBR1 = 'WP22';
        case 23
            NBR1 = 'WP23';
        case 24
            NBR1 = 'WP24';
        case 25
            NBR1 = 'WP25';
        case 26
            NBR1 = 'WP26';
        case 27
            NBR1 = 'WP27';
        case 28
            NBR1 = 'WP28';
        case 29
            NBR1 = 'WP29';
        case 30
            NBR1 = 'WP30';
        case 31
            NBR1 = 'WP31';
        case 32
            NBR1 = 'WP32';
    end
     
    switch totalCombs(bestI,2);
        case 1
            NBR2 = 'WP1';
        case 2
            NBR2 = 'WP2';
        case 3
            NBR2 = 'WP3';
        case 4
            NBR2 = 'WP4';
        case 5
            NBR2 = 'WP5';
        case 6
            NBR2 = 'WP6';
        case 7
            NBR2 = 'WP7';
        case 8
            NBR2 = 'WP8';
        case 9
            NBR2 = 'WP9';
        case 10
            NBR2 = 'WP10';
        case 11
            NBR2 = 'WP11';
        case 12
            NBR2 = 'WP12';
        case 13
            NBR2 = 'WP13';
        case 14
            NBR2 = 'WP14';
        case 15
            NBR2 = 'WP15';
        case 16
            NBR2 = 'WP16';
        case 17
            NBR2 = 'WP17';
        case 18
            NBR2 = 'WP18';
        case 19
            NBR2 = 'WP19';
        case 20
            NBR2 = 'WP20';
        case 21
            NBR2 = 'WP21';
        case 22
            NBR2 = 'WP22';
        case 23
            NBR2 = 'WP23';
        case 24
            NBR2 = 'WP24';
        case 25
            NBR2 = 'WP25';
        case 26
            NBR2 = 'WP26';
        case 27
            NBR2 = 'WP27';
        case 28
            NBR2 = 'WP28';
        case 29
            NBR2 = 'WP29';
        case 30
            NBR2 = 'WP30';
        case 31
            NBR2 = 'WP31';
        case 32
            NBR2 = 'WP32';
    end
    
    switch totalCombs(bestI,3);
        case 1
            NBR3 = 'WP1';
        case 2
            NBR3 = 'WP2';
        case 3
            NBR3 = 'WP3';
        case 4
            NBR3 = 'WP4';
        case 5
            NBR3 = 'WP5';
        case 6
            NBR3 = 'WP6';
        case 7
            NBR3 = 'WP7';
        case 8
            NBR3 = 'WP8';
        case 9
            NBR3 = 'WP9';
        case 10
            NBR3 = 'WP10';
        case 11
            NBR3 = 'WP11';
        case 12
            NBR3 = 'WP12';
        case 13
            NBR3 = 'WP13';
        case 14
            NBR3 = 'WP14';
        case 15
            NBR3 = 'WP15';
        case 16
            NBR3 = 'WP16';
        case 17
            NBR3 = 'WP17';
        case 18
            NBR3 = 'WP18';
        case 19
            NBR3 = 'WP19';
        case 20
            NBR3 = 'WP20';
        case 21
            NBR3 = 'WP21';
        case 22
            NBR3 = 'WP22';
        case 23
            NBR3 = 'WP23';
        case 24
            NBR3 = 'WP24';
        case 25
            NBR3 = 'WP25';
        case 26
            NBR3 = 'WP26';
        case 27
            NBR3 = 'WP27';
        case 28
            NBR3 = 'WP28';
        case 29
            NBR3 = 'WP29';
        case 30
            NBR3 = 'WP30';
        case 31
            NBR3 = 'WP31';
        case 32
            NBR3 = 'WP32';
    end
    RssiNbrs.(fname){1} = NBR1; 
    RssiNbrs.(fname){2} = NBR2; 
    RssiNbrs.(fname){3} = NBR3; 
end
out = RssiNbrs;
end

        
    
    
    
    
    
    
    

