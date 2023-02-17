function model = rxnodes()

    % Specify stoichiometry matrix!
    R_matrix = [-1 0 0;1 -1 0;0 -1 0;0 -1 0;0 1 0;0 1 -1; 0 0 1];
    
    syms PRCA ACA NADPH CO2 NADP MMC SCA
    syms k_pco k_pca k_ccr k_aca k_nadph k_co2 k_mcm K_MMC
    syms pco ccr mcm

    % Parameters
    model.sym.p = [k_pco;k_pca;k_ccr;k_aca;k_nadph;k_co2;k_mcm;K_MMC];

    % State variables
    model.sym.x = [PRCA;ACA;NADPH;CO2;NADP;MMC;SCA];

    % Control vectors
    model.sym.g = [];
    
    % Specify the rate equation for the first reaction (pco):
    r1 = k_pco*pco*(PRCA/k_pca)/(1+PRCA/k_pca);

    % Specify the rate equation for the second reaction (ccr):
    r2_N = k_ccr*ccr*(ACA*NADPH*CO2)/(k_aca*k_nadph*k_co2);
    r2_D = (1+ACA/k_aca)*(1+NADPH/k_nadph)*(1+CO2/k_co2);
    r2 = r2_N/r2_D;

    % Specify the rate equation for the third reaction (mcm):
    r3 = k_mcm*mcm*(MMC/K_MMC)/(1+MMC/K_MMC);

    % Find the values of dC
    v = [r1;r2;r3];
    model.sym.xdot = R_matrix*v;

    % Initial conditions
    model.sym.x0 = [100;0;50;50;0;0;0];
    
    % Observables
    model.sym.y = [PRCA;NADPH;CO2;MMC;SCA];

end
