function [vecRSSI,meanRSSI] = oneMeterCal()
% Method to calibrate the average RSSI signal from 1 meter distance
% Note: this loop is run everytime but it should be saved as a .mat file
% and just loaded as a single value

ourPath = 'C:\Users\cy911\Dropbox\MATLAB_DB\Scanned_Data\Pi_One\one_Meter_Data\';
%ourPath = '/Users/connormccann/Dropbox/mgh/MATLAB_DB/Scanned_Data/Pi_One/one_Meter_Data/';

d = dir(ourPath);
numFiles = length(d(not([d.isdir])));
[dx,dx] = sort([d.datenum],'descend');
i = 1;
j = 1;
fileVec = cell(1,numFiles);
done = false;

% Place the ordered list of *.csv files into a cell array
while (~done)
    if(strcmp(d(dx(j)).name(end),'v'))
        fileVec{i} = d(dx(j)).name;
        i = i+1;
        j = j+1;
    else
        j = j+1;
    end
    if(i > numFiles)
        done = true;
    end
end

B3 = 'e5:6c:83:d2:27:73';
B3_RSSI_Vec = [];

for k = 1:numFiles
    fid = fopen(strcat(ourPath,fileVec{k}),'r');
    if fid == -1
        disp('Error opening the file')
    else
        while feof(fid) == 0
            line = fgetl(fid);
            if(line(1:17) == B3)
                RSSI = str2num(line(29:31));
                if(RSSI > 0)
                    RSSI = -1*RSSI;
                end
                B3_RSSI_Vec = horzcat(B3_RSSI_Vec,RSSI);
            end
        end
    end
    closeResult = fclose(fid);
    if closeResult ~= 0
        disp('Error Closing File')
    end
end
vecRSSI = B3_RSSI_Vec;
meanRSSI = mean(B3_RSSI_Vec);
end
