% runBIOMD0000000010 runs the structural identifiability analysis for the 
% model of the MAP kinase cascade described in
% 
%    Kholodenko BN (2000). Negative feedback and ultrasensitivity can 
%    bring about oscillations in the mitogen-activated protein kinase 
%    cascades. Eur. J. Biochem., 267(6): 1583-1588.
%
% The model has been downloaded from the BioModels Database 
% (http://biomodels.caltech.edu/BIOMD0000000010) as an SBML file. This SBML
% file is converted in the GenSSI format before analysis using the libSBML
% see (http://sbml.org/Software/libSBML/Downloading_libSBML). This file is
% extended by observables and renamed.

% Model name
modelName = 'BIOMD0000000010';

% Import of SBML model
ODE = SBMLode([modelName '.xml']);

% Definition of observable
ODE.observable = ODE.state([2,5,8]);

% Writing of model to AMICI format
% (which is consistent with GenSSI)
ODE.writeAMICI(modelName);

% Rename file
movefile([modelName '_syms.m'],[modelName '.m']);

% Structural identifiability analysis (for a subset of the model parameters)
genssiMain(modelName,6,ODE.parameter([1,5,11,13,19,21]));

