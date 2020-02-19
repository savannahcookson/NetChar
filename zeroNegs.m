function POSMAT = zeroNegs(SIGNEDMAT)

% zeroNegs sets negative values of a square matrix to zero.
%
%   Usage:
%   POSMAT = zeroNegs(SIGNEDMAT)
%       POSMAT = output matrix retaining only positive values
%       SIGNEDMAT = input square matrix

[x, y] = size(SIGNEDMAT);
POSMAT = SIGNEDMAT;

for i = 1:x
    
    if mod(i,100) == 0
        
        fprintf('%d dimensions done\n', i)
         
    end
    
   for j = 1:y
       
      if POSMAT(i,j) < 0
          
         POSMAT(i,j) = 0; 
          
      end
       
   end
    
end

end
