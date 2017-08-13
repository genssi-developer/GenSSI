function model = M2_2_test()
	syms mnew Gnew E1new
	syms d1 d2tm0 d3 b kTLtm0 E0dm0
	model.Name = 'M2_2_test';
	model.Nder = 8;
	model.X = [mnew,Gnew,E1new];
	model.Neq = 3;
	model.G = [0,0,0,0];
	model.Noc = 0;
	model.P = [d1,d2tm0,d3,b,kTLtm0,E0dm0];
	model.Par = [d1,d2tm0,d3,b,kTLtm0,E0dm0];
	model.Npar = 6;
	model.IC = [1,0,E0dm0];
	model.H = [Gnew];
	model.Nobs = 1;
	model.F = [- d1*mnew - E1new*d2tm0*mnew,kTLtm0*mnew - Gnew*b,(E0*d3)/m0 - E1new*d2tm0*mnew - E1new*d3];
end