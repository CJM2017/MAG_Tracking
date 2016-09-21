function out = findRoom(solsMat)
% SolsMat is a struct containing all of the position estimates from the
% patiernt tracking localization method for each beacon in the environment.
% This method will evaluate the positions and place the patient in the room
% which they are most likely in. 
% This room location will be stored and plotted in the center of the room.

global pixelFactor

numBcns = numel(fieldnames(solsMat));
patientLocations = struct;
for(i = 1:numBcns)
    fname = sprintf('B%d',i);
    Px = pixelFactor * solsMat.(fname)(end,1); % end will be the most recent est. location
    Py = pixelFactor * solsMat.(fname)(end,2);
    
    % In Waiting Room?
    if((Px > 80) && (Px < 990) && (Py > 940) && (Py < 1230))
        location = 'Waiting Room';
    % In Mammo_1?
    elseif((Px > 500) && (Px < 690) && (Py > 730) && (Py < 895))
        location = 'M1';
    % In Mammo_2?
    elseif((Px > 290) && (Px < 435) && (Py > 470) && (Py < 670))
        location = 'M2';
    % In Mammo_3?
    elseif((Px > 864) && (Px < 1015) && (Py > 530) && (Py < 770))
        location = 'M3';
    % In Mammo_4?
    elseif((Px > 505) && (Px < 675) && (Py > 390) && (Py < 530))
        location = 'M4';
    % In Mammo_5?
    elseif((Px > 678) && (Px < 840) && (Py > 390) && (Py < 530))
        location = 'M5';
    % In Mammo_6?
    elseif((Px > 850) && (Px < 1055) && (Py > 388) && (Py < 520))
        location = 'M6';
    % In Mammo_7?
    elseif((Px > 900) && (Px < 1077) && (Py > 250) && (Py < 385))
        location = 'M7';
    % In Mammo_8?
    elseif((Px > 860) && (Px < 1077) && (Py > 70) && (Py < 245))
        location = 'M8';
    % In Ultra_1?
    elseif((Px > 505) && (Px < 645) && (Py > 530) && (Py < 670))
        location = 'U1';
    % In Ultra_2?
    elseif((Px > 650) && (Px < 785) && (Py > 530) && (Py < 670))
        location = 'U2';
    % In Restroom_1?
    elseif((Px > 310) && (Px < 430) && (Py > 735) && (Py < 815))
        location = 'B1';
    % In Restroom_2?
    elseif((Px > 865) && (Px < 965) && (Py > 770) && (Py < 845))
        location = 'B2';
    % In Restroom_3?
    elseif((Px > 675) && (Px < 780) && (Py > 225) && (Py < 305))
        location = 'B3';
    % Unknown?
    else
        location = 'Hall';
    end
    pname = sprintf('P%d',i);
    patientLocations.(pname) = location;
end

out = patientLocations;
    
end