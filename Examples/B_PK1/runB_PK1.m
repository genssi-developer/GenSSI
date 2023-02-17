% runHIV runs the structural identifiability analysis for the 
% model of HIV dynamics described by
% 
%    Meshkat et al. (2014). On finding and using identifiable parameter
%    combinations in nonlinear dynamic Systems Biology models and
%    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261.

% Confirm execution
%syms x01 x02 x03 x04

genssiMain('B_PK1',8);