function model = Goodwin()
    % Goodwin provides the GenSSI implementation of the Goodwin oscillator
    % as introduced in
    % 
    %    Goodwin, B.C. (1965). Oscillatory behavior in enzymatic control
    %              processes, Adv. Enzyme Regul. (3), 425-428. 

    % Symbolic variables
    syms p1 p2 p3 p4 p5 p6 p7 p8 
    syms x1 x2 x3

    % Parameters
    model.sym.p = [p1,p2,p3,p4,p5,p6,p7,p8];

    % State variables
    model.sym.x = [x1,x2,x3];

    % Control vectors (g)
    model.sym.g = [];
    
    % Autonomous dynamics (f)
    model.sym.xdot=[-p4*x1+p1/(p2+x3^p3),...
                     p5*x1-p6*x2,...
                     p7*x2-p8*x3];

    % Initial conditions
    model.sym.x0 = [0.3,0.9,1.3];
    
    % Observables
    model.sym.y = [x1,x2,x3];
end
