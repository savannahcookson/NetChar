function diceRunWrapper(iteration,nets,comparatorFiles,homedir,groupfile,savedir,includedROIs,netfile,excludedRegions,binarize,realCalc)

    seed = shuffleMaps(nets,homedir,groupfile,savedir,includedROIs,netfile,excludedRegions,binarize,iteration,realCalc); %set to 0 for real run
    
    runDice(nets,comparatorFiles,savedir,netfile,iteration,seed);
    
    %comment out for real run
    command = ['rm ' savedir '*rm_' num2str(iteration) '_*'];
    system(command);
    command = ['mv ~/DiceQCall' num2str(iteration) '* ' savedir 'logs/'];
    system(command);

end
