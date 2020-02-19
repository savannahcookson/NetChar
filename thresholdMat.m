function THRESHMAT = thresholdMat(WEIGHTEDMAT,THRESHOLD)

% thresholdMat creates a triangular (upper) sparse correlation matrix of 
% the top percent of pairwise values in the upper triangle indicated by
% THRESHOLD.
%
%   Usage:
%   THRESHMAT = thresholdMat(WEIGHTEDMAT)
%       THRESHMAT = output trianular sparse matrix
%       WEIGHTEDMAT = subject-averaged, cleaned weighted correlation matrix
%       THRESHOLD = desired cutoff in percent of highest correlation vals
%       (decimal)

weightedTMat = triu(WEIGHTEDMAT,1);
[x y] = size(weightedTMat);

topTen = round(THRESHOLD*((x * (x - 1))/2));

lineMat = reshape(weightedTMat, [x^2,1]);
[sortedLineMat, idx] = sort(lineMat);
topLineInd = idx(end-(topTen-1):end);

colIndex = ceil(topLineInd/x);
rowIndex = mod(topLineInd,x);
rowIndex(rowIndex == 0) = x;

THRESHMAT = zeros(x,y);

for r = 1:length(rowIndex)
    
    THRESHMAT(rowIndex(r),colIndex(r)) = WEIGHTEDMAT(rowIndex(r),colIndex(r));
    
end

end