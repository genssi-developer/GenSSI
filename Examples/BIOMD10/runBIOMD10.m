% Model name
modelName = 'BIOMD10';
fileName = [modelName,'.xml'];
% Import of SBML model
ODE = SBMLode(fileName);
% Definition of observable
ODE.observable = ODE.state(6:8);
% Writing of model to AMICI format
% (which is consistent with GenSSI)
ODE.writeAMICI(modelName);
% Structural identifiability analysis (for a subset of the model parameters)
genssiMain('BIOMD10_syms',6,ODE.parameter([1,5,11,13,19,21]));
