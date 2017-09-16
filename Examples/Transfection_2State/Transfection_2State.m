function model = Transfection_2State()
    % Transfection_2State provides the GenSSI implementation of the model
    % for mRNA transfection introduced by
    % 
    %    Leonhardt et al. (2013). Single-cell mRNA transfection 
    %    studies: delivery, kinetics and statistics by numbers, 
    %    Nanomedicine: Nanotechnology, Biology and Medicine. 10(4):679-88.
    %
    % The ODE is given by
    %
    %    d[mRNA|/dt = -d*[mRNA],                        [mRNA](0) = mRNA0
    %    d[GFP]/dt  = kTL*[M]*[uSyn] - b*[GFP]*[uDeg],  [GFP](0)  = 0
    %
    % in which [mRNA] and [GFP] denote the concentrations of GFP-mRNA and
    % GFP-protein, respectively. The controls are the concentation of a 
    % protein synthesis inhibitor, [uSyn], and the concentation of a 
    % protein degradation inhibitor, [uDeg].
    
    % Symbolic variables
    syms mRNA GFP
    syms d b kTL mRNA0

    % Parameters
    model.sym.p = [d,b,kTL,mRNA0];

    % State variables
    model.sym.x = [mRNA,GFP];

    % Control vectors (g)
    model.sym.g = [0,kTL*mRNA;... % uSyn
                   0,-b*GFP];     % uDeg

    % Autonomous dynamics (f)
    model.sym.xdot = [-d*mRNA,...
                      0];

    % Initial conditions
    model.sym.x0 = [mRNA0,0];

    % Observables
    model.sym.y = [GFP];
end