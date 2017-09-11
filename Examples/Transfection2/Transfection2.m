function model = Transfection2()
    % Transfection2 provides the GenSSI implementation of the model for 
    % mRNA transfection described by
    % 
    %    Leonhardt et al. (2013). Single-cell mRNA transfection studies:
    %    delivery, kinetics and statistics by numbers, Nanomedicine: 
    %    Nanotechnology, Biology and Medicine, 10(4), 679-688.
    %
    % The translation rate and the initial mRNA concentration are combined,
    % to ensure structural identifability.

    % Symbolic variables
    syms x1 x2
	syms d kTLm0 b
	
    % Parameters
    model.sym.p = [d,kTLm0,b];
	
    % State variables
    model.sym.x = [x1,x2];
	
    % Control vectors (g)
    model.sym.g = [];
	
    % Autonomous dynamics (f)
    model.sym.xdot = [-d*x1,...
                      kTLm0*x1-b*x2];
    
    % Initial conditions
    model.sym.x0 = [1,0];
	
    % Observables
    model.sym.y = [x2];
end