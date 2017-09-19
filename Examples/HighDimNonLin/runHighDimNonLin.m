% runHighDimNonLin runs the structural identifiability analysis for the 
% model in 
% 
%    Saccomani et al. (2005). Examples of testing global 
%    identifiability of biological and biomedical models with the
%    DAISY software, Computers in Biology and Medicine, 40, 402-407.
%
% which is denoted as "high-dimensional nonlinear model".

% Confirm execution
genssiAskForConfirmation(4);

genssiMain('HighDimNonLin',2);