function model = Transfection_4State()
    % Transfection_2State provides the GenSSI implementation of the 4-state 
    % model for mRNA transfection introduced by
    % 
    %    Lechtenberg, L. (2015). Model selection in deterministic models of
    %    mRNA transfection. Master Thesis, Ludwig-Maximilians-Universitaet,
    %    Munich, Germany.
    %
    % In contrast to the 2-state transfection model, the 4-state transfection
    % model accounts for an enzymatic degration of the mRNA.
    %
    % The ODE is given by
    %
    %    d[mRNA|/dt     = -d1*[mRNA]-d2*[mRNA]*[enz],      [mRNA](0)     = mRNA0
    %    d[GFP]/dt      = +kTL*[mRNA]-b*[GFP],             [GFP](0)      = 0
    %    d[enz|/dt      = +d3*[mRNA:enz]-d2*[mRNA]*[enz],  [enz](0)      = enz0
    %    d[mRNA:enz]/dt = -d3*[mRNA:enz]+d2*[mRNA]*[enz],  [mRNA:enz](0) = 0
    %
    % in which [mRNA], [GFP], [enz] and [mRNA:enz] denote the 
    % concentrations of GFP-mRNA, GFP-protein, mRNA degrading enzyme and 
    % mRNA-enzyme-complex, respectively.

    % Symbolic variables
    syms mRNA GFP enz mRNAenz
    syms d1 d2 d3 b kTL mRNA0 enz0
    
    % Parameters
    model.sym.p = [d1,d2,d3,b,kTL,mRNA0,enz0];

    % State variables
    model.sym.x = [mRNA,GFP,enz,mRNAenz];

    % Control vectors (g)
    model.sym.g = [];

    % Autonomous dynamics (f)
    model.sym.xdot = [-d1*mRNA-d2*mRNA*enz,...
                     +kTL*mRNA-b*GFP,...
                     +d3*mRNAenz-d2*mRNA*enz,...
                     -d3*mRNAenz+d2*mRNA*enz];

    % Initial conditions
    model.sym.x0 = [mRNA0,0,enz0,0];       

    % Observables
    model.sym.y = [GFP];
end
