function model = DegradationPoly()
	syms x xi1
	syms k1 k2 k3
	model.Name = 'DegradationPoly';
	model.Nder = 4;
	model.X = [x,xi1];
	model.Neq = 2;
	model.G = [0,0];
	model.Noc = 0;
	model.P = [];
	model.Par = [k1,k2,k3];
	model.Npar = 3;
	model.IC = [0,1/k3];
	model.H = [x];
	model.Nobs = 1;
	model.F = [k1 - k2*x*xi1,-xi1^2*(k1 - k2*x*xi1)];
end