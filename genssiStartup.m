function genssiStartup
    % genssiStartup adds all paths required for GenSSI. Furthermore, it
    % generates the file genssiUserSpecificDefaults.m, providing
    % user-specific defaults.

    % Inlude GenSSI in MATLAB path
    GenSSIDir = fileparts(mfilename('fullpath'));
    addpath(GenSSIDir);
    addpath(fullfile(GenSSIDir,'Auxiliary'));
    addpath(fullfile(GenSSIDir,'SBMLimporter'));
    addpath(fullfile(GenSSIDir,'Examples'));
    addpath(fullfile(GenSSIDir,'Docu'));

    % Generate file encoding user-specific defaults
%     copyfile([pwd '/Auxiliary/template_genssiUserSpecificDefaults'],'genssiUserSpecificDefaults.m');
    copyfile(fullfile(GenSSIDir,'Auxiliary','template_genssiUserSpecificDefaults'),fullfile(GenSSIDir,'GenssiUserSpecificDefaults.m'));
end