function model = M2_2()
	syms mnew Gnew E1new
	syms d1 d2tm0 d3 b kTLtm0 E0dm0
	model.sym.x = [mnew,Gnew,E1new];
	model.sym.u = [];
	model.sym.p = [d1,d2tm0,d3,b,kTLtm0,E0dm0];
	model.sym.x0 = [1,0,E0dm0];
	model.sym.y = [Gnew];
	model.sym.xdot = [- d1*mnew - E1new*d2tm0*mnew,kTLtm0*mnew - Gnew*b,(E0*d3)/m0 - E1new*d2tm0*mnew - E1new*d3];
end