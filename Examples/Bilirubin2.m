%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             BILIRUBIN "                                    %%%
%%%  Bibliography: Meshkat, N., Kuo, C.E.-z. and DiStefano, J., III (2014) On  %%%
%%%                finding and using identifiable parameter combinations in    %%%
%%%                nonlinear dynamic Systems Biology models and COMBOS: a      %%%
%%%                novel Web implementation, PLoS ONE, 9, e110261              %%%
%%%                                                                            %%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Bilirubin2()
	syms x1 x2 x3 x4
	syms k01 k12 k13 k14 k21 k31 k41 
	model.sym.x = [x1 x2 x3 x4];
	model.sym.u = [1];
	model.sym.p = [k01 k12 k13 k14 k21 k31 k41];
	model.sym.x0 = [1 1 1 1];
	model.sym.y = [x1];
	model.sym.xdot = [-(k21+k31+k41+k01)*x1+k12*x2+k13*x3+k14*x4,...
                       k21*x1-k12*x2,...
                       k31*x1-k13*x3,...
                       k41*x1-k14*x4];
end