% runPharmacokinetics runs the structural identifiability analysis for the 
% model of the pharmacokinetics of glucose-oxidase introduced by
% 
%    Demignot, S. and Domurado, D. (1987). Effect of prosthetic 
%    sugar groups on the pharmacokinetics of glucose-oxidase, 
%    Drug. Des. Deliv., 1, 333-348.
%
% To simplify the symbolic calculations, the model is converted to
% polynomial form, meaning that the vector field of the autonomous 
% dynamics (f) and the control vector (g) are polynomial. To achieve this,
% the dimensionality of the model is increased.

% Copy Pharmacokinetics.m to this folder
copyfile(fullfile('..','Pharmacokinetics','Pharmacokinetics.m'),'Pharmacokinetics.m');

% Transform model to polynomial
genssiToPolynomial('Pharmacokinetics','PharmacokineticsPoly');

% Confirm execution
genssiAskForConfirmation(13);

% Structural identifiability analysis (for all parameters)
genssiMain('PharmacokineticsPoly',3);
