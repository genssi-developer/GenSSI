function model = GoodwinPoly()
	syms x1 x2 x3 xi1
	syms p1 p2 p3 p4 p5 p6 p7 p8
	model.Name = 'GoodwinPoly';
	model.Nder = 4;
	model.X = [x1,x2,x3,xi1];
	model.Neq = 4;
	model.G = [0  0  0  0];
	model.Noc = 0;
	model.Par = [p1,p2,p4,p5,p6,p7,p8];
	model.Npar = 7;
	model.IC = [3/10,9/10,13/10,1/(p2 + (13/10)^p3)];
	model.H = [x1,x2,x3];
	model.Nobs = 3;
	model.F = [p1*xi1 - p4*x1,p5*x1 - p6*x2,p7*x2 - p8*x3,-p3*x3^(p3 - 1)*xi1^2*(p7*x2 - p8*x3)];
end