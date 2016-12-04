function model = Bilirubin2()
	syms x1 x2 x3 x4
	syms k01 k12 k13 k14 k21 k31 k41 
	model.Name = 'Bilirubin2';
	model.Nder = 10;
	model.X = [x1 x2 x3 x4];
	model.Neq = 4;
	model.G = [1 0 0 0];
	model.Noc = 1;
	model.P = [k01 k12 k13 k14 k21 k31 k41];
    model.Par = [k01 k12 k13 k14 k21 k31 k41];
	model.Npar = 7;
	model.IC = [1 1 1 1];
	model.H = [x1];
	model.Nobs = 1;
	model.F = [-(k21+k31+k41+k01)*x1+k12*x2+k13*x3+k14*x4,...
               k21*x1-k12*x2,...
               k31*x1-k13*x3,...
               k41*x1-k14*x4];
end