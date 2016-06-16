%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                 THE CIRCADIAN CLOCK IN ARABIDOPSIS THALIANA                             %%
%%%                                                                                         %%
%%%  Bibliography: Locke, J.C.W., Millar, A.J., Turner, M.S., Modeling genetic              %%
%%%                networks with noisy and varied experimental data: the circadian          %%
%%%                clock in Arabidopsis thaliana, J. Theor. Biol. (234), 383–393, 2005.     %% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Arabidopsis()
model.Name='Arabidopsis';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DECLARE SYMBOLIC VARIABLES:                          %
    %               - state variables                          %
    %               - parameters of the model                  %
    %               -initial state, if not known               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    syms x1 x2 x3 x4 x5 x6 x7 p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14...
         p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27

    %%%%%%%%%%%%%%%%%%%%%%%%%
    %   MODEL RELATED DATA  %
    %%%%%%%%%%%%%%%%%%%%%%%%%

    model.Nder=5;                       %  Number of derivatives

    model.Neq=7;                        % Number of states
    model.X=[x1 x2 x3 x4 x5 x6 x7];

    model.Npar=14;                      % Number of model parameters

    model.Noc=1;                        % Number of controls

    model.Nobs=2;                       % Number of observables

    A1 = p1*x6/(p3+x6)-p5*x1/(p12+x1);            % Equations of the model
    A2 = p19*x1-p22*x2+p23*x3-p6*x2/(p13+x2);
    A3 = p22*x2-p23*x3-p7*x3/(p14+x3);
    A4 = p2*p4^2/(p4^2+x3^2)-p8*x4/(p15+x4);
    A5 = p20*x4-p24*x5+p25*x6-p9*x5/(p16+x5);
    A6 = p24*x5-p25*x6-p10*x6/(p17+x6);
    A7 = p21-p11*x7/(p18+x7);
    model.F=[A1 A2 A3 A4 A5 A6 A7];

    G1=p26*x7;                                    % Controls
    G2=0; G3=0; G4=0; G5=0; G6=0;
    G7=-p21-p27*x7;
    model.G=[G1 G2 G3 G4 G5 G6 G7];

    h1=x1; h2=x4; h3=0; h4=0; h5=0; h6=0; h7=0;   % Observables
    model.H=[h1 h2 h3 h4 h5 h6 h7];

    model.IC=[0 0 0 0 0 0 0];                           % Initial conditions

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  PARAMETERS CONSIDERED FOR IDENTIFIABILITY   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %       Par=[p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27]

    model.Par=[p1, p2, p5, p8, p10, p11,p12, p15, p18, p27, p26]; % rank 11
end

