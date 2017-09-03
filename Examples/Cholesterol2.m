%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            CHOLESTEROL 2                                   %%%
%%%  Bibliography: Meshkat, N., Kuo, C.E.-z. and DiStefano, J., III (2014) On  %%%
%%%                finding and using identifiable parameter combinations in    %%%
%%%                nonlinear dynamic Systems Biology models and COMBOS: a      %%%
%%%                novel Web implementation, PLoS ONE, 9, e110261              %%%
%%%                                                                            %%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Cholesterol2()
	syms x1 x2
	syms k02 k12 k21 V1
	model.sym.x = [x1 x2];
	model.sym.u = [1];
	model.sym.p = [k02,k12,k21,V1];
	model.sym.x0 = [0 0];
	model.sym.y = [x1/V1];
	model.sym.xdot = [k12*x2-(1+k21)*x1,...
                      k21*x1-(k02+k12)*x2];
end