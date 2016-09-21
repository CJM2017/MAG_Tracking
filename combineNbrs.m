function out = combineNbrs(RssiNbrs,countNbrs)
% Method to take substitue the 3 member of RSSI neighbors with the first
% member from count neighbors

numBcns = numel(fieldnames(RssiNbrs));
makeSwap = true;
for(i = 1:numBcns)
    fname = sprintf('B%d',i);
    COUNT = countNbrs.(fname){1};
    switch COUNT
        case 'WP1'
            COUNT = 1;
        case 'WP2'
            COUNT = 2;
        case 'WP3'
            COUNT = 3;
        case 'WP4'
            COUNT = 4;
        case 'WP5'
            COUNT = 5;
        case 'WP6'
            COUNT = 6;
        case 'WP7'
            COUNT = 7;
        case 'WP8'
            COUNT = 8;
        case 'WP9'
            COUNT = 9;
        case 'WP10'
            COUNT = 10;
        case 'WP11'
            COUNT = 11;
        case 'WP12'
            COUNT = 12;
        case 'WP13'
            COUNT = 13;
        case 'WP14'
            COUNT = 14;
        case 'WP15'
            COUNT = 15;
        case 'WP16'
            COUNT = 16;
        case 'WP17'
            COUNT = 17;
        case 'WP18'
            COUNT = 18;
        case 'WP19'
            COUNT = 19;
        case 'WP20'
            COUNT = 20;
        case 'WP21'
            COUNT = 21;
        case 'WP22'
            COUNT = 22;
        case 'WP23'
            COUNT = 23;
        case 'WP24'
            COUNT = 24;
        case 'WP25'
            COUNT = 25;
        case 'WP26'
            COUNT = 26;
        case 'WP27'
            COUNT = 27;
        case 'WP28'
            COUNT = 28;
        case 'WP29'
            COUNT = 29;
        case 'WP30'
            COUNT = 30;
        case 'WP31'
            COUNT = 31;
        case 'WP32'
            COUNT = 32;
    end 
    for(j = 1:3)
        RSSI = RssiNbrs.(fname){j};
        switch RSSI
            case 'WP1'
                RWPnum = 1;
            case 'WP2'
                RWPnum = 2;
            case 'WP3'
                RWPnum = 3;
            case 'WP4'
                RWPnum = 4;
            case 'WP5'
                RWPnum = 5;
            case 'WP6'
                RWPnum = 6;
            case 'WP7'
                RWPnum = 7;
            case 'WP8'
                RWPnum = 8;
            case 'WP9'
                RWPnum = 9;
            case 'WP10'
                RWPnum = 10;
            case 'WP11'
                RWPnum = 11;
            case 'WP12'
                RWPnum = 12;
            case 'WP13'
                RWPnum = 13;
            case 'WP14'
                RWPnum = 14;
            case 'WP15'
                RWPnum = 15;
            case 'WP16'
                RWPnum = 16;
            case 'WP17'
                RWPnum = 17;
            case 'WP18'
                RWPnum = 18;
            case 'WP19'
                RWPnum = 19;
            case 'WP20'
                RWPnum = 20;
            case 'WP21'
                RWPnum = 21;
            case 'WP22'
                RWPnum = 22;
            case 'WP23'
                RWPnum = 23;
            case 'WP24'
                RWPnum = 24;
            case 'WP25'
                RWPnum = 25;
            case 'WP26'
                RWPnum = 26;
            case 'WP27'
                RWPnum = 27;
            case 'WP28'
                RWPnum = 28;
            case 'WP29'
                RWPnum = 29;
            case 'WP30'
                RWPnum = 30;
            case 'WP31'
                RWPnum = 31;
            case 'WP32'
                RWPnum = 32;
        end  
        if(RWPnum ~= COUNT)
            makeSwap = true;
        else
            makeSwap = false;
            break;
        end
    end
    if(makeSwap)
        RssiNbrs.(fname){3} = countNbrs.(fname){1};
    end
end
out = RssiNbrs;
end