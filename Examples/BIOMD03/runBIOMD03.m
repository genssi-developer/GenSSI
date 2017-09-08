% Model name
modelName = 'BIOMD03';
% Import of SBML model
ODE = SBMLode(modelName);
% Definition of observable
ODE.observable = ODE.state;
% Writing of model to AMICI format
% (which is consistent with GenSSI)
ODE.writeAMICI(modelName);
% Structural identifiability analysis (for a subset of the model parameters)
genssiMain('BIOMD03_syms',8,ODE.parameter(3:13));
