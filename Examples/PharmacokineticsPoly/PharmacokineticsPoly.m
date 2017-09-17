function model = PharmacokineticsPoly()
	% Symbolic variables
	syms x1 x2 x3 x4 xi1
	syms a1 a2 b1 b2 ka kc vm c0 g

	% Parameters
	model.sym.p = [a1;a2;b1;b2;ka;kc;vm;c0;g];

	% State variables
	model.sym.x = [x1;x2;x3;x4;xi1];

	% Control vectors (g)
	model.sym.g = [];

	% Autonomous dynamics (f)
	model.sym.xdot = [- a1*(x1 - x2) - ka*vm*x1*xi1
                      a2*(x1 - x2)
                      - b1*(x3 - x4) - kc*vm*x3*xi1
                      b2*(x3 - x4)
                      ka*xi1^2*(a1*(x1 - x2) + ka*vm*x1*xi1) + kc*xi1^2*(b1*(x3 - x4) + kc*vm*x3*xi1)];

	% Initial conditions
	model.sym.x0 = [c0;0;c0*g;0;1/(c0*ka + ka*kc + c0*g*kc)];

	% Observables
	model.sym.y = [x1;x2;x3];
end