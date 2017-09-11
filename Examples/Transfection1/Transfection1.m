function model = Transfection1()
    % Transfection1 provides the GenSSI implementation of the model for 
    % mRNA transfection described by
    % 
    %    Leonhardt et al. (2013). Single-cell mRNA transfection studies:
    %    delivery, kinetics and statistics by numbers, Nanomedicine: 
    %    Nanotechnology, Biology and Medicine, 10(4), 679-688.
    %
    % All parameters are considered individually, resulting in a
    % non-identifiability of the translation rate and the initial mRNA
    % concentration.

    % Symbolic variables
    syms x1 x2
	syms d kTL b m0
    
    % Parameters
	model.sym.p = [d,kTL,b,m0];
    
    % State variables
	model.sym.x = [x1 x2];
    
    % Control vectors (g)
	model.sym.g = [];
    
    % Autonomous dynamics (f)
	model.sym.xdot = [-d*x1,...
                      kTL*x1-b*x2];

    % Initial conditions
	model.sym.x0 = [m0 0];
    
    % Observables
	model.sym.y = [x2];
end