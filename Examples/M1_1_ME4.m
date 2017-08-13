function model = M1_1_ME4()
	syms mExp1 GExp1 mExp2 GExp2 mExp3 GExp3 mExp4 GExp4
	syms d b kTL m0Exp1
	model.Name = 'M1_1_ME4';
	model.Nder = 4;
	model.X = [mExp1,GExp1,mExp2,GExp2,mExp3,GExp3,mExp4,GExp4];
	model.Neq = 8;
	model.G = [0,0,0,0,0,0,0,0];
	model.Noc = 0;
	model.P = [d,b,kTL,m0Exp1];
	model.Par = [d,b,kTL,m0Exp1];
	model.Npar = 4;
	model.IC = [m0Exp1,0,m0Exp1/2,0,m0Exp1,0,m0Exp1,0];
	model.H = [GExp1,GExp2,GExp3,GExp4];
	model.Nobs = 4;
	model.F = [-d*mExp1,kTL*mExp1 - GExp1*b,-d*mExp2,kTL*mExp2 - GExp2*b,-d*mExp3,(kTL*mExp3)/2 - GExp3*b,-d*mExp4,kTL*mExp4 - (3*GExp4*b)/4];
end