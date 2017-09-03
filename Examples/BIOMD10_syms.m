function model = BIOMD10_syms()

t = sym('t');

avogadro = 6.02214179e23;

%%
% STATES
syms MKKK MKKK_P MKK MKK_P MKK_PP MAPK MAPK_P MAPK_PP
model.sym.x = [MKKK,MKKK_P,MKK,MKK_P,MKK_PP,MAPK,MAPK_P,MAPK_PP];


%%
% PARAMETERS
syms V1_J0 Ki_J0 n_J0 K1_J0 V2_J1 KK2_J1 k3_J2 KK3_J2 k4_J3 KK4_J3 V5_J4 KK5_J4 V6_J5 KK6_J5 k7_J6 KK7_J6 k8_J7 KK8_J7 V9_J8 KK9_J8 V10_J9 KK10_J9
model.sym.p = [V1_J0,Ki_J0,n_J0,K1_J0,V2_J1,KK2_J1,k3_J2,KK3_J2,k4_J3,KK4_J3,V5_J4,KK5_J4,V6_J5,KK6_J5,k7_J6,KK7_J6,k8_J7,KK8_J7,V9_J8,KK9_J8,V10_J9,KK10_J9];


%%
% CONDITIONS
model.sym.k = [];


%%
% DYNAMICS

model.sym.xdot = [(MKKK_P*V2_J1)/(KK2_J1 + MKKK_P) - (MKKK*V1_J0)/((pow(MAPK_PP/Ki_J0, n_J0) + 1)*(K1_J0 + MKKK)), ...
(MKKK*V1_J0)/((pow(MAPK_PP/Ki_J0, n_J0) + 1)*(K1_J0 + MKKK)) - (MKKK_P*V2_J1)/(KK2_J1 + MKKK_P), ...
(MKK_P*V6_J5)/(KK6_J5 + MKK_P) - (MKK*MKKK_P*k3_J2)/(KK3_J2 + MKK), ...
(MKK_PP*V5_J4)/(KK5_J4 + MKK_PP) - (MKK_P*V6_J5)/(KK6_J5 + MKK_P) + (MKK*MKKK_P*k3_J2)/(KK3_J2 + MKK) - (MKK_P*MKKK_P*k4_J3)/(KK4_J3 + MKK_P), ...
(MKK_P*MKKK_P*k4_J3)/(KK4_J3 + MKK_P) - (MKK_PP*V5_J4)/(KK5_J4 + MKK_PP), ...
(MAPK_P*V10_J9)/(KK10_J9 + MAPK_P) - (MAPK*MKK_PP*k7_J6)/(KK7_J6 + MAPK), ...
(MAPK_PP*V9_J8)/(KK9_J8 + MAPK_PP) - (MAPK_P*V10_J9)/(KK10_J9 + MAPK_P) + (MAPK*MKK_PP*k7_J6)/(KK7_J6 + MAPK) - (MAPK_P*MKK_PP*k8_J7)/(KK8_J7 + MAPK_P), ...
(MAPK_P*MKK_PP*k8_J7)/(KK8_J7 + MAPK_P) - (MAPK_PP*V9_J8)/(KK9_J8 + MAPK_PP)];

%%
% INITIALIZATION

model.sym.x0 = [90, ...
10, ...
280, ...
10, ...
10, ...
280, ...
10, ...
10];

%%
% OBSERVABLES

% 
model.sym.y = [MAPK, ...
MAPK_P, ...
MAPK_PP];


end

function r = pow(x,y)

    r = x^y;

end

function r = power(x,y)

    r = x^y;

end

function r = factorial(x)

    error('The factorial function is currently not supported!');

end

function r = cei(x)

    error('The cei function is currently not supported!');

end

function r = psi(x)

    error('The psi function is currently not supported!');

end

