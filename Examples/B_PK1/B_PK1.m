function model = B_PK1()
    % HIV provides the GenSSI implementation of model for HIC dynamics
    % described by
    % 
    %    Meshkat et al. (2014). On finding and using identifiable parameter
    %    combinations in nonlinear dynamic Systems Biology models and
    %    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261.

    % Symbolic variables
	syms k1 k2 k3 k4 k5 k6 k7...
    s2 s3
    syms x1 x2 x3 x4 x01 x02 x03 x04

    % Parameters
	%model.sym.p = [k1; k2; k3; k4; k5; k6; k7; s2; s3;x01;x02;x03;x04];
    model.sym.p = [k1; k2; k3; k4; k5; k6; k7; s2; s3];
    % State variables
	model.sym.x = [x1 x2 x3 x4];

    % Control vectors (g)
	model.sym.g = [1
                   0
                   0
                   0];

    % Autonomous dynamics (f)
	model.sym.xdot = [-(k1+k2)*x1
                       k1*x1-(k3+k6+k7)*x2+k5*x4
                       k2*x1+k3*x2-k4*x3
                       k6*x2-k5*x4];

    % Initial conditions
	model.sym.x0 = [x01;x02;x03;x04];

    % Observables    
	model.sym.y = [s2*x2;s3*x3];
end