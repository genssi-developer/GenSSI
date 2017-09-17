function model = DegradationPoly()
	% Symbolic variables
	syms x xi1
	syms k_syn k_deg_max K_deg

	% Parameters
	model.sym.p = [k_syn;k_deg_max;K_deg];

	% State variables
	model.sym.x = [x;xi1];

	% Control vectors (g)
	model.sym.g = [];

	% Autonomous dynamics (f)
	model.sym.xdot = [k_syn - k_deg_max*x*xi1
                      -xi1^2*(k_syn - k_deg_max*x*xi1)];

	% Initial conditions
	model.sym.x0 = [0;1/K_deg];

	% Observables
	model.sym.y = [x];
end