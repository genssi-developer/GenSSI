modelName = 'BIOMD10';
ODE = SBMLode(modelName);
% set last 3 states as observable
ODE.observable = ODE.state(6:8);
ODE.writeAMICI(modelName);
% check structural identifiability using all Vn_ parameters
Par=ODE.parameter(logical([1,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,1,0,0]));
genssiMain('BIOMD10_syms',6,Par);
