function sviformat(INPUTMAT, PREFIX)

% sviformat finds edge pairs between regions in a correlation matrix and 
% writes the pairs row-by-row to a tab-delimited text file for subsequent 
% SVI analysis.
%
%   Usage:
%   sviformat(INPUTMAT, PREFIX)
%       INPUTMAT = binarized thresholded correlation matrix
%       PREFIX = optional; string for naming text file output.

[x y] = size(INPUTMAT);
edgeCount = sum(sum(INPUTMAT));

OUTPUT = zeros(edgeCount, 2);
outCount = 1;

for i = 1:x-1
    
    for j = i+1:y
        
        if INPUTMAT(i,j)==1
            
            OUTPUT(outCount,:) = [i j];
            outCount = outCount + 1;
            
        end
        
    end
    
end


if nargin>1
    file = [PREFIX 'formattedMat.txt'];
else
    file = 'formattedMat.txt';
end

dlmwrite(file, OUTPUT, '\t');

end