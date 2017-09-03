% genssiStartup adds all paths required for GenSSI.
% It should be called at the beginning of a session.
%
% Parameters:
%
% Return values:
%  
GenSSIDir = fileparts(mfilename('fullpath'));
addpath(GenSSIDir);
addpath(fullfile(GenSSIDir,'Auxiliary'));
addpath(fullfile(GenSSIDir,'SBMLimporter'));
addpath(fullfile(GenSSIDir,'Examples'));
addpath(fullfile(GenSSIDir,'Docu'));
