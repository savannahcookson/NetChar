function symMat = symmetrizeMat(triMat)

% Converts triangular correlation matrix to symmetrical. Expects subjects
% on the third dimension.

[x, y, s] = size(triMat);
symMat = zeros(x,y,s);

for i=1:s

    symMat(:,:,i) = triMat(:,:,i) + triMat(:,:,i)';
    
end
    
end