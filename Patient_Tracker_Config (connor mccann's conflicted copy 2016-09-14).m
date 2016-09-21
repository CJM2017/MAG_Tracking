%==========================================================================
% Name    : Patient_Tracker Configuration Script
% Company : MAG
% Author  : Connor McCann
% Date    : 17 Jun 2016
%==========================================================================

% Raspberry Pis... Turn them on(1) or off(0)
global PiOne
global PiTwo
global PiThree
global PiFour
global PiFive
global PiSix
PiOne = 1;
PiTwo = 1;
PiThree = 1;
PiFour = 1;
PiFive = 1;
PiSix = 1;


% Program Elements: These can be turned on or off before executing program
global dataPath
global sampleSize
global runCtd
global desiredNeighborNum
global plotErrorCircles
global pathLossExpRange
global valToReplaceZero
global sampleWithAvg
global preventThreeInaRow
global environmentalFactor
global pixelFactor
global plotBCNs
global mapWithFloorPlan
global evalErrors
global checkVelocity
global savePositionImage
global setPastLocSize

dataPath = 'C:\Users\cj836\Dropbox\MATLAB_DB\Scanned_Data\';
%dataPath = '/Users/connormccann/Dropbox/mgh/MATLAB_DB/Scanned_Data/';

sampleSize = 2;                     % Number of files to be read per PI
desiredNeighborNum = 3;             % Only works for 3-NN
pathLossExpRange = 10;              % Found in calibratePathLossExp_FIX...sets max n value
valToReplaceZero = -92;             % Found in calibratePathLossExp_FIX...value to substitue for unavoidable 0 RSSI values
environmentalFactor = 0.0;          % NOT currently in use but DONT delete!!
pixelFactor = 1.12;                 % Found in mapping fcs...multiplication factor for coordinate to pixel plotting
mapWithFloorPlan = true;            % Maps locations over BI image instead of XY-Plot
preventThreeInaRow = false;         % Found in findNN_RSSI
plotErrorCircles = false;           % Found in mapFloor...plots trilateration circles over map
sampleWithAvg = true;               % Found in the avg filters ( <MODE> otherwise )
evalErrors = false;                 % Found in Patient_Tracker...bottom
checkVelocity = false;              % Found in Patient_Tracker
plotBCNs = true;                    % Found in mapFloor
savePositionImage = true;           % Found in mapFloor(s)
runCtd = true;                      % Found in patient_tracker...true means the program will loop
setPastLocSize = false;              % Found in stackResults...will keep historical location set for each beacon down to 10

% Ble Waypoint Mac IDs
global WP1 WP2 WP3 WP4 WP5...
       WP6 WP7 WP8 WP9 WP10...
       WP11 WP12 WP13 WP14 WP15...
       WP16 WP17 WP18 WP19 WP20...
       WP21 WP22 WP23 WP24 WP25...
       WP26 WP27 WP28 WP29 WP30...
       WP31 WP32  
% Ble Mobile Beacon IDs
global B1 B2 B3 B4 B5

WP1 = 'f4:79:2e:4e:71:b9';
WP2 = 'd1:2f:a7:58:cb:1f';
WP3 = 'ea:e5:f1:2b:8a:1c';
WP4 = 'f4:ef:75:02:9d:3e';
WP5 = 'fb:59:8a:66:5b:4f';

WP6 = 'd1:f7:72:f2:ce:fd';
WP7 = 'f5:0f:dd:e0:69:01';
WP8 = 'ca:da:0e:4a:72:a1';
WP9 = 'ee:42:e3:51:6b:5c';
WP10 = 'e6:f2:6f:6d:76:d6';

WP11 = 'c8:a7:7c:85:2e:b3';
WP12 = 'fa:a0:26:cb:6e:89';
WP13 = 'e5:6c:83:d2:27:73';
WP14 = 'e7:d7:78:9b:1e:43';
WP15 = 'fa:40:4a:7d:56:43';

WP16 = 'c7:fd:03:cc:57:28';
WP17 = 'f9:30:03:38:0c:78';
WP18 = 'd4:3d:ad:40:bf:48';
WP19 = 'fd:b8:0d:03:07:2c';
WP20 = 'f0:c2:3d:08:28:de';

WP21 = 'dc:31:90:e1:1c:30';
WP22 = 'c7:9b:3d:ef:af:d3';
WP23 = 'c2:4d:30:cc:a4:aa';
WP24 = 'f3:7f:32:da:9e:23';
WP25 = 'fe:9b:aa:23:c0:fe';

WP26 = 'f6:51:95:91:72:03';
WP27 = 'f6:72:9f:b9:db:bb';
WP28 = 'd9:fd:11:e7:d9:db';
WP29 = 'ec:85:53:79:07:2f';
WP30 = 'ff:09:20:b8:c0:c1';

WP31 = 'fb:60:55:b5:5a:f3';
WP32 = 'da:a6:d8:fb:63:36';

B1 = 'fc:04:2a:8b:85:23';
B2 = 'df:61:b6:0a:a0:a9';
B3 = 'ea:ae:83:7d:9b:51';
B4 = 'f1:28:fe:81:d0:fb';
B5 = 'e6:a8:25:48:a8:76';


% Ble Waypoint Coordinates
global locPiOne locPiTwo locPiThree... 
       locPiFour locPiFive locPiSix
% Ble Waypooint Coordinates
global locWP1 locWP2 locWP3 locWP4 locWP5...
       locWP6 locWP7 locWP8 locWP9 locWP10...
       locWP11 locWP12 locWP13 locWP14 locWP15...
       locWP16 locWP17 locWP18 locWP19 locWP20...
       locWP21 locWP22 locWP23 locWP24 locWP25...
       locWP26 locWP27 locWP28 locWP29 locWP30...
       locWP31 locWP32     
% Ble Mobile Beacon Coordinates
global locBCN1 locBCN2 locBCN3 locBCN4 locBCN5

%==========================================================================
%                               BI Testing
%==========================================================================

% PIs
locPiOne = [165,281];
locPiTwo = [95	1085];
locPiThree = [259,540];
locPiFour = [873.2142857	631.25];
locPiFive = [758.9285714	926.9642857];
locPiSix = [950,163];




% WPs
locWP1 = [690.75	535.6071429];
locWP2 = [629.75	573.6071429];
locWP3 = [579.7857143	557.6071429];
locWP4 = [449.1071429	549.9285714];
locWP5 = [513.1071429	570.9285714];

locWP6 = [449.1071429	403.4285714];
locWP7 = [539.0714286	462.5];
locWP8 = [591.0714286	346.4285714];
locWP9 = [599.1071429	407.8214286];
locWP10 = [707.75	456.0357143];

locWP11 = [735.7142857	354.4642857];
locWP12 = [894.25	345.8571429];
locWP13 = [864.4642857	458.9285714];
locWP14 = [763.7857143	452.6785714];
locWP15 = [860.4642857	332.8214286];

locWP16 = [915.7857143	204.4642857];
locWP17 = [801.7857143	275.2857143];
locWP18 = [600.8928571	245.6071429];
locWP19 = [363.6785714	587.5];
locWP20 = [364.6785714	415.1785714];

locWP21 = [450.8928571	646.4285714];
locWP22 = [601.5714286	715.4285714];
locWP23 = [669.6428571	1086.607143];
locWP24 = [767.8571429	654.2857143];
locWP25 = [770.8571429	504.75];

locWP26 = [761.6071429	767.6071429];
locWP27 = [817.5714286	941.9642857];
locWP28 = [559.5714286	784.8214286];
locWP29 = [365.8214286	910.7142857];
locWP30 = [384.8214286	846.7142857];

locWP31 = [385.7142857	667.9642857];
locWP32 = [466.8928571	274.1071429];

%BCNs
locBCN1 = [654.4642857	670.5357143];
locBCN2 = [504.8571429	592.8571429];
locBCN3 = [733.0357143	468.75];
locBCN4 = [373.2142857	404.4642857];
locBCN5 = [669.6428571	1086.607143];
