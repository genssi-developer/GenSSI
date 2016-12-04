function model = Cholesterol1()
	syms x1 x2
	syms k01 k02 k12 k21 V1
	model.Name = 'Cholesterol1';
	model.Nder = 5;
	model.X = [x1 x2];
	model.Neq = 2;
	model.G = [1 0];
	model.Noc = 1;
	model.P = [k01,k02,k12,k21,V1];
    model.Par = [k01,k02,k12,k21,V1];
	model.Npar = 5;
	model.IC = [0 0];
	model.H = [x1/V1];
	model.Nobs = 1;
	model.F = [k12*x2-(k01+k21)*x1,...
               k21*x1-(k02+k12)*x2];
end