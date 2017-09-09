%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                 HIV                                        %%%
%%%  Bibliography: Meshkat, N., Kuo, C.E.-z. and DiStefano, J., III (2014) On  %%%
%%%                finding and using identifiable parameter combinations in    %%%
%%%                nonlinear dynamic Systems Biology models and COMBOS: a      %%%
%%%                novel Web implementation, PLoS ONE, 9, e110261              %%%
%%%                                                                            %%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = HIV()
	syms x1 x2 x3 x4
	syms b c d q1 q2 k1 k2 w1 w2
	model.sym.x = [x1 x2 x3 x4];
	model.sym.g = [1,0,0,0];
	model.sym.p = [b,c,d,q1,q2,k1,k2,w1,w2];
	model.sym.x0 = [0 0 0 0];
	model.sym.y = [x1 x4];
	model.sym.xdot = [-b*x1*x4-d*x1,...
                       b*q1*x1*x4-k1*x2-w1*x2,...
                       b*q2*x1*x4+k1*x2-w2*x3,...
                       -c*x4+k2*x3];
end