% runTransfection_4State performs the structural identifiability analysis
% for the 4-state model for mRNA transfection introduced by
% 
%    Lechtenberg, L. (2015). Model selection in deterministic models of
%    mRNA transfection. Master Thesis, Ludwig-Maximilians-Universitaet,
%    Munich, Germany.
%
% In contrast to the 2-state transfection model, the 4-state transfection
% model accounts for an enzymatic degration of the mRNA.

% Structural identifiability analysis for all parameters
genssiMain('Transfection_4State',7);

% Structural identifiability analysis for reduced set of unknown parameters
syms d1 d2 d3 b kTL mRNA0 enz0
genssiMain('Transfection_4State',7,[d1,d2,d3,kTL]);