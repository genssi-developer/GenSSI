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
    
    % Check inputs
    if nargin >= 1
        modelNameIn = varargin{1};
    else
        error('Please supply the name of an input model in the first parameter.');
    end
    if nargin >= 2
        transDefName = varargin{2};
    else
        error('Please supply the name of a transformation definition in the second parameter.');
    end
    if nargin >= 3
        modelNameOut = varargin{3};
    else
        error('Please supply the name of an output model in the third parameter.');
    end
    
    % Load model and transformation
    modelIn = eval(modelNameIn);
    transDef = eval(transDefName);
    
    % Check model
    modelIn = genssiCheckModel(modelIn);
    
    % Assigne model properties
    X = transpose(modelIn.sym.x);
    F = transpose(modelIn.sym.xdot);
    X0 = transpose(modelIn.sym.x0);
    G = transpose(modelIn.sym.g);
    Y = transpose(modelIn.sym.y);
    P = transpose(modelIn.sym.p);
    
    % Assign and check state transformation
    if isfield(transDef.sym,'state')
        if ~isfield(transDef.sym.state,'formula')
            transDef.sym.state.formula = X;
        end
        if ~isfield(transDef.sym.state,'name')
            for i = 1:length(transDef.sym.state.formula)
                transDef.sym.state.name{i,1} = genssiGetSymChar(char(transDef.sym.state.formula(i)));
            end
        else
            if isrow(transDef.sym.state.name)
                transDef.sym.state.name = transpose(transDef.sym.state.name);
            end
        end
    else
        transDef.sym.state.formula = X;
        for i = 1:length(X)
            transDef.sym.state.name{i} = char(X(i));
        end
    end
    if length(transDef.sym.state.formula) ~= length(transDef.sym.state.name)
        error(['Please ensure that for the state variables the ' ...
               'number of formulas is equal to the number of names.'])
    end
    T = transDef.sym.state.formula;
    
    % Assign and check state constraints
    if isfield(transDef.sym,'constraint')
        C = transDef.sym.constraint;
    else
        C = [];
    end
    if length(transDef.sym.constraint)+length(transDef.sym.state.formula) ...
            ~= length(modelIn.sym.x)
        error(['Please ensure that the number of constraints plus the ' ...
               'number of new state is at least equal to the number of ' ...
               'state in the input model. If this is not the case, the ' ...
               'inverse of the transformation does not exist.'])
    end
    
    % Assign and check of parameter substitution
    if isfield(transDef.sym,'parameter')
        if isfield(transDef.sym.parameter,'formula')
            if isrow(transDef.sym.state.name)
                transDef.sym.state.name = transpose(transDef.sym.state.name);
            end
            if ~isfield(transDef.sym.parameter,'name')
                for i = 1:length(transDef.sym.parameter.formula)
                    transDef.sym.parameter.name{i,1} = genssiGetSymChar(char(transDef.sym.parameter.formula(i)));
                end
            end
        end
        if length(transDef.sym.parameter.formula) ~= length(transDef.sym.parameter.name)
            error(['Please ensure that for the parameters the ' ...
                   'number of formulas is equal to the number of names.'])
        end
    end
    
    % Definition of new state vector
    % (Note: We include 'Xnew_' to avoid that state variables in the input
    % model have the same names as state variables in the output model.
    % This is important for the construction of the inverse transformtion
    % and is removed afterwards.)
    Xnew = sym(transDef.sym.state.name);
    Xnew_mod = sym(zeros(size(T)));
    for i = 1:length(T)
        Xnew_mod(i,1) = sym(['Xnew_' transDef.sym.state.name{i}]);
    end

    % Construct inverse transformation based on definition of new states
    % and constraints
    zeroC = sym(zeros(size(C)));
    sol = solve([Xnew_mod;zeroC] == [T;C],X);
    Tinv = sym(zeros(size(X)));
    for i = 1:length(X)
        Tinv(i,1) = eval(['sol.' char(X(i))]);
    end
    
    % Construction of transformed model
    Fnew = simplify(jacobian(T,X)*subs(F,X,Tinv));
    Ynew = simplify(subs(Y,X,Tinv));
    Gnew = simplify(subs(G,X,Tinv));
    X0new = simplify(subs(T,X,X0));
    
    % Check state transformation
    if isempty(intersect(symvar([Fnew(:),Ynew(:),Gnew(:),X0new(:)]),modelIn.sym.x))
        disp('State transformation appears to work properly.');
    else
        error(['The state transformation failed. Possible reasons are: '...
               '(i) The definition of the transformed state does not allow ' ...
               'for a correct transformation; or (2) The symbolic inversion ' ...
               'of the transformation failed (because it is to complex).']);
    end
    
    % Substitute new parameter
    Tinv = subs(Tinv,Xnew_mod,Xnew);
    Fnew = subs(Fnew,Xnew_mod,Xnew);
    Ynew = subs(Ynew,Xnew_mod,Xnew);
    Gnew = subs(Gnew,Xnew_mod,Xnew);
    X0new = subs(X0new,Xnew_mod,Xnew);

    % Substitution of parameters
    Pnew = P;
    if isfield(transDef.sym,'parameter')
        if isfield(transDef.sym.parameter,'formula')
            % Define symbolic variables for new parameters
            Pnew  = sym(transDef.sym.parameter.name);
            
            % Substitude parameters
            % (Note: We use here different variants to achieve a high
            % probability for a correct substitution.)
            Fnew  = subs(         Fnew  ,transDef.sym.parameter.formula,Pnew);
            Fnew  = subs(  expand(Fnew ),transDef.sym.parameter.formula,Pnew);
            Fnew  = subs(simplify(Fnew ),transDef.sym.parameter.formula,Pnew);
            Ynew  = subs(         Ynew  ,transDef.sym.parameter.formula,Pnew);
            Ynew  = subs(  expand(Ynew ),transDef.sym.parameter.formula,Pnew);
            Ynew  = subs(simplify(Ynew ),transDef.sym.parameter.formula,Pnew);
            Gnew  = subs(         Gnew  ,transDef.sym.parameter.formula,Pnew);
            Gnew  = subs(  expand(Gnew ),transDef.sym.parameter.formula,Pnew);
            Gnew  = subs(simplify(Gnew ),transDef.sym.parameter.formula,Pnew);
            X0new = subs(         X0new ,transDef.sym.parameter.formula,Pnew);
            X0new = subs(  expand(X0new),transDef.sym.parameter.formula,Pnew);
            X0new = subs(simplify(X0new),transDef.sym.parameter.formula,Pnew);
            
            % Check whether parameter vector is sufficient
            % (1) Determine symbolic variables in the input model which are
            % not part of x or p. These could for instance be constants. We
            % would expect that also after the transformatio, these
            % parameters do not have to be contained in xnew and pnew.
            unexpVar = setdiff(symvar([F(:),Y(:),G(:),X0(:)]),symvar([X(:),P(:)]));
            % (2) Determine symbolic variables in the transformed model 
            % which are not part of xnew or pnew.
            unexpVarNew = setdiff(symvar([Fnew(:),Ynew(:),Gnew(:),X0new(:)]),symvar([Xnew(:),Pnew(:)]));
            % (3) Check whether whether unexpVarNew is contained in 
            % unexpVar, if not, complete pnew
            unexpVarDiff = setdiff(unexpVarNew,unexpVar);
            if isempty(unexpVarDiff)
                disp('Parameter substitution appears to work properly.');
            else
                warning(['The provided parameter substitution rules do not '...
                         'seem to be sufficient and are extended. Please '...
                         'check the results.'])
                Pnew = [Pnew;transpose(unexpVarDiff)];
            end
        end
    end
    
    % Assemble transformed model
    model.sym.p = transpose(Pnew);
    model.sym.x = transpose(Xnew);
    model.sym.xdot = transpose(Fnew);
    model.sym.x0 = transpose(X0new);
    model.sym.g = transpose(Gnew);
    model.sym.y = transpose(Ynew);
    
    % Generate candidates for parameterisation
    disp('Candidates for a potential reparameterization:');
    cand = genssiGetCandForTransformation(model)
    
    % Write to model to file
    genssiStructToSource(model,modelNameOut);
end

