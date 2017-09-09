%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                              THYROID 1                                     %%%
%%%  Bibliography: Meshkat, N., Kuo, C.E.-z. and DiStefano, J., III (2014) On  %%%
%%%                finding and using identifiable parameter combinations in    %%%
%%%                nonlinear dynamic Systems Biology models and COMBOS: a      %%%
%%%                novel Web implementation, PLoS ONE, 9, e110261              %%%
%%%                                                                            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Thyroid1()
	syms x1 x2 x3
	syms k02 k03 k12 k13 k21 k31 V1
	model.sym.x = [x1 x2 x3];
	model.sym.g = [1,0,0];
	model.sym.p = [k02,k03,k12,k13,k21,k31,V1];
	model.sym.x0 = [0 0 0];
	model.sym.y = [x1/V1];
	model.sym.xdot = [k13*x3+k12*x2-(k21+k31)*x1,...
                      k21*x1-(k12+k02)*x2,...
                      k31*x1-(k13+k03)*x3];
end