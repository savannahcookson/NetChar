
function [FINALMAT, MISSINGROIS]  = corrMatConcat(SUBLIST, FILELOC, FILESUFFIX, ROIS)

% corrMatConcat loads in premade correlation matrices from each subject 
% specified SUBLIST from the directory FILELOC and combines them into a 
% 3d matrix with ROIS number of regions arranged along dimensions 1 and 2 
% and subjects along dimension 3. Removes and returns regions missing from 
% any subjects from all subject data. Currently expects data to start with 
% subject identifier.
%
%   Usage:
%   [FINALMAT, MISSINGROIS] = corrMatConcat(SUBLIST, FILELOC, FILESUFFIX, ROIS)
%       FINALMAT: output concatenated correlation matrix
%       MISSINGROIS: combined array of ROIs missing data from any subjects
%       SUBLIST: cell array of subject identifiers
%       FILELOC: string - directory of location of individual matrices
%       FILESUFFIX: string - suffix of matrix file that follows subject ID
%       ROIS: integer - number of regions included in correlation matrices

numSubs = length(SUBLIST);
FINALMAT = zeros(ROIS,ROIS,numSubs);
MISSINGROIS = [];

for k=1:numSubs
   
    if ischar(SUBLIST{k})
        filename = [FILELOC SUBLIST{k} FILESUFFIX];
    else
        filename = [FILELOC num2str(SUBLIST{k}) FILESUFFIX];
    end
   %fprintf('%s\n',filename)
   
   fh = fopen(filename);
   ROICount = textscan(fh,'# %f #');
   fclose(fh);
   ROIList = dlmread(filename, '\t', [4 0 4 ROICount{1}-1]);
   
   [tempMat, missingSubLevel] = fillMissingROIs(ROIList, filename);
   
   FINALMAT(:,:,k) = tempMat;
   
   MISSINGROIS = union(MISSINGROIS, missingSubLevel);
   fprintf('Subject %d complete\n', k)
       
end

   FINALMAT(MISSINGROIS,:,:) = [];
   FINALMAT(:,MISSINGROIS,:) = [];

end