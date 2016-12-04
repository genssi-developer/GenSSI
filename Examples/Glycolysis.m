%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     GLYCOLYSIS METABOLIC PATHWAY                           %%%
%%%  Bibliography: Bartl, M., Kotzing, M., Kaleta, C., Schuster, S., Li, P.    %%%
%%%                Just-in-time activation of a glycolysis inspired metabolic  %%%
%%%                network - solution with a dynamic optimization approach.    %%%
%%%                Proc. 55nd International Scientific Colloquium. 2010.       %%%
%%%                Ilmenau, Germany.                                           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Glycolysis()
    model.Name='Glycolysis';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DECLARE SYMBOLIC VARIABLES:                          %
    %               - state variables                          %
    %               - parameters of the model                  %
    %               -initial state, if not known               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    syms x1 x2 x3 x4 x5 k1 k2 k3 k4 kM S0 S1 S2 S3 S4

    %%%%%%%%%%%%%%%%%%%%%%%%%
    %   MODEL RELATED DATA  %
    %%%%%%%%%%%%%%%%%%%%%%%%%

    model.Nder=2;                                % Number of derivatives

    model.Neq=5;                                 % Number of states
    model.X=[x1 x2 x3 x4 x5];

    model.Npar=5;                                % Number of model parameters

    model.Noc=4;                                 % Number of controls

    model.Nobs=5;                                % Number of observables


    A1=0;                                    % The model: the uncontrolled part  
    A2=0;
    A3=0;
    A4=0;
    A5=0;
    model.F=[A1 A2 A3 A4 A5];

    % The controls
    model.G=[-(k1*x1)/(kM+x1),(k1*x1)/(kM+x1),0,0,0;
    0,-(k2*x2)/(kM+x2),(k2*x2)/(kM+x2),(k2*x2)/(kM+x2),0;
    0,0,-(k3*x3)/(kM+x3),(k3*x3)/(kM+x3),0;
    0,0,0,-(k4*x4)/(kM+x4),(k4*x4)/(kM+x4)];

    h1=x1;h2=x2;h3=x3;h4=x4;h5=x5;                          % The observables
    model.H=[h1 h2 h3 h4 h5];

    model.IC=[S0 S1 S2 S3 S4];                                    % The initial conditions  
    %     IC=[1 2 1 2 1];                                    % The initial conditions  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  PARAMETERS CONSIDERED FOR IDENTIFIABILITY   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    model.Par=[k1 k2 k3 k4 kM];
end



