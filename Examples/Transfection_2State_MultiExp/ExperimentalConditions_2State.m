function expCond = ExperimentalConditions_2State()
    % ExperimentalConditions_2State defines four different experimental  
    % conditions for the model for mRNA transfection introduced by
    % 
    %    Leonhardt et al. (2013). Single-cell mRNA transfection 
    %    studies: delivery, kinetics and statistics by numbers, 
    %    Nanomedicine: Nanotechnology, Biology and Medicine. 10(4):679-88.
    %
    % Experimental conditions
    % (1) transfection without perturbations
    % (2) reduction of amount of transfection (mRNA0)
    % (3) reduction of translation (uSyn)
    % (4) reduction of protein degration (uDeg)
    
    % Symbolic variables
    syms mRNA0
    
    % Input values
    %     Condition  (1)  (2)  (3)  (4)
    expCond.sym.u = [1.0, 1.0, 0.5, 1.0   % uSyn
                     1.0, 1.0, 1.0, .75]; % uDeg
    
    % Initial conditions
    %     Condition     (1)      (2)      (3)    (4)
    expCond.sym.x0 = [ mRNA0, 0.5*mRNA0, mRNA0, mRNA0   % [mRNA](0)
                           0,         0,     0,     0]; % [GFP](0)
end