function model = Degradation()
	syms x
	syms k1 k2 k3
	model.Name = 'Degradation';
	model.Nder = 10;
	model.X = [x];
	model.Neq = 1;
	model.G = [];
	model.Noc = 0;
	model.Par = [k1 k2 k3];
	model.Npar = 3;
	model.IC = [0];
	model.H = [x];
	model.Nobs = 1;
	model.F = [k1-k2*x/(k3+x)];
end