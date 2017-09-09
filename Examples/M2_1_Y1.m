function model = M2_1_Y1()
    syms m G E1 mE d1 d2 d3 b kTL m0 E0
    model.sym.x=[m G E1 mE];
    A1=-d1*m-d2*m*E1;
    A2=+kTL*m-b*G;
    A3=+d3*mE-d2*m*E1;
    A4=-d3*mE+d2*m*E1;
    model.sym.xdot=[A1 A2 A3 A4];
    model.sym.g=[];
    h1=G;
    model.sym.y=[h1];
    model.sym.x0=[m0 0 E0 0];       
    model.sym.p=[d1 d2 d3 b kTL m0 E0];
end
