%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     HIGH DIMENSIONAL NONLINEAR MODEL                       %%%
%%%  Bibliography: Saccomani, M.P., et al. (2010) Examples of testing global   %%%
%%%                identifiability of biological and biomedical models with    %%%
%%%                the DAISY software, Computers in Biology and Medicine,      %%%
%%%                40, 402-407.                                                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = HighDimNonLin()
    model.Name='HighDimNonLin';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DECLARE SYMBOLIC VARIABLES:                          %
    %               - state variables                          %
    %               - parameters of the model                  %
    %               -initial state, if not known               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    syms x04 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20 ...
    x01 x02 x03 x04 x05 x06 x07 x08 x09 x010 x011 x012 x013 x014 x015 x016 x017 x018 x019 x020...
    vm km p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20

    %%%%%%%%%%%%%%%%%%%%%%%%%
    %   MODEL RELATED DATA  %
    %%%%%%%%%%%%%%%%%%%%%%%%%

    %%% Number of derivatives %%% 
    model.Nder=3;
    model.X=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 x16 x17 x18 x19 x20];

    %%% Number of states %%%
    model.Neq=length(model.X); %Neq=20;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  PARAMETERS CONSIDERED FOR IDENTIFIABILITY   %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%% Parameters %%% 
    model.Par=[vm km p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20];
    %%% Number of model parameters %%%
    model.NPar=length(model.Par); %Npar=22;

    %%% Controls %%%
    G1=1;G2=0;G3=0;G4=0;G5=0;G6=0;G7=0;G8=0;
    G9=0;G10=0;G11=0;G12=0;G13=0;G14=0;G15=0;G16=0;G17=0;G18=0;G19=0;G20=0;

    model.G=[G1 G2 G3 G4 G5 G6 G7 G8 G9 G10 G11 G12 G13 G14 G15 G16 G17 G18 G19 G20];
    %%% Number of controls %%%
    model.Noc=1;

    %%% Observables %%%
    h1=x1;h2=x2;h3=x3;h4=x4;h5=x5;h6=x6;h7=x7;h8=x8;h9=x9;h10=x10;h11=x11;
    h12=x12;h13=x13;h14=x14;h15=x15;h16=x16;h17=x17;h18=x18;h19=x19;h20=x20;

    model.H=[h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16 h17 h18 h19 h20];

    %%% Number of observables %%%
    model.Nobs=length(model.H); %Nobs=20;

    %%% Equations of the model %%%

    A1 =-vm*x1/(km+x1)-p1*x1;
    A2=p1*x1-p2*x2;
    A3=p2*x2-p3*x3;
    A4=p3*x3-p4*x4;
    A5=p4*x4-p5*x5;
    A6=p5*x5-p6*x6;
    A7=p6*x6-p7*x7;
    A8=p7*x7-p8*x8;
    A9=p8*x8-p9*x9;
    A10=p9*x9-p10*x10;
    A11=p10*x10-p11*x11;
    A12=p11*x11-p12*x12;
    A13=p12*x12-p13*x13;
    A14=p13*x13-p14*x14;
    A15=p14*x14-p15*x15;
    A16=p15*x15-p16*x16;
    A17=p16*x16-p17*x17;
    A18=p17*x17-p18*x18;
    A19=p18*x18-p19*x19;
    A20=p19*x19-p20*x20;

    model.F=[A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15 A16 A17 A18 A19 A20];

    %%% Initial conditions %%%
    model.IC=[x01 x02 x03 x04 x05 x06 x07 x08 x09 x010 x011 x012 x013 x014 x015 x016 x017 x018 x019 x020];
end

