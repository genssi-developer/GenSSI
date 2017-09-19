% runBIOMD0000000003 runs the structural identifiability analysis for the 
% model of the mitotic oscillator described in
% 
%    Goldbeter A (1991). A minimal cascade model for the mitotic
%    oscillator involving cyclin and cdc2 kinase. Proc. Natl. Acad. Sci. 
%    U.S.A. 88(20): 9107-9111.
%
% The model has been downloaded from the BioModels Database 
% (http://biomodels.caltech.edu/BIOMD0000000003) as an SBML file. This SBML
% file is converted in the GenSSI format before analysis using the libSBML
% see (http://sbml.org/Software/libSBML/Downloading_libSBML). This file is
% extended by observables and renamed.

% Model name
modelName = 'BIOMD0000000003';

% Import of SBML model
ODE = SBMLode([modelName '.xml']);

% Definition of observable
ODE.observable = ODE.state;

% Writing of model to AMICI format
% (which is consistent with GenSSI)
ODE.writeAMICI(modelName);

% Rename file
movefile([modelName '_syms.m'],[modelName '.m']);

% Confirm execution
genssiAskForConfirmation(8000);

% Structural identifiability analysis (for a subset of the model parameters)
genssiMain(modelName,4,ODE.parameter([4,6,9,13]));

