function model = HIV()
	syms x1 x2 x3 x4
	syms b c d q1 q2 k1 k2 w1 w2
	model.Name = 'HIV';
	model.Nder = 4;
	model.X = [x1 x2 x3 x4];
	model.Neq = 4;
	model.G = [1 0 0 0];
	model.Noc = 1;
	model.P = [b,c,d,q1,q2,k1,k2,w1,w2];
    model.Par = [b,c,d,q1,q2,k1,k2,w1,w2];
	model.Npar = 9;
	model.IC = [0 0 0 0];
	model.H = [x1 x4];
	model.Nobs = 2;
	model.F = [-b*x1*x4-d*x1,...
               b*q1*x1*x4-k1*x2-w1*x2,...
               b*q2*x1*x4+k1*x2-w2*x3,...
               -c*x4+k2*x3];
end