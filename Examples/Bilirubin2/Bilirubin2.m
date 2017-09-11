function model = Bilirubin2()
    % Bilirubin2 provides the GenSSI implementation of a 2nd version
    % of the Bilirubin model described by
    % 
    %    Meshkat et al. (2014). On finding and using identifiable parameter
    %    combinations in nonlinear dynamic Systems Biology models and
    %    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261
    
    % Symbolic variables
	syms x1 x2 x3 x4
	syms k01 k12 k13 k14 k21 k31 k41 

    % Parameters
	model.sym.p = [k01,k12,k13,k14,k21,k31,k41];
    
    % State variables
    model.sym.x = [x1,x2,x3,x4];

    % Control vectors (g)
    model.sym.g = [1]; error('dimensions of the control vector are incorrect.')

    % Autonomous dynamics (f)
	model.sym.xdot = [-(k21+k31+k41+k01)*x1+k12*x2+k13*x3+k14*x4,...
                       k21*x1-k12*x2,...
                       k31*x1-k13*x3,...
                       k41*x1-k14*x4];

    % Initial conditions
	model.sym.x0 = [1,1,1,1];

    % Observables
	model.sym.y = [x1];
end