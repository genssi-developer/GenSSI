function genssiFromSBML (modelNameIn,modelNameOut)
    % genssiFromSBML converts an SBML model in the examples/SBML directory
    % to a GenSSI model and puts the results into the examples directory.
    %
    % Parameters:
    %  modelNameIn: name of the SBML model (string)
    %  modelNameOut: name of the GenSSI model (string)
    %  
    % Return values:
    %  void
    %
    if ~exist('modelNameOut','var')
        modelNameOut = modelNameIn;
    end
    GenSSIDir=fileparts(mfilename('fullpath'));
%     addpath(fullfile(GenSSIDir,'SBMLimporter'));
    fileNameIn = fullfile(GenSSIDir,'Examples',modelNameIn);
    ODE = SBMLode(fileNameIn);
%     AMICIDir = fullfile(GenSSIDir,'Examples');
%     cd(AMICIDir);
%     ODE.writeAMICI(modelNameIn);
    fileNameOut = fullfile(GenSSIDir,'Examples',modelNameOut);
%     ODE.writeAMICI(modelNameIn);
    ODE.writeAMICI(fileNameOut);
%     cd(GenSSIDir);
%     modelNameAMICI = [modelNameIn '_syms'];
%     genssiFromAmici (modelNameAMICI,modelNameOut)
%     delete([modelNameAMICI,'.m']);
end