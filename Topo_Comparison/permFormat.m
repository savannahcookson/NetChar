function [perms, seeds] = permFormat(iterations,fileLoc,realMat)

% Formats the output files from diceScript.m from multiple iterations into
% an excel-friendly format. Expects files named according to their
% iteration number in .1D format.
%
% USAGE: permFormat(iterations,fileLoc,saveLoc)
%       INPUTS: iterations  - number of iterations run
%               fileLoc     - location of iteration output files
%               realMat     - 1 to run format on singleton results of
%               nonshuffled data; 0 otherwise. 1 sets loop to only run
%               value 0, where otherwise the loop runs from 1:iterations.
%               Expects real unformattted values to be in 0.1D.

raw = {};
seeds = [];

t = 1;

if realMat == 1
    iterations = 0;
    t = 0;
end
    

for i = t:iterations
    
    if mod(i,1000) == 0
        fprintf('iteration %d\n',i)
    end
    
    fh = fopen([fileLoc num2str(i) '.1D'],'r');
    raw1 = {};
    tline = fgetl(fh);
    
    seeds = [seeds; str2num(tline)];
    
    row = 1;
    col = 1;
    while ischar(tline)
        
        tline = fgetl(fh);
        if tline ~= -1
            raw1{row,col} = tline;
            row = row+1;
            if row > 8
                row = 1;
                col = col+1;
            end
        end
        
    end
    
    raw(:,:,end+1) = raw1;
    fclose(fh);
    
    
end

cellstr = raw(2:end,:,2:end);
[x y z] = size(cellstr);
cellmat = zeros(x,y,z);
for i = 1:x
    for j = 1:y
        for k = 1:z
            
            cellmat(i,j,k) = str2num(cellstr{i,j,k});
            
        end
    end
end

perms = cellmat;


end