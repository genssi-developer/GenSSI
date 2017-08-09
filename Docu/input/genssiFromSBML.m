function genssiFromSBML (modelNameIn,modelNameOut)
    % GenSsiFromSBML converts an SBML model in the examples/SBML directory
    % to a GenSSI model and puts the results into the examples directory.
    %
    % Parameters:
    %  modelNameIn: name of the SBML model (string)
    %  modelNameOut: name of the GenSSI model (string)
    %  
    % Return values:
    %  void
    %
    GenSSIDir=fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples','SBML'));
    addpath(fullfile(GenSSIDir,'SBMLimporter'));
    fileNameIn = fullfile(GenSSIDir,'Examples','SBML',modelNameIn);
    ODE = SBMLode(fileNameIn);
    AMICIDir = fullfile(GenSSIDir,'Examples','AMICI');
    cd(AMICIDir);
    ODE.writeAMICI(modelNameIn);
    cd(GenSSIDir);
    modelNameAMICI = [modelNameIn '_syms'];
    genssiFromAmici (modelNameAMICI,modelNameOut)
%     delete([modelNameAMICI,'.m']);
end