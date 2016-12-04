%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                 THE GOODWIN OSCILLATOR                                   %%%
%%%  Bibliography: Goodwin, B.C., Oscillatory behavior in enzymatic control  %%% 
%%%                processes, Adv. Enzyme Regul. (3), 425–428, 1965.         %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Goodwin()
    model.Name='Goodwin';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DECLARE SYMBOLIC VARIABLES:                          %
    %               - state variables                          %
    %               - parameters of the model                  %
    %               -initial state, if not known               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    syms x1 x2 x3 p1 p2 p3 p4 p5 p6 p7 p8 

    %%%%%%%%%%%%%%%%%%%%%%%%%
    %   MODEL RELATED DATA  %
    %%%%%%%%%%%%%%%%%%%%%%%%%

    model.Nder=3;            % Number of derivatives

    model.Neq=3;             % Number of states 
    model.X=[x1 x2 x3];

    model.Npar=8;            % Number of model parameters

    model.Noc=0;             % Number of controls

    model.Nobs=1;                % Number of observables

    A1 = -p4*x1+p1/(p2+x3^p3);   % Equations of the model 
    A2 = p5*x1-p6*x2;
    A3 = p7*x2-p8*x3;
    model.F=[A1 A2 A3];

    g1=0;g2=0;g3=0;              % Controls
    model.G=[g1 g2 g3];

    h1=x1;h2=x2;h3=x3;           % Observables
    model.H=[h1 h2 h3];

    model.IC=[0.3 0.9 1.3];      % Initial conditions

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  PARAMETERS CONSIDERED FOR IDENTIFIABILITY   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    model.P=[p1 p2 p3 p4 p5 p6 p7 p8];
    model.Par=[p1 p2 p4 p5 p6 p7 p8];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   GENERATING SERIES FUNCTION     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
