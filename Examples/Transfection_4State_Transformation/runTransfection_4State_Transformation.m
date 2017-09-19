% runTransfection_4State_Transformation performs the structural 
% identifiability analysis for the 4-state model for mRNA transfection
% introduced by
% 
%    Lechtenberg, L. (2015). Model selection in deterministic models of
%    mRNA transfection. Master Thesis, Ludwig-Maximilians-Universitaet,
%    Munich, Germany.
%
% In contrast to the 2-state transfection model, the 4-state transfection
% model accounts for an enzymatic degration of the mRNA.
%
% Here the model is transformed using informatin provided in
% TransformationRules_4State.m. The state transformation reduces the number
% of state variable by exploiting the conservation relations. The parameter
% substitution reduced the number of parameters by on, improving the
% identifiability.

% Copy Transfection_4State.m to this folder
copyfile(fullfile('..','Transfection_4State','Transfection_4State.m'),'Transfection_4State.m');

% Transformation of the model
genssiTransformation('Transfection_4State',...          % Initial model
                     'TransformationRules_4State',...   % Definition of transformation
                     'Transfection_4State_Transformation'); % Name of transformed model

% Confirm execution
genssiAskForConfirmation(3);

% Structural identifiability analysis for transformed model
genssiMain('Transfection_4State_Transformation',7);


