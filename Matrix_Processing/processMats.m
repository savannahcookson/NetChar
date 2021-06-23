function adjacencyMat = processMats(indivMats,includedROIs,excludedROIs,threshold,finalThreshold,finalBinarize,finalSymmetrize,prefix)

% Runs correlation matrix processing pipeline.Assumes constant threshold
% value.
%
% USAGE: adjacencyMat = processMats(indivMats,includedROIs,excludedROIs,finalThreshold,finalBinarize)
%       INPUTS:     indivMats - MxMxS correlation matrix for S subjects
%                   includedROIs - ROI numbers included in indivMats
%                   excludedROIs - full list of excluded ROIs across
%                   analyses
%                   threshold - percent to threshold represented as a 
%                       decimal between 0 and 1
%                   finalThreshold - 1 if yes, 0 if no
%                   finalBinarize - 1 if yes, 0 if no
%                   finalSymmetrize - 1 if yes, 0 if no
%                   prefix - SVI filename prefix or 0 if not producing
%       OUTPUTS:    adjacencyMat - processed correlation matrix

rMat = cutROIs(indivMats,includedROIs,excludedROIs);
drMat = zeroDiag(rMat);
ndrMat = zeroNegs(drMat);
tndrMat = thresholdMat(ndrMat,threshold);
btndrMat = binarizeMat(tndrMat);
adjacencyMat = mean(btndrMat,3);


if finalThreshold == 1
    adjacencyMat = symmetrizeMat(adjacencyMat);
    adjacencyMat = thresholdMat(adjacencyMat,threshold);

end

if finalBinarize == 1
    adjacencyMat = binarizeMat(adjacencyMat);
end

if finalSymmetrize == 1
    adjacencyMat = symmetrizeMat(adjacencyMat);
end

if prefix ~= 0
    sviformat(adjacencyMat,prefix);
end

end