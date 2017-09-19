% runGoodwin runs the structural identifiability analysis for the 
% model of the Goodwin oscillator as introduced by
% 
%    Goodwin, B.C. (1965). Oscillatory behavior in enzymatic control
%              processes, Adv. Enzyme Regul. (3), 425-428. 

% Confirm execution
genssiAskForConfirmation(2);

% Structural identifiability analysis (for a subset of the parameters)
genssiMain('Goodwin',5);
