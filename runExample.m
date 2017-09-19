function runExample(Name)
    GenSSIDir = fileparts(mfilename('fullpath'));
    runFile = fullfile(GenSSIDir,'Examples',Name,['run',Name,'.m']);
    run(runFile);
end