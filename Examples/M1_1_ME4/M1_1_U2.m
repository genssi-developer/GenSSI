function model = M1_1_U2()
    % mRNA model M1 (trivial), 1 observable, original model, 2 controls
    % dG/dt = kTL*M*uInh - b*G*uDeg, inhibition of translation, degradation
    syms  m G d b kTL m0
    model.sym.x=[m G];
    A1=-d*m;
    A2=0;
    model.sym.xdot=[A1 A2];
    model.sym.g=[0,kTL*m;...
                 0,-b*G];
    h1=G;
    model.sym.y=[h1];
    model.sym.x0=[m0 0];
    model.sym.p=[d b kTL m0];
end