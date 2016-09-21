function [out1,out2,out3] = grabRecent(varargin)
% num is the numbe of files desired for taking the sample
% Each file represents a 15 second scan
% ID the most recent files
% Auto add number of pis
% All hard code in config file

% Assigning the values from the variable arguments 
num = varargin{1};
if(length(varargin) == 2)
    folder = strcat(varargin{2},'/');%'\'
    %fprintf('Now using %s directory',folder)
else
    folder = '';
end

global PiOne
global PiTwo
global PiThree
global PiFour
global PiFive
global PiSix

% Ble Waypoint Mac IDs
global WP1 WP2 WP3 WP4 WP5...
       WP6 WP7 WP8 WP9 WP10...
       WP11 WP12 WP13 WP14 WP15...
       WP16 WP17 WP18 WP19 WP20...
       WP21 WP22 WP23 WP24 WP25...
       WP26 WP27 WP28 WP29 WP30...
       WP31 WP32
   
global B1 B2 B3 B4 B5

global vecPi
% Stores the necessary paths to data accoridng to the number of Pis present
vecPi = {};
n = 1;
if(PiOne)
    vecPi{n} = 'Pi_One';
    n = n+1;
end

if(PiTwo)
    vecPi{n} = 'Pi_Two';
    n = n+1;
end
if(PiThree)
    vecPi{n} = 'Pi_Three';
    n = n+1;
end
if(PiFour)
    vecPi{n} = 'Pi_Four';
    n = n+1;
end
if(PiFive)
    vecPi{n} = 'Pi_Five';
    n = n+1;
end
if(PiSix)
    vecPi{n} = 'Pi_Six';
    n = n+1;
end

% Some variables
numPis = numel(vecPi);
waypoints_RSSI = struct;
beacons_RSSI = struct;
waypoints_Time = struct;
beacon_Time = struct;
fileTimeMat = [];

