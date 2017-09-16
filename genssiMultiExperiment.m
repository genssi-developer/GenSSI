function genssiMultiExperiment(varargin)
    % genssiMultiExperiment converts a GenSSI model to a new GenSSI model
    % based on a multi-experiment definition.
    %
    % Parameters:
    %  varargin: generic input arguments
    %  modelNameIn: the name of the input model (a string)
    %  ExpCondName: the name of a file defining experimental conditions (string)
    %  modelNameOut: the name of the output model (a string)
    %
    % Return values:
    %  void
    
    % Check inputs
    if nargin >= 1
        modelNameIn = varargin{1};
    else
        error('Please supply the name of an input model in the first parameter.');
    end
    if nargin >= 2
        ExpCondName = varargin{2};
    else
        error('Please supply the name of a file defining experimental conditions in the second parameter.');
    end
    if nargin >= 3
        modelNameOut = varargin{3};
    else
        error('Please supply the name of an output model in the third parameter.');
    end
    
    % Load model and definition of experimental conditions
    modelIn = genssiTransposeModel(eval(modelNameIn));
    expCond = eval(ExpCondName);
    
    % Check model and expeimental condition
    modelIn = genssiCheckModel(modelIn);
    expCond = genssiCheckExpCondition(modelIn,expCond);
     
    % Evaluate dimensionality
    nState = length(modelIn.sym.x);
    nCont = size(modelIn.sym.g,2);
    nExp = size(expCond.sym.u,2);
    nObs = length(modelIn.sym.y);
    
    % Initialize model properties
    XMulti = sym(zeros(nState,nExp));
    FMulti = sym(zeros(nState,nExp));
    HMulti = sym(zeros(nObs,nExp));
    if isempty(expCond.sym.u) || isempty(modelIn.sym.g)
        GMulti = [];
    else
        GMulti = sym(zeros(nState,nCont,nExp));
    end
    
    % Construct integrated model for all experimental conditions
    for iExp = 1:nExp
        for iState = 1:nState
            XMulti(iState,iExp) = sym([char(modelIn.sym.x(iState)) 'Exp' num2str(iExp)]);
        end
        if isempty(expCond.sym.u)
            FMulti(:,iExp)   = subs(modelIn.sym.xdot,modelIn.sym.x,XMulti(:,iExp));
            GMulti(:,:,iExp) = subs(modelIn.sym.g   ,modelIn.sym.x,XMulti(:,iExp));
        else
            FMulti(:,iExp) = subs(modelIn.sym.xdot + modelIn.sym.g*expCond.sym.u(:,iExp),modelIn.sym.x,XMulti(:,iExp));
        end
        HMulti(:,iExp) = subs(modelIn.sym.y,modelIn.sym.x,XMulti(:,iExp));
    end
    
    % Assemble model for (multiple) experimental conditions
    model.sym.p = modelIn.sym.p;
    model.sym.x = XMulti(:);
    model.sym.xdot = FMulti(:);
    model.sym.g = reshape(permute(GMulti,[1,3,2]),size(GMulti,1)*size(GMulti,3),size(GMulti,2));
    model.sym.y = HMulti(:);
    model.sym.x0 = expCond.sym.x0(:);
    
    % Transpose model
    model = genssiTransposeModel(model);

    % Write to model to file
    genssiStructToSource(model,modelNameOut);
end