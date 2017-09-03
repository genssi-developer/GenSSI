%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            TRANSFECTION 3                                  %%%
%%%  Bibliography: Leonhardt, C., et al. (2013) Single-cell mRNA transfection  %%%
%%%                studies: delivery, kinetics and statistics by numbers,      %%%
%%%                Nanomedicine: Nanotechnology, Biology and Medicine.         %%%
%%%                                                                            %%%
%%%  Variant 3: multi-experiment model (cf. reference manual).                 %%%          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Transfection3()
	syms mExp1 GExp1 mExp2 GExp2
	syms d b kTL m0Exp1 m0Exp2 G0Exp2
	model.sym.x = [mExp1,GExp1,mExp2,GExp2];
	model.sym.u = [0  0  0  1];
	model.sym.p = [d,b,kTL,m0Exp1,m0Exp2,G0Exp2];
	model.sym.x0 = [m0Exp1,0,m0Exp2,G0Exp2];
	model.sym.y = [GExp1,GExp2];
	model.sym.xdot = [-d*mExp1,...
                      kTL*mExp1 - GExp1*b,...
                      -d*mExp2,...
                      -GExp2*b];
end