function model = HIV()
    % HIV provides the GenSSI implementation of model for HIC dynamics
    % described by
    % 
    %    Meshkat et al. (2014). On finding and using identifiable parameter
    %    combinations in nonlinear dynamic Systems Biology models and
    %    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261.

    % Symbolic variables
	syms b c d q1 q2 k1 k2 w1 w2
    syms x1 x2 x3 x4

    % Parameters
	model.sym.p = [b;c;d;q1;q2;k1;k2;w1;w2];

    % State variables
	model.sym.x = [x1 x2 x3 x4];

    % Control vectors (g)
	model.sym.g = [1
                   0
                   0
                   0];

    % Autonomous dynamics (f)
	model.sym.xdot = [-b*x1*x4-d*x1
                       b*q1*x1*x4-k1*x2-w1*x2
                       b*q2*x1*x4+k1*x2-w2*x3
                       -c*x4+k2*x3];

    % Initial conditions
	model.sym.x0 = [0;0;0;0];

    % Observables    
	model.sym.y = [x1;x4];
end