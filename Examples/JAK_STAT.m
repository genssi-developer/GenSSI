%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                 The JAK-STAT signaling pathway                                          %%
%%%                                                                                         %%
%%%  Bibliography: Raue, A., C. Kreutz, et al. (2009). "Structural and practical            %%
%%%                identifiability analysis of partially observed dynamical models by       %%
%%%                exploiting the profile likelihood." Bioinformatics 25(15): 1923-1929.    %%
%%%
%%% Rename (states):
%%% STAT x1
%%% pSTAT x2
%%% pSTAT_pSTAT x3
%%% npSTAT_npSTAT x4
%%% nSTAT1 x5
%%% nSTAT2 x6
%%% nSTAT3 x7
%%% nSTAT4 x8
%%% nSTAT5 x9
%%% 
%%% Rename( parameters):
%%% p1 p1
%%% p2 p2
%%% p3 p3
%%% p4 p4
%%% init_STAT p5 
%%% Omega_cyt p6
%%% Omega_nuc p7
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = JAK_STAT()
model.Name='JAK_STAT';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DECLARE SYMBOLIC VARIABLES:                          %
    %               - state variables                          %
    %               - parameters of the model                  %
    %               -initial state, if not known               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    syms x1 x2 x3 x4 x5 x6 x7 x8 x9
    syms p1 p2 p3 p4 p5 p6 p7

    %%%%%%%%%%%%%%%%%%%%%%%%%
    %   MODEL RELATED DATA  %
    %%%%%%%%%%%%%%%%%%%%%%%%%

    model.Nder=7;                       %  Number of derivatives

    model.X=[x1 x2 x3 x4 x5 x6 x7 x8 x9];
    model.Neq=9;                        % Number of states

%     A1 = 2*p4*x4;
%     A2 = -p2*x2^2;
%     A3 = (1/2)*p2*x2^2-p3*x3;
%     A4 = p3*x3-p4*x4;

    A1 = (p7*p4*x9)/p6;
    A2 = -2*p2*x2^2;
    A3 = p2*x2^2-p3*x3;
    A4 = -(p7*p4*x4-p6*p3*x3)/p7;
    A5 = -p4*(x5-2*x4);
    A6 = p4*(x5-x6);
    A7 = p4*(x6-x7);
    A8 = p4*(x7-x8);
    A9 = p4*(x8-x9);
    model.F=[A1 A2 A3 A4 A5 A6 A7 A8 A9];
    
    G1=p1*x1;                                    % Controls
    %G2=p1*x1;
%     G3=0; G4=0;
    model.G=[-G1 G1 0 0 0 0 0 0 0];
    model.Noc=1;                        % Number of controls

    % Observables
    h1 = (x2+2*x3)/p5;
    h2 = (x1+x2+2*x3)/p5;
    model.H=[h1 h2];
    model.Nobs=2;                       % Number of observables
    model.IC=[p5 0 0 0 0 0 0 0 0]; % Initial conditions

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  PARAMETERS CONSIDERED FOR IDENTIFIABILITY   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                   
    model.P = [p1,p2,p3,p4,p5,p6,p7];
    model.Par = [p1,p2,p3,p4,p5,p6,p7];
    model.Npar=7; % Number of model parameters
end

