function BINARYMAT = binarizeMat(INPUTMATRIX)

% binarizeMat sets all nonzero values in a matrix to 1.
%
%   Usage:
%   BINARYMAT = thresholdMat(INPUTMATRIX)
%       BINARYMAT = output binarized matrix
%       INPUTMATRIX = input matrix, up to 3D

[x y z] = size(INPUTMATRIX);

BINARYMAT = zeros(x,y,z);

for d = 1:z
    for r = 1:x
        for c = 1:y
    
            if INPUTMATRIX(r,c,d) ~= 0
                BINARYMAT(r,c,d) = 1;
            end
            
        end
    end    
end

end