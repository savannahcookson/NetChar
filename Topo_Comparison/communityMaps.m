function [analyzedROIs, nonAssigned] = communityMaps(homedir,savedir,groupSet,groupROIs,setNum,numNets,cutROIs)

% Generates binary community maps and ROI information for a given SVI
% output groups.txt file. 
%
% USAGE:[analyzedROIs, nonAssigned] = communityMaps(homedir,savedir,groupSet,groupROIs,setNum,numNets)
%       analyzedROIs: list of ROI labels (integer) that are included in the communities
%       nonAssigned: list of ROI labels (integer) not included in any communities
%       homedir: Experiment folder
%       savedir: subdirectory in which community files will be saved
%       groupSet: output group.txt file loaded into matlab
%       groupROIs: list of ROIs included in SVI call
%       setNum: numerical label for dataset
%       numNets: number of communities to be assigned
%       cutROIs: list of any ROIs to mask out of the community

%load([homedir '1803/n977-k7-mmsb-linksampling/groups.txt']);
[ROIlist,indexOrder] = sort(groupSet(:,2));
groupsSorted = groupSet(indexOrder,:);

%load([homedir '1803/n977-k7-mmsb-linksampling/set2Included.mat']);
analyzedROIs = groupROIs(ROIlist);
nonAssigned = setdiff(groupROIs,analyzedROIs);

for c = 1:numNets
    
    r = 1;
    testval = 0;
    
    netfile = [homedir savedir 'S' num2str(setNum) '_subt_comm' num2str(c)];
    
    if groupsSorted(r,c+2) > 0 && ~ismember(analyzedROIs(r),cutROIs)
        testval = 1;
    end
    
    command = ['3dcalc -prefix ' netfile ' -a ' homedir 'ROIs_2mm.nii.gz -expr ''' num2str(testval) '*equals(a,' num2str(analyzedROIs(r)) ')'''];
    system(command);
    
    for r=2:length(analyzedROIs)
        
        if groupsSorted(r,c+2) > 0 && ~ismember(analyzedROIs(r),cutROIs)
            
            command = ['3dcopy ' netfile '+tlrc ' homedir savedir 'temp1'];
            system(command);
            command = ['rm ' netfile '*'];
            system(command);
            
            command = ['3dcalc -prefix ' homedir savedir 'temp2 -a ' homedir 'ROIs_2mm.nii.gz -expr ''equals(a,' num2str(analyzedROIs(r)) ')'''];
            system(command);
            command = ['3dcalc -prefix ' netfile ' -a ' homedir savedir 'temp1+tlrc -b ' homedir savedir 'temp2+tlrc -expr ''a+b'''];
            system(command);
            command = ['rm ' homedir savedir 'temp*'];
            system(command);
            
        end
        
    end
    
end