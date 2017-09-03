%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             BILIRUBIN 1                                    %%%
%%%  Bibliography: Meshkat, N., Kuo, C.E.-z. and DiStefano, J., III (2014) On  %%%
%%%                finding and using identifiable parameter combinations in    %%%
%%%                nonlinear dynamic Systems Biology models and COMBOS: a      %%%
%%%                novel Web implementation, PLoS ONE, 9, e110261              %%%
%%%                                                                            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Bilirubin1()
	syms x1 x2 x3 x4
	syms k03 k04 k13 k24 k31 k42 k43
	model.sym.x = [x1 x2 x3 x4];
	model.sym.u = [1];
	model.sym.p = [k03 k04 k13 k24 k31 k42 k43];
	model.sym.x0 = [0 0 0 0];
	model.sym.y = [x1 x2];
	model.sym.xdot = [-k31*x1+k13*x3,...
                      -k42*x2+k24*x4,...
                       k31*x1-(k03+k13+k43)*x3,...
                       k42*x2+k43*x3-(k04+k24)*x4];
end