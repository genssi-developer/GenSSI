function varargout = genssiTransformation(varargin)
    % genssiTransformation converts a GenSSI model to a new GenSSI model
    % based on a transformation definition.
    %
    % Parameters:
    %  varargin: generic input arguments    
    %  modelNameIn: the name of the input model (a string)
    %  fileFormat: either 'function' (default), if the model is a MATLAB
    %              function, or 'mat', if the model is a .mat file
    %  transDef: the name of a transformation definition file (string)
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
        transDefName = varargin{3};
    else
        error('please supply the name of a transformation definition in the third parameter');
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
    runTransDef = str2func(transDefName);
    transDef = runTransDef();
     
    isSaveGenSSIModel = true;
    GenSSIDir = fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples'));

    model = modelIn;
    model.Name = modelNameOut;
    model.P = transDef.P;
    model.Par = transDef.Par;
    model.Npar = length(model.Par);
    
    X = transpose(modelIn.X);
    F = transpose(modelIn.F);
    IC = transpose(modelIn.IC);
    G = transpose(modelIn.G);
    H = transpose(modelIn.H);
    if isfield(modelIn,'P') && ~isempty(modelIn.P)
        P = transpose(modelIn.P);
    else
        P = transpose(modelIn.Par);
    end
    if isfield(transDef,'stateSubs')
        stateSubs = transDef.stateSubs;
    else
        stateSubs = [];
    end
    if isfield(transDef,'parSubs')
        parSubs = transDef.parSubs;
    else
        parSubs = [];
    end
    T = transDef.Transformation;
    C = transDef.Constraint;
%     symsDefTest = symsDef(X);
%     syms m G E1 mE
%     eval(symsDefTest);
%     eval(symsDef(X));

    Xnew = sym(zeros(size(T)));
    for i = 1:length(T)
        Xnew(i,1) = sym(['Xnew_' strrep(strrep(char(T(i)),'/','d'),'*','t')]);
    end
% with Xnew = T(X)

    zeroC = sym(zeros(size(C)));
    sol = solve([Xnew;zeroC] == [T;C],X);
    Tinv = sym(zeros(size(X)));
    for i = 1:length(X)
        Tinv(i,1) = eval(['sol.' char(X(i))]);
    end
    
    Fnew = simplify(jacobian(T,X)*subs(F,X,Tinv));
    Hnew = simplify(subs(H,X,Tinv));
    Gnew = simplify(subs(G,X,Tinv));
    ICnew = simplify(subs(T,X,IC));
    
    Xnew = sym(strrep(char(Xnew),'Xnew_',''));
    Fnew = sym(strrep(char(Fnew),'Xnew_',''));
    Hnew = sym(strrep(char(Hnew),'Xnew_',''));
    Gnew = sym(strrep(char(Gnew),'Xnew_',''));
    ICnew = sym(strrep(char(ICnew),'Xnew_',''));
    
    if isempty(stateSubs)
    else
        Xnew = subs(Xnew,stateSubs(:,1),stateSubs(:,2));
        Fnew = subs(Fnew,stateSubs(:,1),stateSubs(:,2));
        Hnew = subs(Hnew,stateSubs(:,1),stateSubs(:,2));
        Gnew = subs(Gnew,stateSubs(:,1),stateSubs(:,2));
        ICnew= subs(ICnew,stateSubs(:,1),stateSubs(:,2));        
    end
    
    if isempty(parSubs)
        Fnew = expand(Fnew);
        for i = 1:length(P)
            for j = 1:length(P)
                Fnew = subs(Fnew,P(i)*P(j),sym([char(P(i)),'t',char(P(j))]));
                Fnew = subs(Fnew,P(i)/P(j),sym([char(P(i)),'d',char(P(j))]));
            end
        end
        Fnew = simplify(Fnew);   
        Hnew = expand(Hnew);
        for i = 1:length(P)
            for j = 1:length(P)
                Hnew = subs(Hnew,P(i)*P(j),sym([char(P(i)),'t',char(P(j))]));
                Hnew = subs(Hnew,P(i)/P(j),sym([char(P(i)),'d',char(P(j))]));
            end
        end
        Hnew = simplify(Hnew);
        Gnew = expand(Gnew);
        for i = 1:length(P)
            for j = 1:length(P)
                Gnew = subs(Gnew,P(i)*P(j),sym([char(P(i)),'t',char(P(j))]));
                Gnew = subs(Gnew,P(i)/P(j),sym([char(P(i)),'d',char(P(j))]));
            end
        end
        Gnew = simplify(Gnew);
        ICnew = expand(ICnew);
        for i = 1:length(P)
            for j = 1:length(P)
                ICnew = subs(ICnew,P(i)*P(j),sym([char(P(i)),'t',char(P(j))]));
                ICnew = subs(ICnew,P(i)/P(j),sym([char(P(i)),'d',char(P(j))]));
            end
        end
        ICnew = simplify(ICnew);     
    else
        Fnew = expand(simplify(subs(Fnew,parSubs(:,1),parSubs(:,2))));
        Hnew = expand(simplify(subs(Hnew,parSubs(:,1),parSubs(:,2))));
        Gnew = expand(simplify(subs(Gnew,parSubs(:,1),parSubs(:,2))));
        ICnew= expand(simplify(subs(ICnew,parSubs(:,1),parSubs(:,2))));
    end
    
    model.X = transpose(Xnew);
    model.Neq = length(model.X);
    model.F = transpose(Fnew);
    model.IC = transpose(ICnew);
    model.G = transpose(Gnew);
    model.H = transpose(Hnew);
    save(fullfile(GenSSIDir,'Examples',[model.Name '.mat']),'model');
    if isSaveGenSSIModel
        genssiStructToSource(model);
    end
%     function symsStr = symsDef(matIn)
%         symsStr = 'syms';
%         for iMat = 1:length(matIn)
%             symsStr = [symsStr,' ',char(matIn(iMat,1))];
%         end
%     end
end

