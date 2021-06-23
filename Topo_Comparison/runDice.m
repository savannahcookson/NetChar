function runDice(nets,comparatorFiles,savedir,netfile,iteration,seed)

saveFile = [savedir 'CCs/' num2str(iteration) '.1D'];
mask = [savedir 'MaskAll.nii'];

command = ['touch ' saveFile];
system(command);
command = ['echo ' num2str(seed) ' >> ' saveFile];
system(command);

for c = 1:length(comparatorFiles)
    
    command = ['echo comm' num2str(c) ' >> ' saveFile];
    system(command);
    
    for n = 1:nets
        
        netfilepath = [savedir netfile num2str(n)]; %remove savedir for real run
        command = ['3ddot -mask ' mask ' -dodice ' comparatorFiles{c} ' ' netfilepath '+.tlrc >> ' saveFile]; %change .tlrc to .nii for real
        system(command);
        
    end
    
end

end
