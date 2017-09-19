% runArabidopsis runs the structural identifiability analysis for the model
% of the circadian clock in Arabidopsis Thaliana as introduced by
% 
%    Locke et al. (2005). Modeling genetic networks with noisy and 
%    varied experimental data: the circadian clock in Arabidopsis 
%    thaliana. Journal of Theoretical Biology 234: 383-393.

% Confirm execution
genssiAskForConfirmation(5);

% Symbolic parameters for identifiability analysis
syms p1 p2 p5 p8 p10 p11 p12 p15 p18 p19 p26 p27

% Structural identifiability analysis (for a subset of the parameters)
genssiMain('Arabidopsis',7,[p1;p2;p5;p8;p10;p11;p12;p15;p18;p26;p27]);