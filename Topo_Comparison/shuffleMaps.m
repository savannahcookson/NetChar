function seed = shuffleMaps(nets,homedir,groupfile,savedir,includedROIs,netfile,excludedRegions,binarize,iteration,realCalc)

%seed = str2num(num2str(round(rem(now,1)*10000000))+iteration;
rng('shuffle');
seedStruct = rng;
seed = seedStruct.Seed;

seed = [num2str(seed) num2str(iteration)];
seed = str2num(seed(length(num2str(iteration))+2:end));
rng(seed);

groups = load([groupfile]);
if isstruct(groups)
    groupfields = fieldnames(groups);
    groups = groups.(groupfields{1});
end

[ROIlist,~] = sort(groups(:,2));
[~,ei1] = intersect(includedROIs,excludedRegions);
[~,ei2] = intersect(ROIlist,ei1);
analyzedROIs = includedROIs(ROIlist);
analyzedROIs(ei2) = [];
groups(ei2,:) = [];

[~,indexOrder] = sort(groups(:,2));
if ~realCalc
    indexOrder = indexOrder(randperm(length(indexOrder)));
end
groupsSorted = groups(indexOrder,:);

groupsSorted(:,2) = analyzedROIs;

for c = 1:nets
    
    netfilepath = [savedir netfile num2str(c)];
    
    rounded = 0;
    count = 1;
    
    command = ['3dcalc -prefix ' netfilepath ' -a ' homedir 'ROIs_2mm.nii.gz -expr '''];
    
    for r=1:length(analyzedROIs)
        
        if count == 101
            
            command = [command ''''];
            system(command);
            
            temppath = [savedir netfile 'temp' num2str(rounded+1)];
            command = ['3dcopy ' netfilepath '+tlrc ' temppath];
            system(command);
            command = ['rm ' netfilepath '*'];
            system(command);

            rounded = rounded + 1;
            count = 1;
 
            command = ['3dcalc -prefix ' netfilepath ' -a ' homedir 'ROIs_2mm.nii.gz -expr '''];
            
        end
        
        if groupsSorted(r,c+2) > 0
            
            if count ~= 1
                command = [command '+'];
            end

            if binarize
                command = [command 'equals(a,' num2str(analyzedROIs(r)) ')'];
            else
                command = [command num2str(groupsSorted(r,c+2)) '*equals(a,' num2str(analyzedROIs(r)) ')'];
            end
            
            count = count+1;
            
        end
        
    end
    
    if count > 1
        command = [command ''''];
        system(command);
    
        temppath = [savedir netfile 'temp' num2str(rounded+1)];

        command = ['3dcopy ' netfilepath '+tlrc ' temppath];
        system(command);
        command = ['rm ' netfilepath '*'];
        system(command);
        
        rounded = rounded+1;
    end
    
    command = ['3dcalc -prefix ' netfilepath ' '];
    expr = [' -expr '''];
    
    for r = 1:rounded
        
        roundchar = char(96+r);
        tempfile = [savedir netfile 'temp' num2str(r)];
        command = [command '-' roundchar ' ' tempfile '+tlrc '];
        expr = [expr roundchar];
        if r<rounded
            expr = [expr '+'];
        end
    end
    
    command = [command expr ''''];
    system(command);
    
    command = ['rm ' savedir netfile 'temp*'];
    system(command);
    
end

end
