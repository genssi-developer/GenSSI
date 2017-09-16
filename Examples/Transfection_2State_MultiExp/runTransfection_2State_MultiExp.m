% runTransfection_2State performs the structural identifiability analysis
% for the model for mRNA transfection introduced by
% 
%    Leonhardt et al. (2013). Single-cell mRNA transfection 
%    studies: delivery, kinetics and statistics by numbers, 
%    Nanomedicine: Nanotechnology, Biology and Medicine. 10(4):679-88.
%
% The structural identifiability is performed assuming that data for four 
% different experimental conditions are available. These conditions are
% defined in ExperimentalConditions_2State.m.

% Copy Transfection_2State.m to this folder
copyfile(fullfile('..','Transfection_2State','Transfection_2State.m'),'Transfection_2State.m');

% Transformation of the model
genssiMultiExperiment('Transfection_2State',...           % Initial model (single experiment)
                      'ExperimentalConditions_2State',... % Definition of experimental conditions
                      'Transfection_2State_MultiExp');    % Name of transformed model

% Structural identifiability analysis for transformed model
genssiMain('Transfection_2State_MultiExp',5);