function ZEROMAT = zeroDiag(NONZEROMAT)

% zeroDiag sets the diagonal of a square matrix to zero. treats 1st and 2nd
% dimensions as rows and columns of correlation matrices. Third dimension
% can be used to index individual subjects
%
%   Usage:
%   ZEROMAT = zeroDiag(NONZEROMAT)
%       ZEROMAT = output matrix with zeroed diagonal
%       NONZEROMAT = input square matrices

[x,~,s] = size(NONZEROMAT);
ZEROMAT = NONZEROMAT;

for j = 1:s
    for i = 1:x
    
        ZEROMAT(i,i,j) = 0;
        
    end
    
end

end