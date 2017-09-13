function transDef = TransformationDefinition()
    % mRNA model M2 (M2TwoDeg)
    syms mRNA GFP enz mRNAenz mRNA0 enz0
    syms mRNAdmRNA0 enzdmRNA0
    syms d1 d2 d3 b kTL
    syms d2tmRNA0 kTLtmRNA0 enz0dmRNA0
    transDef.sym.Transformation = [mRNA/mRNA0;GFP;enz/mRNA0];
    transDef.sym.Constraint = [enz-enz0+mRNAenz];
    transDef.sym.p = [d1,d2tmRNA0,d3,b,kTLtmRNA0,enz0dmRNA0];
    syms mRNAnew GFPnew enznew
    transDef.sym.stateSubs = [mRNAdmRNA0,mRNAnew;...
                              GFP,GFPnew;...
                              enzdmRNA0,enznew];
    transDef.sym.parSubs = [d2*mRNA0,d2tmRNA0;...
                            kTL*mRNA0,kTLtmRNA0;...
                            enz0/mRNA0,enz0dmRNA0];
end