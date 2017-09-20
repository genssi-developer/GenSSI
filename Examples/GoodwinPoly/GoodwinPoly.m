function model = GoodwinPoly()
	% Symbolic variables
	syms x1 x2 x3 xi1
	syms p1 p2 p3 p4 p5 p6 p7 p8

	% Parameters
	model.sym.p = [p1;p2;p3;p4;p5;p6;p7;p8];

	% State variables
	model.sym.x = [x1;x2;x3;xi1];

	% Control vectors (g)
	model.sym.g = [];

	% Autonomous dynamics (f)
	model.sym.xdot = [p1*xi1 - p4*x1
                      p5*x1 - p6*x2
                      p7*x2 - p8*x3
                      -p3*x3^(p3 - 1)*xi1^2*(p7*x2 - p8*x3)];

	% Initial conditions
	model.sym.x0 = [3/10;9/10;13/10;1/(p2 + (13/10)^p3)];

	% Observables
	model.sym.y = [x1;x2;x3];
end