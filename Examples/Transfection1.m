function model = Transfection1()
	syms x1 x2
	syms d kTL b m0
	model.Name = 'Transfection1';
	model.Nder = 7;
	model.X = [x1 x2];
	model.Neq = 2;
	model.G = [0 0];
	model.Noc = 0;
	model.P = [d,kTL,b,m0];
    model.Par = [d,kTL,b,m0];
	model.Npar = 4;
	model.IC = [m0 0];
	model.H = [x2];
	model.Nobs = 1;
	model.F = [-d*x1,...
               kTL*x1-b*x2];
end