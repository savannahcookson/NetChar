function [SUBMAT MISSINGROIS] = fillMissingROIs(ROILIST, FILENAME)

% fillMissingROIs checks ROI header for missing ROIs. Returns input matrix 
% if ROIList is the correct size. If ROIList is missing values, the 
% function finds indices for which the ROI values are not contiguous and 
% inserts columns and rows of NaN for subsequent processing.
%   Usage:
%   [SUBMAT MISSINGROIS] = fillMissingROIs(ROILIST, FILENAME)
%       SUBMAT = returned formatted correlation matrix
%       MISSINGROIS = returned array of ROIs missing from the subject's data
%       ROILIST = array of ROI indices contained in subject data
%       FILENAME = subject's correlation matrix file

%Remove 0s that have been appended to incomplete ROI lists
while ROILIST(end) == 0
    
   ROILIST(end) = [];
    
end

MISSINGROIS = [];
%check for ROIs missing from current subject data
if length(ROILIST) == 1000
    
    fprintf('Subject is not missing ROIs\n')
    SUBMAT = dlmread(FILENAME, '\t', 1007, 0);
    
else
    
    totalMissing = 1000 - length(ROILIST);
    SUBMAT = dlmread(FILENAME, '\t', 1007 - totalMissing, 0);
    missingSubCount = 0;
    
    if(ROILIST(1) ~= 1)
        MISSINGROIS(end+1) = 1;
        
        x = length(SUBMAT);
        SUBMAT = [zeros(1,x); SUBMAT];
        SUBMAT = [zeros(x+1,1) SUBMAT];
        
        missingSubCount = missingSubCount + 1;
    end
    
    for i = 2:length(ROILIST)
        
        if(ROILIST(i) ~= ROILIST(i-1) + 1)
            % check for multiple missing ROIs
            missingROIs = ROILIST(i)-ROILIST(i-1)-1;
            
            for r = 1:missingROIs
                MISSINGROIS(end+1) = i + missingSubCount+r-1;
            end

            x = length(SUBMAT);
            SUBMAT = [SUBMAT(1:i+missingSubCount-1,:); zeros(missingROIs,x); SUBMAT(i+missingSubCount:end,:)];
            SUBMAT = [SUBMAT(:,1:i+missingSubCount-1) zeros(x+missingROIs,missingROIs) SUBMAT(:,i+missingSubCount:end)];

            missingSubCount = missingSubCount + missingROIs;
                
        end
            
    end
        
end  
end