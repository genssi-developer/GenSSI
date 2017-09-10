function model = DegradationPoly()
	syms x xi1
	syms k1 k2 k3
	model.sym.x = [x,xi1];
	model.sym.g = [];
	model.sym.p = [k1,k2,k3];
	model.sym.x0 = [0,1/k3];
	model.sym.y = [x,xi1];
	model.sym.xdot = [k1 - k2*x*xi1,-xi1^2*(k1 - k2*x*xi1)];
end