% Order the list of files: newest - oldest for each deployed Pi
for(h = 1:numPis)
    global dataPath    
    ourPath = strcat(dataPath,vecPi{h},'/'); %'\',folder);
    fprintf('our current path: %s\n',ourPath)
    d = dir(ourPath);
    [dx,dx] = sort([d.datenum],'descend');
    i = 1;
    j = 1;
    fileVec = cell(1,num);
    done = false;
    % Place the ordered list of *.csv files into a cell array
    latestFileTimes = [];
    one = true;
    two = true;
    three = true;
    four = true;
    five = true;
    six = true;
    
    % Below, we loop through sorted list of filetimes and store however
    % many the global sampleSize variable is calling for.
    % This is repeated for each PI
    while (~done)
        if(strcmp(d(dx(j)).name(end),'v')) % Making sure the file actually ends in .csv
            fileVec{i} = d(dx(j)).name;
            switch h
                case 1
                    if(one)
                        latestFileTimes = [latestFileTimes,d(dx(j)).datenum];
                        %one = false;
                    end
                case 2
                    if(two)
                        latestFileTimes = [latestFileTimes,d(dx(j)).datenum];
                        %two = false;
                    end
                case 3
                    if(three)
                        latestFileTimes = [latestFileTimes,d(dx(j)).datenum];
                        %three = false;
                    end
                case 4
                    if(four)
                        latestFileTimes = [latestFileTimes,d(dx(j)).datenum];
                        %four = false;
                    end
                case 5
                    if(five)
                        latestFileTimes = [latestFileTimes,d(dx(j)).datenum];
                        %five = false;
                    end
                case 6
                    if(six)
                        latestFileTimes = [latestFileTimes,d(dx(j)).datenum];
                        %six = false;
                    end         
            end
            i = i+1;
            j = j+1;
        else
            j = j+1;
        end
        if(i > num)
            done = true;
        end
    end
    
    % This matrix contains the file times for each PI where each row is a
    % PI
    fileTimeMat = vertcat(fileTimeMat,latestFileTimes);
    
    % Vectors of RSSI Value for each Waypoint or Beacon
    WP1_RSSI_Vec = [];
    WP2_RSSI_Vec = [];
    WP3_RSSI_Vec = [];
    WP4_RSSI_Vec = [];
    WP5_RSSI_Vec = [];
    
    WP6_RSSI_Vec = [];
    WP7_RSSI_Vec = [];
    WP8_RSSI_Vec = [];
    WP9_RSSI_Vec = [];
    WP10_RSSI_Vec = [];
    
    WP11_RSSI_Vec = [];
    WP12_RSSI_Vec = [];
    WP13_RSSI_Vec = [];
    WP14_RSSI_Vec = [];
    WP15_RSSI_Vec = [];
    
    WP16_RSSI_Vec = [];
    WP17_RSSI_Vec = [];
    WP18_RSSI_Vec = [];
    WP19_RSSI_Vec = [];
    WP20_RSSI_Vec = [];
    
    WP21_RSSI_Vec = [];
    WP22_RSSI_Vec = [];
    WP23_RSSI_Vec = [];
    WP24_RSSI_Vec = [];
    WP25_RSSI_Vec = [];
    
    WP26_RSSI_Vec = [];
    WP27_RSSI_Vec = [];
    WP28_RSSI_Vec = [];
    WP29_RSSI_Vec = [];
    WP30_RSSI_Vec = [];
    
    WP31_RSSI_Vec = [];
    WP32_RSSI_Vec = [];

    B1_RSSI_Vec = [];
    B2_RSSI_Vec = [];
    B3_RSSI_Vec = [];
    B4_RSSI_Vec = [];
    B5_RSSI_Vec = [];
  
    % num is the arg to the function which specifies
    % the # of files to sample 
    % The for loop reads every file and stores the RSSI values into their
    % appropriate vectors.
    % This must be rewritten soon so it can be more readily expanded
    for k = 1:num
          fid = fopen(strcat(ourPath,fileVec{k}),'r');
          if fid == -1
              disp('Error opening the file')
          else
              while feof(fid) == 0
                  line = fgetl(fid);
                  currentWp = line(1:17);
                  switch currentWp
                      case WP1
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP1_RSSI_Vec = horzcat(WP1_RSSI_Vec,RSSI);
                      case WP2
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP2_RSSI_Vec = horzcat(WP2_RSSI_Vec,RSSI);
                      case WP3
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP3_RSSI_Vec = horzcat(WP3_RSSI_Vec,RSSI);
                      case WP4
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP4_RSSI_Vec = horzcat(WP4_RSSI_Vec,RSSI);
                      case WP5
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP5_RSSI_Vec = horzcat(WP5_RSSI_Vec,RSSI);
                      case WP6
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP6_RSSI_Vec = horzcat(WP6_RSSI_Vec,RSSI);
                      case WP7
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP7_RSSI_Vec = horzcat(WP7_RSSI_Vec,RSSI);
                      case WP8
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP8_RSSI_Vec = horzcat(WP8_RSSI_Vec,RSSI);
                      case WP9
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP9_RSSI_Vec = horzcat(WP9_RSSI_Vec,RSSI);
                      case WP10
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP10_RSSI_Vec = horzcat(WP10_RSSI_Vec,RSSI);
                      case WP11
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP11_RSSI_Vec = horzcat(WP11_RSSI_Vec,RSSI);
                      case WP12
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP12_RSSI_Vec = horzcat(WP12_RSSI_Vec,RSSI);
                      case WP13
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP13_RSSI_Vec = horzcat(WP13_RSSI_Vec,RSSI);
                      case WP14
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP14_RSSI_Vec = horzcat(WP14_RSSI_Vec,RSSI);
                      case WP15
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP15_RSSI_Vec = horzcat(WP15_RSSI_Vec,RSSI);
                      case WP16
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP16_RSSI_Vec = horzcat(WP16_RSSI_Vec,RSSI);
                      case WP17
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP17_RSSI_Vec = horzcat(WP17_RSSI_Vec,RSSI);
                      case WP18
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP18_RSSI_Vec = horzcat(WP18_RSSI_Vec,RSSI);
                      case WP19
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP19_RSSI_Vec = horzcat(WP19_RSSI_Vec,RSSI);
                      case WP20
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP20_RSSI_Vec = horzcat(WP20_RSSI_Vec,RSSI);
                      case WP21
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP21_RSSI_Vec = horzcat(WP21_RSSI_Vec,RSSI); 
                      case WP22
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP22_RSSI_Vec = horzcat(WP22_RSSI_Vec,RSSI);
                      case WP23
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP23_RSSI_Vec = horzcat(WP23_RSSI_Vec,RSSI); 
                      case WP24
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP24_RSSI_Vec = horzcat(WP24_RSSI_Vec,RSSI);
                      case WP25
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP25_RSSI_Vec = horzcat(WP25_RSSI_Vec,RSSI);  
                      case WP26
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP26_RSSI_Vec = horzcat(WP26_RSSI_Vec,RSSI);
                      case WP27
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP27_RSSI_Vec = horzcat(WP27_RSSI_Vec,RSSI);
                      case WP28
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP28_RSSI_Vec = horzcat(WP28_RSSI_Vec,RSSI);
                      case WP29
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP29_RSSI_Vec = horzcat(WP29_RSSI_Vec,RSSI); 
                      case WP30
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP30_RSSI_Vec = horzcat(WP30_RSSI_Vec,RSSI);
                      case WP31
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP31_RSSI_Vec = horzcat(WP31_RSSI_Vec,RSSI);
                      case WP32
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          WP32_RSSI_Vec = horzcat(WP32_RSSI_Vec,RSSI);
                      case B1
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          B1_RSSI_Vec = horzcat(B1_RSSI_Vec,RSSI);
                      case B2
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          B2_RSSI_Vec = horzcat(B2_RSSI_Vec,RSSI);
                      case B3
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          B3_RSSI_Vec = horzcat(B3_RSSI_Vec,RSSI);
                      case B4
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          B4_RSSI_Vec = horzcat(B4_RSSI_Vec,RSSI);
                      case B5
                          RSSI = str2num(line(29:31));
                          if(RSSI > 0)
                              RSSI = -1*RSSI;
                          end
                          B5_RSSI_Vec = horzcat(B5_RSSI_Vec,RSSI);
                  end
              end
              closeResult = fclose(fid);
              if closeResult == 0
                  %disp('File Close Successful')
              else
                  disp('Error Closing File')
              end
          end
    end
    
    % Save the vectors as a structure and pass it out
    % Each structure contains the waypoint measured by each RPi
    % This section should probably be re-written to be a looped struct
    % formation 
    if (h == 1)
        waypoints_RSSI = struct('WP1',WP1_RSSI_Vec,...
                                'WP2',WP2_RSSI_Vec,...
                                'WP3',WP3_RSSI_Vec,...
                                'WP4',WP4_RSSI_Vec,...
                                'WP5',WP5_RSSI_Vec,...
                                'WP6',WP6_RSSI_Vec,...
                                'WP7',WP7_RSSI_Vec,...
                                'WP8',WP8_RSSI_Vec,...
                                'WP9',WP9_RSSI_Vec,...
                                'WP10',WP10_RSSI_Vec,...
                                'WP11',WP11_RSSI_Vec,...
                                'WP12',WP12_RSSI_Vec,...
                                'WP13',WP13_RSSI_Vec,...
                                'WP14',WP14_RSSI_Vec,...
                                'WP15',WP15_RSSI_Vec,...
                                'WP16',WP16_RSSI_Vec,...
                                'WP17',WP17_RSSI_Vec,...
                                'WP18',WP18_RSSI_Vec,...
                                'WP19',WP19_RSSI_Vec,...
                                'WP20',WP20_RSSI_Vec,...
                                'WP21',WP21_RSSI_Vec,...
                                'WP22',WP22_RSSI_Vec,...
                                'WP23',WP23_RSSI_Vec,...
                                'WP24',WP24_RSSI_Vec,...
                                'WP25',WP25_RSSI_Vec,...
                                'WP26',WP26_RSSI_Vec,...
                                'WP27',WP27_RSSI_Vec,...
                                'WP28',WP28_RSSI_Vec,...
                                'WP29',WP29_RSSI_Vec,...
                                'WP30',WP30_RSSI_Vec,...
                                'WP31',WP31_RSSI_Vec,...
                                'WP32',WP32_RSSI_Vec);

         beacons_RSSI = struct('B1',B1_RSSI_Vec,...
                               'B2',B2_RSSI_Vec,...
                               'B3',B3_RSSI_Vec,...
                               'B4',B4_RSSI_Vec,...
                               'B5',B5_RSSI_Vec);
    else
         waypoints_RSSI(h) = struct('WP1',WP1_RSSI_Vec,...
                                    'WP2',WP2_RSSI_Vec,...
                                    'WP3',WP3_RSSI_Vec,...
                                    'WP4',WP4_RSSI_Vec,...
                                    'WP5',WP5_RSSI_Vec,...
                                    'WP6',WP6_RSSI_Vec,...
                                    'WP7',WP7_RSSI_Vec,...
                                    'WP8',WP8_RSSI_Vec,...
                                    'WP9',WP9_RSSI_Vec,...
                                    'WP10',WP10_RSSI_Vec,...
                                    'WP11',WP11_RSSI_Vec,...
                                    'WP12',WP12_RSSI_Vec,...
                                    'WP13',WP13_RSSI_Vec,...
                                    'WP14',WP14_RSSI_Vec,...
                                    'WP15',WP15_RSSI_Vec,...
                                    'WP16',WP16_RSSI_Vec,...
                                    'WP17',WP17_RSSI_Vec,...
                                    'WP18',WP18_RSSI_Vec,...
                                    'WP19',WP19_RSSI_Vec,...
                                    'WP20',WP20_RSSI_Vec,...
                                    'WP21',WP21_RSSI_Vec,...
                                    'WP22',WP22_RSSI_Vec,...
                                    'WP23',WP23_RSSI_Vec,...
                                    'WP24',WP24_RSSI_Vec,...
                                    'WP25',WP25_RSSI_Vec,...
                                    'WP26',WP26_RSSI_Vec,...
                                    'WP27',WP27_RSSI_Vec,...
                                    'WP28',WP28_RSSI_Vec,...
                                    'WP29',WP29_RSSI_Vec,...
                                    'WP30',WP30_RSSI_Vec,...
                                    'WP31',WP31_RSSI_Vec,...
                                    'WP32',WP32_RSSI_Vec);

         beacons_RSSI(h) = struct('B1',B1_RSSI_Vec,...
                                  'B2',B2_RSSI_Vec,...
                                  'B3',B3_RSSI_Vec,...
                                  'B4',B4_RSSI_Vec,...
                                  'B5',B5_RSSI_Vec);
                              

    end
     
end

% Assign the function outputs their values
out1 = waypoints_RSSI;
out2 = beacons_RSSI;
out3 = fileTimeMat;
end