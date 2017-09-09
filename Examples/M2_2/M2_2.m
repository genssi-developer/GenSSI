function model = M2_2()
	syms mnew Gnew E1new
	syms d1 d2tm0 d3 b kTLtm0 E0dm0
	model.sym.x = [mnew,Gnew,E1new];
	model.sym.g = [];
	model.sym.p = [d1,d2tm0,d3,b,kTLtm0,E0dm0];
	model.sym.x0 = [1,0,E0dm0];
	model.sym.y = [Gnew];
	model.sym.xdot = [- d1*mnew - E1new*d2tm0*mnew,...
        kTLtm0*mnew - Gnew*b,...
        E0dm0*d3 - E1new*d2tm0*mnew - E1new*d3];
end