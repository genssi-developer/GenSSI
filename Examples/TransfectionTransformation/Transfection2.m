%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                            TRANSFECTION 2                                  %%%
%%%  Bibliography: Leonhardt, C., et al. (2013) Single-cell mRNA transfection  %%%
%%%                studies: delivery, kinetics and statistics by numbers,      %%%
%%%                Nanomedicine: Nanotechnology, Biology and Medicine.         %%%
%%%                                                                            %%%
%%%  Variant 2: degradation via an enzyme                                      %%%          
%%%  Bibliography: Lechtenberg, L. (2015). Model selection in deterministic    %%%
%%%                models of mRNA transfection." Master Thesis,                %%%
%%%                Ludwig-Maximilians-Universität.                             %%%                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function model = Transfection2()
    syms mRNA GFP enz mRNAenz d1 d2 d3 b kTL mRNA0 enz0
    model.sym.x=[mRNA GFP enz mRNAenz];
    model.sym.xdot=[-d1*mRNA-d2*mRNA*enz,...
                    +kTL*mRNA-b*GFP,...
                    +d3*mRNAenz-d2*mRNA*enz,...
                    -d3*mRNAenz+d2*mRNA*enz];
    model.sym.g=[];
    model.sym.y=[GFP];
    model.sym.x0=[mRNA0 0 enz0 0];       
    model.sym.p=[d1 d2 d3 b kTL mRNA0 enz0];
end
