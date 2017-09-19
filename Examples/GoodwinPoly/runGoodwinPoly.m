% runGoodwinPoly runs the structural identifiability analysis for the 
% model of the Goodwin oscillator as introduced by
% 
%    Goodwin, B.C. (1965). Oscillatory behavior in enzymatic control
%              processes, Adv. Enzyme Regul. (3), 425-428. 
%
% To simplify the symbolic calculations, the model is converted to
% polynomial form, meaning that the vector field of the autonomous 
% dynamics (f) and the control vector (g) are polynomial. To achieve this,
% the dimensionality of the model is increased.

% Copy Goodwin.m to this folder
copyfile(fullfile('..','Goodwin','Goodwin.m'),'Goodwin.m');

% Transform model to polynomial
genssiToPolynomial('Goodwin','GoodwinPoly');

% Confirm execution
genssiAskForConfirmation(2);

% Structural identifiability analysis (for all parameters)
genssiMain('GoodwinPoly',5);