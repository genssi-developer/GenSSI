% runNGF_Erk runs the structural identifiability analysis for the 
% transformed 5-state model of NFG-induced Erk signalling described in
% 
%    Hasenauer et al. (2014). ODE constrained mixture modelling:
%    a method for unraveling subpopulation structures and dynamics, 
%    PLoS Computational Biology, 10, e1003686.
%
% The analysis of performed for a subset of the parameters.

syms k_1 k_2 k_9 k_11
genssiMain('NGF_Erk',7,[k_1,k_2,k_9,k_11]);