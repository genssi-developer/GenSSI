function varargout = genssiMultiExperiment(varargin)
    % genssiMultiExperiment converts a GenSSI model to a new GenSSI model
    % based on a multi-experiment definition.
    %
    % Parameters:
    %  varargin: generic input arguments
    %  modelNameIn: the name of the input model (a string)
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
        multiExpName = varargin{2};
    else
        error('please supply the name of a mutiple experiment definition in the second parameter');
    end
    if nargin >= 3
        modelNameOut = varargin{3};
    else
        error('please supply the name of an output model in the third parameter');
    end
    
    runModel = str2func(modelNameIn);
    modelIn = runModel();
    runMultiExp = str2func(multiExpName);
    multiExp = runMultiExp();
     
    GenSSIDir = fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples'));
    
    nState = length(modelIn.sym.x);
    nExp = multiExp.sym.Nexp;
    nObs = length(modelIn.sym.y);
    
    X = modelIn.sym.x;
    XState = sym(zeros(1,nState));
    XMulti = sym(zeros(nState,nExp));
    FMulti = sym(zeros(nState,nExp));
    HMulti = sym(zeros(nObs,nExp));
    for iExp = 1:nExp
        for iState = 1:nState
            XState(iState) = sym([char(X(iState)) 'Exp' num2str(iExp)]);
        end
        XMulti(:,iExp) = XState; % z.B. mExp1,GExp1
        FMulti(:,iExp) = subs(modelIn.sym.xdot,X,XState)+...
                         subs((multiExp.sym.g(iExp,:))*(modelIn.sym.g),X,XState);
        HMulti(:,iExp) = subs(modelIn.sym.y,X,XState);
    end
    XMulti = reshape(XMulti,[1,nState*nExp]);
    FMulti = reshape(FMulti,[1,nState*nExp]);
    HMulti = reshape(HMulti,[1,nObs*nExp]);
    model.sym.x = XMulti;
    model.sym.xdot = FMulti;
    model.sym.g = [];
    model.sym.y = HMulti;
    model.sym.x0 = multiExp.sym.x0;
    model.sym.p = multiExp.sym.p;
    genssiStructToSource(model,modelNameOut);
end