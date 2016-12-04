%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     GLYCOLYSIS METABOLIC PATHWAY                           %%%
%%%  Bibliography: Demignot, S. and Domurado, D. (1987) Effect of prosthetic   %%%
%%%                sugar groups on the pharmacokinetics of glucose-oxidase,    %%%
%%%                Drug Des Deliv, 1, 333-348.                                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Pharmacokinetics()
    model.Name='Pharmacokinetics';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DECLARE SYMBOLIC VARIABLES:                          %
    %               - state variables                          %
    %               - parameters of the model                  %
    %               -initial state, if not known               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    syms x1 x2 x3 x4 a1 a2 bb1 bb2 ka kc vm c0 g

    %%%%%%%%%%%%%%%%%%%%%%%%%
    %   MODEL RELATED DATA  %
    %%%%%%%%%%%%%%%%%%%%%%%%%

    %%% Number of derivatives %%% 
    model.Nder=7;
    model.X=[x1 x2 x3 x4];

    %%% Number of states %%%
    model.Neq=length(model.X); %Neq=4;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  PARAMETERS CONSIDERED FOR IDENTIFIABILITY   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% Parameters %%% 
    model.Par=[a1 a2 bb1 bb2 ka kc vm c0 g];
    %%% Number of model parameters %%%
    model.NPar=length(model.Par);

    %%% Controls %%%
    G1=0;G2=0;G3=0;G4=0;

    model.G=[G1 G2 G3 G4];
    %%% Number of controls %%%
    model.Noc=0;

    %%% Observables %%%
    model.H=[x1 x4];

    %%% Number of observables %%%
    model.Nobs=length(model.H);

    %%% Equations of the model %%%

    A1=a1*(x2-x1)-ka*vm*x1/(kc*ka+kc*x3+ka*x1);
    A2=a2*(x1-x2);
    A3=bb1*(x4-x3)-kc*vm*x3/(kc*ka+kc*x3+ka*x1);
    A4=bb2*(x3-x4);

    model.F=[A1 A2 A3 A4];

    %%% Initial conditions %%%
    model.IC=[c0 0 g*c0 0];
end

