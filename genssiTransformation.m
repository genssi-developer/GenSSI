function varargout = genssiTransformation(varargin)
    % genssiTransformation converts a GenSSI model to a new GenSSI model
    % based on a transformation definition.
    %
    % Parameters:
    %  varargin: generic input arguments    
    %  modelNameIn: the name of the input model (a string)
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
        transDefName = varargin{2};
    else
        error('please supply the name of a transformation definition in the second parameter');
    end
    if nargin >= 3
        modelNameOut = varargin{3};
    else
        error('please supply the name of an output model in the third parameter');
    end
    
    runModel = str2func(modelNameIn);
    modelIn = runModel();
    runTransDef = str2func(transDefName);
    transDef = runTransDef();
     
    GenSSIDir = fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples'));

    model = modelIn;
    model.sym.p = transDef.sym.p;
    
    X = transpose(modelIn.sym.x);
    XDOT = transpose(modelIn.sym.xdot);
    X0 = transpose(modelIn.sym.x0);
    G = transpose(modelIn.sym.g);
    Y = transpose(modelIn.sym.y);
    P = transpose(modelIn.sym.p);
    if isfield(transDef.sym,'stateSubs')
        stateSubs = transDef.sym.stateSubs;
    else
        stateSubs = [];
    end
    if isfield(transDef.sym,'parSubs')
        parSubs = transDef.sym.parSubs;
    else
        parSubs = [];
    end
    T = transDef.sym.Transformation;
    C = transDef.sym.Constraint;
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
    
    XDOTnew = simplify(jacobian(T,X)*subs(XDOT,X,Tinv));
    Ynew = simplify(subs(Y,X,Tinv));
    Gnew = simplify(subs(G,X,Tinv));
    X0new = simplify(subs(T,X,X0));
    
% Support of character vectors that are not valid variable names or define
% a number will be removed in a future release
    Xnew = sym(strrep(char(Xnew),'Xnew_',''));
    XDOTnew = sym(strrep(char(XDOTnew),'Xnew_',''));
    Ynew = sym(strrep(char(Ynew),'Xnew_',''));
    Gnew = sym(strrep(char(Gnew),'Xnew_',''));
    X0new = sym(strrep(char(X0new),'Xnew_',''));
%     for ind = 1:length(Xnew)
%         Xnew(ind) = sym(strrep(char(Xnew(ind)),'Xnew_',''));
%     end
%     for ind = 1:length(XDOTnew)
%         XDOTnew(ind) = sym(strrep(char(XDOTnew(ind)),'Xnew_',''));
%     end
%     for ind = 1:length(Ynew)
%         Ynew(ind) = sym(strrep(char(Ynew(ind)),'Xnew_',''));
%     end
%     for ind = 1:length(Gnew)
%         Gnew(ind) = sym(strrep(char(Gnew(ind)),'Xnew_',''));
%     end
%     for ind = 1:length(X0new)
%         X0new(ind) = sym(strrep(char(X0new(ind)),'Xnew_',''));
%     end
    
    if isempty(stateSubs)
    else
        Xnew = subs(Xnew,stateSubs(:,1),stateSubs(:,2));
        XDOTnew = subs(XDOTnew,stateSubs(:,1),stateSubs(:,2));
        Ynew = subs(Ynew,stateSubs(:,1),stateSubs(:,2));
        Gnew = subs(Gnew,stateSubs(:,1),stateSubs(:,2));
        X0new= subs(X0new,stateSubs(:,1),stateSubs(:,2));        
    end
    
    if isempty(parSubs)
        XDOTnew = expand(XDOTnew);
        for i = 1:length(P)
            for j = 1:length(P)
                XDOTnew = subs(XDOTnew,P(i)*P(j),sym([char(P(i)),'t',char(P(j))]));
                XDOTnew = subs(XDOTnew,P(i)/P(j),sym([char(P(i)),'d',char(P(j))]));
            end
        end
        XDOTnew = simplify(XDOTnew);   
        Ynew = expand(Ynew);
        for i = 1:length(P)
            for j = 1:length(P)
                Ynew = subs(Ynew,P(i)*P(j),sym([char(P(i)),'t',char(P(j))]));
                Ynew = subs(Ynew,P(i)/P(j),sym([char(P(i)),'d',char(P(j))]));
            end
        end
        Ynew = simplify(Ynew);
        Gnew = expand(Gnew);
        for i = 1:length(P)
            for j = 1:length(P)
                Gnew = subs(Gnew,P(i)*P(j),sym([char(P(i)),'t',char(P(j))]));
                Gnew = subs(Gnew,P(i)/P(j),sym([char(P(i)),'d',char(P(j))]));
            end
        end
        Gnew = simplify(Gnew);
        X0new = expand(X0new);
        for i = 1:length(P)
            for j = 1:length(P)
                X0new = subs(X0new,P(i)*P(j),sym([char(P(i)),'t',char(P(j))]));
                X0new = subs(X0new,P(i)/P(j),sym([char(P(i)),'d',char(P(j))]));
            end
        end
        X0new = simplify(X0new);     
    else
        XDOTnew = expand(simplify(subs(XDOTnew,parSubs(:,1),parSubs(:,2))));
        Ynew = expand(simplify(subs(Ynew,parSubs(:,1),parSubs(:,2))));
        Gnew = expand(simplify(subs(Gnew,parSubs(:,1),parSubs(:,2))));
        X0new= expand(simplify(subs(X0new,parSubs(:,1),parSubs(:,2))));
    end
    
    model.sym.x = transpose(Xnew);
    model.sym.xdot = transpose(XDOTnew);
    model.sym.x0 = transpose(X0new);
    model.sym.g = transpose(Gnew);
    model.sym.y = transpose(Ynew);
    genssiStructToSource(model,modelNameOut);
end

