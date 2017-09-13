%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            TRANSFECTION 1                                  %%%
%%%  Bibliography: Leonhardt, C., et al. (2013) Single-cell mRNA transfection  %%%
%%%                studies: delivery, kinetics and statistics by numbers,      %%%
%%%                Nanomedicine: Nanotechnology, Biology and Medicine.         %%%
%%%                                                                            %%%
%%%  Variant 1: translation of mRNA to GFP, degradation of both.               %%%          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Transfection1()
    % mRNA model M1 (trivial), 1 observable, original model, 2 controls
    % dGFP/dt = kTL*M*uInh - b*GFP*uDeg, inhibition of translation, degradation
    syms  mRNA GFP d b kTL mRNA0
    model.sym.x=[mRNA GFP];
    model.sym.xdot=[-d*mRNA 0];
    model.sym.g=[0,kTL*mRNA;...
                 0,-b*GFP];
    model.sym.y=[GFP];
    model.sym.x0=[mRNA0 0];
    model.sym.p=[d b kTL mRNA0];
end