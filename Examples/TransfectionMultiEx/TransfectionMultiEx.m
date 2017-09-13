function model = TransfectionMultiEx()
	syms mRNAExp1 GFPExp1 mRNAExp2 GFPExp2 mRNAExp3 GFPExp3 mRNAExp4 GFPExp4
	syms d b kTL mRNA0Exp1
	model.sym.x = [mRNAExp1,GFPExp1,mRNAExp2,GFPExp2,mRNAExp3,GFPExp3,mRNAExp4,GFPExp4];
	model.sym.g = [];
	model.sym.p = [d,b,kTL,mRNA0Exp1];
	model.sym.x0 = [mRNA0Exp1,0,mRNA0Exp1/2,0,mRNA0Exp1,0,mRNA0Exp1,0];
	model.sym.y = [GFPExp1,GFPExp2,GFPExp3,GFPExp4];
	model.sym.xdot = [-d*mRNAExp1,kTL*mRNAExp1 - GFPExp1*b,-d*mRNAExp2,kTL*mRNAExp2 - GFPExp2*b,-d*mRNAExp3,(kTL*mRNAExp3)/2 - GFPExp3*b,-d*mRNAExp4,kTL*mRNAExp4 - (3*GFPExp4*b)/4];
end