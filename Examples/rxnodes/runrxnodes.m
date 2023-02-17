% Confirm execution
%genssiAskForConfirmation(5);

% Symbolic parameters for identifiability analysis
%syms p1 p2 p5 p8 p10 p11 p12 p15 p18 p19 p26 p27

% Structural identifiability analysis (for a subset of the parameters)
% genssiMain('rxnodes');
genssiMain('rxnodes',5);
%genssiMain('rxnodes',7,[p1;p2;p5;p8;p10;p11;p12;p15;p18;p26;p27]);