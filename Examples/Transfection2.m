function model = Transfection2()
	syms x1 x2
	syms d kTLm0 b
	model.Name = 'Transfection2';
	model.Nder = 7;
	model.X = [x1 x2];
	model.Neq = 2;
	model.G = [0 0];
	model.Noc = 0;
	model.P = [d,kTLm0,b];
    model.Par = [d,kTLm0,b];
	model.Npar = 3;
	model.IC = [1 0];
	model.H = [x2];
	model.Nobs = 1;
	model.F = [-d*x1,...
               kTLm0*x1-b*x2];
end