modelName = 'BIOMD03';
ODE = SBMLode(modelName);
% set all states as observable
ODE.observable = ODE.state;
ODE.writeAMICI(modelName);
% check structural identifiability using all parameters except the first 2
Par = ODE.parameter(3:13);
genssiMain('BIOMD03_syms',8,Par);

