function model = B_HIV_3()
    % HIV provides the GenSSI implementation of model for HIC dynamics
    % described by
    % 
    %    Meshkat et al. (2014). On finding and using identifiable parameter
    %    combinations in nonlinear dynamic Systems Biology models and
    %    COMBOS: a novel Web implementation, PLoS ONE, 9, e110261.

    % Symbolic variables
	syms bbeta lm a b c d hh k q uu
    syms xx y v ww z 
    syms xx0 y0 v0 ww0 z0

    % Parameters
	%model.sym.p = [bbeta;lm;a;b;c;d;hh;k;q;uu];
    model.sym.p = [bbeta;lm;a;b;c;d;hh;k;q;uu;xx0;y0;v0;ww0;z0];

    % State variables
	model.sym.x = [xx y v ww z];

    % Control vectors (g)
	model.sym.g = [0
                   0
                   0
				   0
                   0];

    % Autonomous dynamics (f)
	model.sym.xdot = [lm - (d * xx) - (bbeta * xx * v)
                       (bbeta * xx * v) - (a * y)
                       (k * y) - (uu * v)
                       (c * z * y * ww) - (c * q * y * ww) - (b * ww)
					   (c * q * y * ww) - (hh * z)];

    % Initial conditions
	model.sym.x0 = [xx0;y0;v0;ww0;z0];

    % Observables    
	model.sym.y = [ww;z];
end