%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            TRANSFECTION 1                                  %%%
%%%  Bibliography: Leonhardt, C., et al. (2013) Single-cell mRNA transfection  %%%
%%%                studies: delivery, kinetics and statistics by numbers,      %%%
%%%                Nanomedicine: Nanotechnology, Biology and Medicine.         %%%
%%%                                                                            %%%
%%%  Variant 1: translation of mRNA to GFP, degradation of both.               %%%          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Transfection1()
	syms x1 x2
	syms d kTL b m0
	model.sym.x = [x1 x2];
	model.sym.g = [];
	model.sym.p = [d,kTL,b,m0];
	model.sym.x0 = [m0 0];
	model.sym.y = [x2];
	model.sym.xdot = [-d*x1,...
                      kTL*x1-b*x2];
end