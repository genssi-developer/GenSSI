function model = Degradation()
    % Degradation provides the GenSSI implementation of a simple model
    % for protein synthesis and enzymatic degradation.
    
    % Symbolic variables
    syms k1 k2 k3
	syms x
	
    % Parameters
	model.sym.p = [k_syn,k_deg_max,K];

    % State variables
    model.sym.x = [x];

    % Control vectors (g)
	model.sym.u = [];

    % Autonomous dynamics (f)
	model.sym.xdot = [k_syn-k_deg_max*x/(K+x)];
    
    % Initial conditions
	model.sym.x0 = [0];

    % Observables
	model.sym.y = [x];
end