function model = Bilirubin1()
    % Bilirubin1 provides the GenSSI implementation of a 1st version
    % of the Bilirubin model described by
    % 
    %    Meshkat et al. (2014). On finding and using identifiable parameter
    %    combinations in nonlinear dynamic Systems Biology models and
    %    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261

    % Symbolic variables
    syms x1 x2 x3 x4
	syms k03 k04 k13 k24 k31 k42 k43
    
    % Parameters
	model.sym.p = [k03,k04,k13,k24,k31,k42,k43];
	
    % State variables
    model.sym.x = [x1,x2,x3,x4];

    % Control vectors
    model.sym.g = [1,0,0,0];
    
    % Autonomous dynamics (F)
	model.sym.xdot = [-k31*x1+k13*x3,...
                      -k42*x2+k24*x4,...
                       k31*x1-(k03+k13+k43)*x3,...
                       k42*x2+k43*x3-(k04+k24)*x4];

    % Initial conditions
    model.sym.x0 = [0 0 0 0];
    
    % Observables
	model.sym.y = [x1 x2];
end