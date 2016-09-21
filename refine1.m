function out1 = refine1(distances,PIs)
% Method to optimize the estimate (X,Y)
% location of a beacon by minimizing a Distance-Error equation 
% as opposed to trilaterating from known PI locations (3)

% distances holds the 3 distances between one beacon and each PI (3)
% PIs will contain the numbers of each PI
% This is needed in order to know Xi and Yi
% X,Y are to be optimized using fminsearch and mean square error

totalError = 0;
%for(i = 1:length(distances))
    %di = distances(i);
    di = distances;
    
    %Xi = PIs(i,1);
    %Yi = PIs(i,2);
    Xi = PIs(:,1)';
    Yi = PIs(:,2)';
    X = [0,0];      % Array for X and Y coordinates
    %{
    deltaX = X(1)-Xi;
    deltaY = X(2)-Yi;
    error = ((deltaX^2) + (deltaY^2)) - di^2;
    squareError = @(error) error^2;
    %}
    squareError = @(X) sum(((((X(1)-Xi).^2) + ((X(2)-Yi).^2)) - di.^2).^2);
    
    [X, fval, exitFlag] = fminsearch(squareError,X);
%end

out1 = X;
end