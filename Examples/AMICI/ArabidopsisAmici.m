function model = ArabidopsisAmici()
	syms x1 x2 x3 x4 x5 x6 x7
	syms p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27
	model.sym.x = [x1,x2,x3,x4,x5,x6,x7];
	model.sym.y = [x1,x4,0,0,0,0,0];
    model.sym.p = [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20,p21,p22,p23,p24,p25,p26,p27];
	model.sym.x0 = [0,0,0,0,0,0,0];
	model.sym.u = [p26*x7];
	model.sym.xdot = [(p1*x6)/(p3 + x6) - (p5*x1)/(p12 + x1),p19*x1 - p22*x2 + p23*x3 - (p6*x2)/(p13 + x2),p22*x2 - p23*x2 - (p7*x3)/(p14 + x3),(p2*p4^2)/(p4^2 + x3^2) - (p8*x4)/(p15 + x4),p20*x4 - p24*x5 + p25*x6 - (p9*x6)/(p16 + x5),p24*x5 - p25*x6 - (p10*x6)/(p17 + x6),p21 - (p11*x7)/(p18 + x7)];
end