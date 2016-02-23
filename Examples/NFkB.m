%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                              Nf-KB MODEL                                     %%%
%%% Bibliography: Lipniacki, T., Paszek, P., Brasier, A., Luxon, B., Kimmel, M., %%%
%%%               (2004), Mathematical model of NFkB regulatory module,Journal   %%%
%%%               of Theoretical Biology 228, 195-215.                           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = NFkB()
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     DECLARE SYMBOLIC VARIABLES:                          %
    %               - state variables                          %
    %               - parameters of the model                  %
    %               -initial state, if not known               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    model.Name='NFkB';

    syms x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15 a1 a2 t1 a3 t2 c1a c2a c3a c4a c5a c6a c1 c2 c3 c4 c5 ...
    k1 k2 k3 kprod kdeg kv i1 e2a i1a e1a c1c c2c c3c x01 x06 x07 x08 x09 x010 x011 x012 x014 x015 NF

    model.Nder=2; 

    model.X=[x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 x12 x13 x14 x15];
    model.Neq=length(model.X); %Neq=15;

    model.Par=[t1 a3 t2 c1a c2a c3a c4a c5a c6a c1 c2 c3 c4 c5 k1 k2 k3 kprod kdeg kv i1 e2a i1a...
      e1a c1c c2c c3c];
    model.NPar=length(model.Par); % Npar=27;

    G1=-k1*x1;
    G2=(k1*x1-k2*x2*x8);
    G3=k2*x2*x8;
    G4=0;
    G5=0;
    G6=0;
    G7=0;
    G8=0;G9=0;G10=0;G11=0;G12=0;G13=0;G14=0;G15=0;
    model.G=[G1 G2 G3 G4 G5 G6 G7 G8 G9 G10 G11 G12 G13 G14 G15];
    model.Noc=1;

    h1=x7;h2=x10+x13;h3=x9;h4=x1+x2+x3;h5=x2;h6=x12;h7=0;h8=0;h9=0;h10=0;h11=0;
    h12=0;h13=0;h14=0;h15=0;
    model.H=[h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15];
    model.Nobs=6; %why is this different from the length of H?

    A1 =kprod-kdeg*x1;
    A2 =-k3*x2-kdeg*x2-a2*x2*x10+t1*x4-a3*x2*x13+t2*x5;
    A3 =k3*x2-kdeg*x3;
    A4=a2*x2*x10-t1*x4;
    A5=a3*x2*x13-t2*x5;
    A6=c6a*x13-a1*x6*x10+t2*x5-i1*x6;
    A7=i1*kv*x6-a1*x11*x7;
    A8=c4*x9-c5*x8;
    A9=c2+c1*x7-c3*x9;
    A10=-a2*x2*x10-a1*x10*x6+c4a*x12-c5a*x10-i1a*x10+e1a*x11;
    A11=-a1*x11*x7+i1a*kv*x10-e1a*kv*x11;
    A12=c2a+c1a*x7-c3a*x12;
    A13=a1*x10*x6-c6a*x13-a3*x2*x13+e2a*x14;
    A14=a1*x11*x7-e2a*kv*x14;
    A15=c2c+c1c*x7-c3c*x15;   
    model.F=[A1 A2 A3 A4 A5 A6 A7 A8 A9 A10 A11 A12 A13 A14 A15];

    model.IC=[x01 0 0 0 0 x06 x07 x08 x09 x010 x011 x012 NF x014 x015];
end
