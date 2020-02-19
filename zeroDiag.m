function ZEROMAT = zeroDiag(NONZEROMAT)

% zeroDiag sets the diagonal of a square matrix to zero.
%
%   Usage:
%   ZEROMAT = zeroDiag(NONZEROMAT)
%       ZEROMAT = output matrix with zeroed diagonal
%       NONZEROMAT = input square matrix

x = length(NONZEROMAT(:,1));
ZEROMAT = NONZEROMAT;

for i = 1:x
    
    ZEROMAT(i,i) = 0;
    
end

end