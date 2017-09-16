function genssiInstall
    % Inlude GenSSI in MATLAB path
    addpath(pwd);
    addpath(genpath([pwd '/Auxiliary']));
    addpath(genpath([pwd '/SBMLimporter']));
    
    % Generate file encoding user-specific defaults
    copyfile([pwd '/Auxiliary/template_genssiUserSpecificDefaults'],'genssiUserSpecificDefaults.m');
end