function model = Thyroid1()
    % Thyroid1 provides the GenSSI implementation of a 1st version
    % of the Thyroid model described by
    % 
    %    Meshkat et al. (2014). On finding and using identifiable parameter
    %    combinations in nonlinear dynamic Systems Biology models and
    %    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261.

    % Symbolic variables
    syms k02 k03 k12 k13 k21 k31 V1 x10 x20 x30
    syms x1 x2 x3
	
    % Parameters
    model.sym.p = [k02,k03,k12,k13,k21,k31,V1,x10,x20,x30];

    % State variables
    model.sym.x = [x1,x2,x3];
	
    % Control vectors (g)
    model.sym.g = [1,...
                   0,...
                   0];
	
    % Autonomous dynamics (f)
    model.sym.xdot = [k13*x3+k12*x2-(k21+k31)*x1,...
                      k21*x1-(k12+k02)*x2,...
                      k31*x1-(k13+k03)*x3];

    % Initial conditions
    model.sym.x0 = [0,0,0];

    % Observables
    model.sym.y = [x1/V1];
end
