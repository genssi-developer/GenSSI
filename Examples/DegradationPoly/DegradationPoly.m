function model = DegradationPoly()
	syms x xi1
	syms k_syn k_deg_max K_deg
	model.sym.x = [x,xi1];
	model.sym.g = [];
	model.sym.p = [k_syn,k_deg_max,K_deg];
	model.sym.x0 = [0,1/K_deg];
	model.sym.y = [x,xi1];
	model.sym.xdot = [k_syn - k_deg_max*x*xi1,-xi1^2*(k_syn - k_deg_max*x*xi1)];
end