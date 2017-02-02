function varargout = genssiMultiExperiment(varargin)
    % genssiMultiExperiment converts a GenSSI model to a new GenSSI model
    % based on a multi-experiment definition.
    %
    % Parameters:
    %  varargin: generic input arguments
    %  modelNameIn: the name of the input model (a string)
    %  fileFormat: either 'function' (default), if the model is a MATLAB
    %              function, or 'mat', if the model is a .mat file
    %  mExDef: the name of a multi-experiment definition file (string)
    %  modelNameOut: the name of the output model (a string)
    %
    % Return values:
    %  varargout: generic output arguments
    %  
    if nargin >= 1
        modelNameIn = varargin{1};
    else
        error('please supply the name of an input model in the first parameter');
    end
    if nargin >= 2
        fileFormat = varargin{2};
    else
        fileFormat = 'function';
    end
    if nargin >= 3
        multiExpName = varargin{3};
    else
        error('please supply the name of a mutiple experiment definition in the third parameter');
    end
    if nargin >= 4
        modelNameOut = varargin{4};
    else
        error('please supply the name of an output model in the fourth parameter');
    end
    
    if strcmp(fileFormat,'mat')
        load(modelNameIn,'model');
    else
        runModel = str2func(modelNameIn);
        modelIn = runModel();
    end
    runMultiExp = str2func(multiExpName);
    multiExp = runMultiExp();
     
    isSaveGenSSIModel = true;
    GenSSIDir = fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples'));
    
    nState = modelIn.Neq;
    nExp = multiExp.Nexp;
    nObs = length(modelIn.H);
    nOc = modelIn.Noc;
    
    model.Name = modelNameOut;    
    model.Nder = modelIn.Nder;
    model.Neq = modelIn.Neq*multiExp.Nexp;
    X = modelIn.X;
    XState = sym(zeros(1,nState));
    XMulti = sym(zeros(nState,nExp));
    FMulti = sym(zeros(nState,nExp));
    HMulti = sym(zeros(nObs,nExp));
    for iExp = 1:nExp
        for iState = 1:nState
            XState(iState) = sym([char(X(iState)) 'Exp' num2str(iExp)]);
        end
        XMulti(:,iExp) = XState; % z.B. mExp1,GExp1
        FMulti(:,iExp) = subs(modelIn.F,X,XState)+...
                         subs((multiExp.U(iExp,:))*(modelIn.G),X,XState);
        HMulti(:,iExp) = subs(modelIn.H,X,XState);
    end
    XMulti = reshape(XMulti,[1,nState*nExp]);
    FMulti = reshape(FMulti,[1,nState*nExp]);
    HMulti = reshape(HMulti,[1,nObs*nExp]);
    model.X = XMulti;
    model.F = FMulti;
    model.G=sym(zeros(1,nState*nExp));
    model.Noc = 0;
    model.H = HMulti;
    model.Nobs = nObs*nExp;
    model.IC = multiExp.IC;
    if isfield(multiExp,'P')
        model.P = multiExp.P;
    end
    model.Par = multiExp.Par;
    model.Npar = length(multiExp.Par);
    save(fullfile(GenSSIDir,'Examples',[model.Name '.mat']),'model');
    if isSaveGenSSIModel
        genssiStructToSource(model);
    end
end