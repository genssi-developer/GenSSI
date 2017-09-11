%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            TRANSFECTION 2                                  %%%
%%%  Bibliography: Leonhardt, C., et al. (2013) Single-cell mRNA transfection  %%%
%%%                studies: delivery, kinetics and statistics by numbers,      %%%
%%%                Nanomedicine: Nanotechnology, Biology and Medicine.         %%%
%%%                                                                            %%%
%%%  Variant 2: translation rate and inital mRNA concentration combined.       %%%          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Transfection2()
	syms x1 x2
	syms d kTLm0 b
	model.sym.x = [x1 x2];
	model.sym.g = [];
	model.sym.p = [d,kTLm0,b];
	model.sym.x0 = [1 0];
	model.sym.y = [x2];
	model.sym.xdot = [-d*x1,...
                      kTLm0*x1-b*x2];
end