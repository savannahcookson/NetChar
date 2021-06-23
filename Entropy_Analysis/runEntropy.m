function [numNets, ROI_DKL] = runEntropy(groups)

[M, ~] = size(groups);
ROI_DKL = [];
numNets = [];

[~, sortInd] = sort(groups(:,2));
groups = groups(sortInd,:);

for i = 1:M
    
    px = groups(i,3:end);
    ROI_DKL(end+1,1) = relativeEntropy(px);
    numNets(end+1) = sum(px > 0);
    
end

end