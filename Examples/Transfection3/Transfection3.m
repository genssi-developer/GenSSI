function model = Transfection3()
    % Transfection3 provides the GenSSI implementation of the model for 
    % mRNA transfection described by
    % 
    %    Leonhardt et al. (2013). Single-cell mRNA transfection studies:
    %    delivery, kinetics and statistics by numbers, Nanomedicine: 
    %    Nanotechnology, Biology and Medicine, 10(4), 679-688.
    %
    % under two distinct experimental conditions:
    % - Condition 1: mRNA transfection
    %      state variables:   mExp1 (mRNA level),  GExp1 (protein level)
    %      intial conditions: mExp1(t_0) = m0Exp1, GExp1(t_0) = 0,
    % - Condition 2: inhibition of protein synthesis after transfection
    %      state variables:   mExp2 (mRNA level),  GExp2 (protein level)
    %      intial conditions: mExp2(t_0) = m0Exp2, GExp2(t_0) = G0Exp2,
    %
    % This implementation allows for the analysis of strutural
    % identifiability assuming that experimental data for two different
    % conditions are available.
    
    % Symbolic variables
	syms d b kTL m0Exp1 m0Exp2 G0Exp2
    syms mExp1 GExp1 mExp2 GExp2

    % Parameters
	model.sym.p = [d,b,kTL,m0Exp1,m0Exp2,G0Exp2];

    % State variables
	model.sym.x = [mExp1,GExp1,mExp2,GExp2];

    % Control vectors (g)
	model.sym.g = [0,...
                   0,...
                   0,...
                   1];

    % Autonomous dynamics (f)
	model.sym.xdot = [-d*mExp1,...
                      kTL*mExp1 - GExp1*b,...
                      -d*mExp2,...
                      -GExp2*b];

    % Initial conditions
	model.sym.x0 = [m0Exp1,0,m0Exp2,G0Exp2];

    % Observables
	model.sym.y = [GExp1,GExp2];
end