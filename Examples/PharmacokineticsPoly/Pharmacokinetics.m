%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                           PHARMACOKINETICS                                 %%%
%%%  Bibliography: Demignot, S. and Domurado, D. (1987) Effect of prosthetic   %%%
%%%                sugar groups on the pharmacokinetics of glucose-oxidase,    %%%
%%%                Drug Des Deliv, 1, 333-348.                                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Pharmacokinetics()

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DECLARE SYMBOLIC VARIABLES:                          %
    %               - state variables                          %
    %               - parameters of the model                  %
    %               -initial state, if not known               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    syms x1 x2 x3 x4 a1 a2 b1 b2 ka kc vm c0 g

    %%%%%%%%%%%%%%%%%%%%%%%%%
    %   MODEL RELATED DATA  %
    %%%%%%%%%%%%%%%%%%%%%%%%%
    model.sym.x=[x1 x2 x3 x4];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  PARAMETERS CONSIDERED FOR IDENTIFIABILITY   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% Parameters %%% 
    model.sym.p=[a1 a2 b1 b2 ka kc vm c0 g];

    %%% Controls %%%
    model.sym.g=[];

    %%% Observables %%%
    model.sym.y=[x1,x2,x3];

    %%% Equations of the model %%%
    model.sym.xdot=[a1*(x2-x1)-ka*vm*x1/(kc*ka+kc*x3+ka*x1),...
                    a2*(x1-x2),...
                    b1*(x4-x3)-kc*vm*x3/(kc*ka+kc*x3+ka*x1),...
                    b2*(x3-x4)];

    %%% Initial conditions %%%
    model.sym.x0=[c0 0 g*c0 0];
end

