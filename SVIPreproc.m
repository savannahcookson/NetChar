function [includedROIs, binaryMat] = SVIPreproc(ROIS, MISSINGROIS, INDIVMATS, PREFIX)

% SVIPreproc runs the full procedure for preprocessing the individual
% correlation matrices into a formatted average matrix for SVI analysis.
%   Usage:
%   [includedROIs, binaryMat] = SVIPreproc(ROIS, MISSINGROIS, INDIVMATS, PREFIX)
%       includedROIs = returned ordered list of ROIs actually included in
%       the matrix across all subjects
%       binaryMat = returned cleaned matrix
%       ROIS = integer number of ROIs included in the original parcellation
%       MISSINGROIS = array of ROI indices that were cut during extraction
%       and concatenation of the individual matrices
%       INDIVMATS = concatenated matrix of the individual correlation
%       matrices, where subjects are represented by the 3rd dimension.
%       PREFIX = file prefix for output formatted matrix

allROIs = [1:ROIS];
allROIs = allROIs';

includedROIs = setdiff(allROIs,MISSINGROIS);

avgMat = subAvg(INDIVMATS);

avgMatPos = zeroNegs(avgMat);

weightedMat = zeroDiag(avgMatPos);

threshMat = thresholdMat(weightedMat,.1);

binaryMat = binarizeMat(threshMat);

sviformat(binaryMat,PREFIX);

end