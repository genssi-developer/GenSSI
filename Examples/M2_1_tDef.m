function transDef = M2_1_tDef()
    % mRNA model M2 (M2TwoDeg)

    transDef.Name='M2_1_tDef';
    syms m G E1 mE m0 E0
    syms mdm0 E1dm0
    syms d1 d2 d3 b kTL
    syms d2tm0 kTLtm0 E0dm0
    transDef.Transformation = [m/m0;G;E1/m0];
    transDef.Constraint = [E1-E0+mE];
    transDef.P = [d1,d2tm0,d3,b,kTLtm0,E0dm0];
    transDef.Par = [d1,d2tm0,d3,b,kTLtm0,E0dm0];
    syms mnew Gnew E1new
    transDef.stateSubs = [mdm0,mnew;...
                          G,Gnew;...
                          E1dm0,E1new];
    transDef.parSubs = [d2*m0,d2tm0;...
                        kTL*m0,kTLtm0;...
                        E0/m0,E0dm0];
end