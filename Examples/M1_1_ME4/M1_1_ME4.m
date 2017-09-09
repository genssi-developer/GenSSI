function model = M1_1_ME4()
	syms mExp1 GExp1 mExp2 GExp2 mExp3 GExp3 mExp4 GExp4
	syms d b kTL m0Exp1
	model.sym.x = [mExp1,GExp1,mExp2,GExp2,mExp3,GExp3,mExp4,GExp4];
	model.sym.g = [];
	model.sym.p = [d,b,kTL,m0Exp1];
	model.sym.x0 = [m0Exp1,0,m0Exp1/2,0,m0Exp1,0,m0Exp1,0];
	model.sym.y = [GExp1,GExp2,GExp3,GExp4];
	model.sym.xdot = [-d*mExp1,kTL*mExp1 - GExp1*b,-d*mExp2,kTL*mExp2 - GExp2*b,-d*mExp3,(kTL*mExp3)/2 - GExp3*b,-d*mExp4,kTL*mExp4 - (3*GExp4*b)/4];
end