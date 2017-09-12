% runThyroid2 runs the structural identifiability analysis for the model 
% of mRNA transfection described by
% 
%    Leonhardt et al. (2013). Single-cell mRNA transfection studies:
%    delivery, kinetics and statistics by numbers, Nanomedicine: 
%    Nanotechnology, Biology and Medicine, 10(4), 679-688.
%
% under two distinct experimental conditions:
% - Condition 1: mRNA transfection
%      state variables:   mExp1 (mRNA level),  GExp1 (protein level)
%      intial conditions: mExp1(t_0) = m0Exp1, GExp1(t_0) = 0,
% - Condition 2: inhibition of protein synthesis after transfection
%      state variables:   mExp2 (mRNA level),  GExp2 (protein level)
%      intial conditions: mExp2(t_0) = m0Exp2, GExp2(t_0) = G0Exp2,
%
% This implementation allows for the analysis of strutural
% identifiability assuming that experimental data for two different
% conditions are available.

genssiMain('Transfection3',4);