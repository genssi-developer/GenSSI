% runThyroid1 runs the structural identifiability analysis for the 
% 1st version of the Thyroid model described by
% 
%    Meshkat et al. (2014). On finding and using identifiable parameter
%    combinations in nonlinear dynamic Systems Biology models and
%    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261.

% Definition of symbolic variables
syms k02 k03 k12 k13 k21 k31 V1

% Structural identifiability analysis
genssiMain('Thyroid1',7,[k02,k03,k12,k13,k21,k31,V1]);