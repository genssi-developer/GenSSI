function model = Bilirubin1()
	syms x1 x2 x3 x4
	syms k03 k04 k13 k24 k31 k42 k43
	model.Name = 'Bilirubin1';
	model.Nder = 10;
	model.X = [x1 x2 x3 x4];
	model.Neq = 4;
	model.G = [1 0 0 0];
	model.Noc = 1;
	model.P = [k03 k04 k13 k24 k31 k42 k43];
    model.Par = [k03 k04 k13 k24 k31 k42 k43];
	model.Npar = 8;
	model.IC = [0 0 0 0];
	model.H = [x1 x2];
	model.Nobs = 2;
	model.F = [-k31*x1+k13*x3,...
               -k42*x2+k24*x4,...
               k31*x1-(k03+k13+k43)*x3,...
               k42*x2+k43*x3-(k04+k24)*x4];
end