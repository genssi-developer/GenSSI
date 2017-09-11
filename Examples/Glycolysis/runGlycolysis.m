% runGlycolysis runs the structural identifiability analysis for the 
% model of the glycolysis metabolic pathway introduced by
%
%    Bartl et al. (2010). Just-in-time activation of a glycolysis
%              inspired metabolic network - solution with a dynamic 
%              optimization approach. Proc. 55nd International 
%              Scientific Colloquium. Ilmenau, Germany.

% Definition of parameters
syms k1 k2 k3 k4 kM;

% Structural identifiability analysis for the selected parameters
genssiMain('Glycolysis',2,[k1,k2,k3,k4,kM]);