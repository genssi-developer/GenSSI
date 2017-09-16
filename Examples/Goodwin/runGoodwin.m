% runGoodwin runs the structural identifiability analysis for the 
% model of the Goodwin oscillator as introduced by
% 
%    Goodwin, B.C. (1965). Oscillatory behavior in enzymatic control
%              processes, Adv. Enzyme Regul. (3), 425-428. 

syms p1 p2 p4 p5 p6 p7 p8;
genssiMain('Goodwin',3,[p1 p2 p4 p5 p6 p7 p8]);
