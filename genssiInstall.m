function genssiInstall
    % Inlude GenSSI in MATLAB path
    addpath(genpath(pwd));
    
    % Generate file encoding user-specific defaults
    copyfile([pwd '/Auxiliary/template_genssiUserSpecificDefaults'],'genssiUserSpecificDefaults.m');
end