
% runHIV runs the structural identifiability analysis for the 
% model of HIV dynamics described by
% 
%    Meshkat et al. (2014). On finding and using identifiable parameter
%    combinations in nonlinear dynamic Systems Biology models and
%    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261.

% Confirm execution
%genssiAskForConfirmation(1);

syms xx0 y0 v0 ww0 z0


genssiMain('B_HIV3',15,[xx0;y0;v0;ww0;z0]);