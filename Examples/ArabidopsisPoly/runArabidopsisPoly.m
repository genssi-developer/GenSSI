% runArabidopsisPoly runs the structural identifiability analysis for the 
% model of the circadian clock in Arabidopsis Thaliana as introduced by
% 
%    Locke et al. (2005). Modeling genetic networks with noisy and 
%    varied experimental data: the circadian clock in Arabidopsis 
%    thaliana. Journal of Theoretical Biology 234: 383-393.
%
% To simplify the symbolic calculations, the model is converted to
% polynomial form, meaning that the vector field of the autonomous 
% dynamics (f) and the control vector (g) are polynomial. To achieve this,
% the dimensionality of the model is increased.

% Copy Arabidopsis.m to this folder
copyfile(fullfile('..','Arabidopsis','Arabidopsis.m'),'Arabidopsis.m');

% Transform model to polynomial
genssiToPolynomial('Arabidopsis','ArabidopsisPoly');

% Symbolic parameters for identifiability analysis
syms p1 p2 p5 p8 p10 p11 p12 p15 p18 p19 p26 p27

% Structural identifiability analysis (for a subset of the parameters)
genssiMain('ArabidopsisPoly',7,[p1;p2;p5;p8;p10;p11;p12;p15;p18;p26;p27]);