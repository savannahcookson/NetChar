function diceScript(iteration)

%save('/home/despo/scookson/Desktop/1801/hcp/1803/perm/test.mat','iteration');
%iteration = iteration{1};

homedir = '/home/despo/scookson/Desktop/1803/';
groupfile = 'ExploratoryMM/n975-k7-mmsb-linksampling/groups.txt';
comparatorFiles = {
    ['/home/despo/scookson/Desktop/1803/kMeans/groupk_comm1.nii'];
    [homedir 'JointComms/joint_subt_comm2.nii'];
    [homedir 'JointComms/joint_subt_comm3.nii'];
    [homedir 'JointComms/joint_subt_comm4.nii'];
    [homedir 'JointComms/joint_subt_comm5.nii'];
    [homedir 'JointComms/joint_subt_comm6.nii'];
    [homedir 'JointComms/joint_subt_comm7.nii']
    };
% kMeans Comparison
% comparatorFiles = {
%     [homedir 'kMeans/groupk_comm1.nii'];
%     [homedir 'kMeans/groupk_comm2.nii'];
%     [homedir 'kMeans/groupk_comm3.nii'];
%     [homedir 'kMeans/groupk_comm4.nii'];
%     [homedir 'kMeans/groupk_comm5.nii'];
%     [homedir 'kMeans/groupk_comm6.nii'];
%     [homedir 'kMeans/groupk_comm7.nii']
%     };
savedir = [homedir 'JointComparison/Exploratory/'];
%maskdir = [homedir '1803/pearsons/'];
nets = 7;
netFile = '~/Desktop/1803/ExploratoryMM/S1k_comm'; %for real run %['rm_' num2str(iteration) '_shuffled'];% 
load('/home/despo/scookson/Desktop/1803/kMeans/excluded.mat');
excluded = allExcludedorMissing;
binarize = 1;
realCalc = false; %change to true for real run
load('/home/despo/scookson/Desktop/1803/kMeans/included.mat');
set2Included = allIncluded;


diceRunWrapper(iteration,nets,comparatorFiles,homedir,groupfile,savedir,set2Included,netFile,excluded,binarize,realCalc);

command=['echo ' num2str(iteration) ' >> ' savedir 'log.txt'];
system(command);

end
