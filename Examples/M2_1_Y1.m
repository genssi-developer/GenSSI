function model = M2_1_Y1()
    model.Name='M2_1_Y1';
    syms m G E1 mE d1 d2 d3 b kTL m0 E0
    model.Nder=8;
    model.Neq=4;
    model.Npar=7;
    model.Noc=0;
    model.Nobs=1;
    model.X=[m G E1 mE];
    A1=-d1*m-d2*m*E1;
    A2=+kTL*m-b*G;
    A3=+d3*mE-d2*m*E1;
    A4=-d3*mE+d2*m*E1;
    model.F=[A1 A2 A3 A4];
    g1=0;g2=0;g3=0;g4=0;
    model.G=[g1 g2 g3 g4];
    h1=G;
    model.H=[h1];
    model.IC=[m0 0 E0 0];       
    model.P=[d1 d2 d3 b kTL m0 E0];
    model.Par=[d1 d2 d3 b kTL m0 E0];
end
