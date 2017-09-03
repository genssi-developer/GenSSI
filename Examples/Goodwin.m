%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                 THE GOODWIN OSCILLATOR                                   %%%
%%%  Bibliography: Goodwin, B.C., Oscillatory behavior in enzymatic control  %%% 
%%%                processes, Adv. Enzyme Regul. (3), 425–428, 1965.         %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Goodwin()
%     model.Name='Goodwin';

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

    model.sym.x = [x1 x2 x3];

%     model.Npar=8;            % Number of model parameters

%     model.Noc=0;             % Number of controls

%     model.Nobs=1;                % Number of observables

    % Equations of the model 
    model.sym.xdot=[-p4*x1+p1/(p2+x3^p3),...
                     p5*x1-p6*x2,...
                     p7*x2-p8*x3];

    % controls
    model.sym.u = [];

    % Observables
    model.sym.y = [x1,x2,x3]; % This results in Nobs=3!

    model.sym.x0 = [0.3 0.9 1.3];      % Initial conditions

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  PARAMETERS CONSIDERED FOR IDENTIFIABILITY   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    model.sym.p = [p1 p2 p3 p4 p5 p6 p7 p8];
%     model.Par=[p1 p2 p4 p5 p6 p7 p8];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   GENERATING SERIES FUNCTION     %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
