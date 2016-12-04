function model = Thyroid2()
	syms x1 x2 x3
	syms k02 k03 k12 k13 k21 k31 V1
	model.Name = 'Thyroid2';
	model.Nder = 7;
	model.X = [x1 x2 x3];
	model.Neq = 3;
	model.G = [1 0 0];
	model.Noc = 1;
	model.P = [k02,k03,k12,k13,k21,k31,V1];
    model.Par = [k02,k03,k12,k13,k21,k31,V1];
	model.Npar = 7;
	model.IC = [0 0 0];
	model.H = [x1/V1];
	model.Nobs = 1;
	model.F = [k13*x3+k12*x2-(k21+k31)*x1,...
               k21*x1-(k12+k02)*x2,...
               k31*x1-(k13+k03)*x3];
end