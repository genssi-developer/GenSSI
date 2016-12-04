function model = Transfection3()
	syms mExp1 GExp1 mExp2 GExp2
	syms d b kTL m0Exp1 m0Exp2 G0Exp2
	model.Name = 'Transfection3';
	model.Nder = 4;
	model.X = [mExp1,GExp1,mExp2,GExp2];
	model.Neq = 4;
	model.G = [0  0  0  1];
	model.Noc = 1;
	model.Par = [d,b,kTL,m0Exp1,m0Exp2,G0Exp2];
	model.Npar = 6;
	model.IC = [m0Exp1,0,m0Exp2,G0Exp2];
	model.H = [GExp1,GExp2];
	model.Nobs = 2;
	model.F = [-d*mExp1,kTL*mExp1 - GExp1*b,-d*mExp2,-GExp2*b];
end