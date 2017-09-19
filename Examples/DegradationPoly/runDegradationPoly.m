% runDegradation runs the structural identifiability analysis for a 
% simple model for protein synthesis and enzymatic degradation.
% To simplify the symbolic calculations, the model is converted to
% polynomial form, meaning that the vector field of the autonomous 
% dynamics (f) and the control vector (g) are polynomial. To achieve this,
% the dimensionality of the model is increased.

% Copy Degradation.m to this folder
copyfile(fullfile('..','Degradation','Degradation.m'),'Degradation.m');

% Transform model to polynomial
genssiToPolynomial('Degradation','DegradationPoly');

% Confirm execution
genssiAskForConfirmation(1);

% Structural identifiability analysis (for all parameters)
genssiMain('DegradationPoly',4);