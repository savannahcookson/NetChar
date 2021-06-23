function DKL = relativeEntropy(px,varargin)

% Computes the Kullback–Leibler divergence in entropy DKL between a probability
% distribution px and a reference distribution qx. If qx is not provided,
% qx is set to a uniform distribution equal in length to px.
%
% USAGE:DKL = relativeEntropy(px,qx)
%       INPUTS:     px: vector containing a probability distribution
%                   qx: vector containing reference distribution
%       OUTPUTS:    DKL: relative entropy of px with respect to qx

if length(varargin) > 0
    qx = varargin(1);
else
    qx = (1/length(px))*ones(1,length(px));
end

DKLVec = [];

for i = 1:length(px)
    
    DKLVec(end+1) = px(i)*log(px(i)/qx(i));
    
end

DKLVec(isnan(DKLVec)) = 0;
DKL = sum(DKLVec);

end