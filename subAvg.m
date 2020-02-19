function avgMat = subAvg(inMat)

[x, y, z] = size(inMat);
avgMat = zeros(x,y);

for i = 1:x
    
    if mod(i,10) == 0
        fprintf('%d ROIs done\n',i)
    end
    
    for j = 1:y
        
        avgMat(i,j) = mean(inMat(i,j,:));
        
    end
    
end


end