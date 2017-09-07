function model = Cholesterol2()
    % Cholesterol2 provides the GenSSI implementation of a 2nd version
    % of the Cholesterol metabolism model described by
    % 
    %    Meshkat et al. (2014). On finding and using identifiable parameter
    %    combinations in nonlinear dynamic Systems Biology models and
    %    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261

    % Symbolic variables
	syms k02 k12 k21 V1
    syms x1 x2
    
    % Parameters
	model.sym.p = [k02,k12,k21,V1];

    % State variables
	model.sym.x = [x1 x2];

    % Control vectors
	model.sym.G = [1,0];

    % Autonomous dynamics (F)
	model.sym.xdot = [k12*x2-(1+k21)*x1,...
                      k21*x1-(k02+k12)*x2];

    % Initial conditions
	model.sym.x0 = [0 0];

    % Observables
	model.sym.y = [x1/V1];
end