function model = BIOMD0000000003_syms()

t = sym('t');

avogadro = 6.02214179e23;

%%
% STATES
syms C M X
model.sym.x = [C,M,X];


%%
% PARAMETERS
syms VM1 VM3 Kc vi_reaction1 kd_reaction2 vd_reaction3 Kd_reaction3 K1_reaction4 V2_reaction5 K2_reaction5 K3_reaction6 K4_reaction7 V4_reaction7
model.sym.p = [VM1,VM3,Kc,vi_reaction1,kd_reaction2,vd_reaction3,Kd_reaction3,K1_reaction4,V2_reaction5,K2_reaction5,K3_reaction6,K4_reaction7,V4_reaction7];


%%
% CONDITIONS
model.sym.k = [];


%%
% DYNAMICS

model.sym.xdot = [vi_reaction1 - C*kd_reaction2 - C*X*vd_reaction3*pow(C + Kd_reaction3, -1), ...
- M*V2_reaction5*pow(K2_reaction5 + M, -1) - C*VM1*power(C + Kc, -1)*(M - 1)*pow(K1_reaction4 - M + 1, -1), ...
- V4_reaction7*X*pow(K4_reaction7 + X, -1) - M*VM3*(X - 1)*pow(K3_reaction6 - X + 1, -1)];

%%
% INITIALIZATION

model.sym.x0 = [1/100, ...
1/100, ...
1/100];

%%
% OBSERVABLES

% V1
% V3
model.sym.y = [C, ...
M, ...
X];


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

