function trimmedMat = cutROIs(inputMat, includedROIs,excludedROIs)

% cutROIs removes rows and columns of a given symmetrical correlation
% matrix that correspond to the indicated ROIs. ROIs indicated for
% exclusion can already be excluded from the input matrix.
%
%   Usage:
%   trimmedMat = cutROIs(inputMat, includedROIs,excludedROIs)
%       trimmedMat = output matrix retaining only values for remaining ROIs
%       inputMat = input square symmetrical matrix
%       includedROIs = vector of ROI labels for inputMat rows and columns
%       excludedROIs = vector of ROI labels to be excluded

exclusionIndices = [];

for r = 1:length(excludedROIs)
    
    if ismember(excludedROIs(r),includedROIs)
        
        exclusionIndices = [exclusionIndices; find(includedROIs == excludedROIs(r))];
        
    end
    
end

inclusionIndices = setdiff(1:length(includedROIs),exclusionIndices);
trimmedMat = inputMat(inclusionIndices,inclusionIndices,:);

end