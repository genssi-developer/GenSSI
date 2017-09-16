function model = genssiCheckModel(model)
    % genssiCheckModel checks the consistency of a GenSSI model. It
    % compares the dimensions of different entries and transforms them if
    % possible.
    %
    % Parameters:
    %  model: GenSSI model
    %
    % Return values:
    %  model: GenSSI model

    % Correct dimensionality of parameter vectors
    if isrow(model.sym.p)
        model.sym.p = transpose(model.sym.p);
    end
    if isfield(model.sym,'Par')
        if isrow(model.sym.Par)
            model.sym.Par = transpose(model.sym.Par);
        end
    end
    
    % Correct dimensionality of state vector
    if isrow(model.sym.x)
        model.sym.x = transpose(model.sym.x);
    end
    
    % Correct dimensionality of output vector
    if isrow(model.sym.y)
        model.sym.y = transpose(model.sym.y);
    end
    
    % Check and correct dimensionality of autonomous dynamics (f)
    if isrow(model.sym.xdot)
        model.sym.xdot = transpose(model.sym.xdot);
    end
    if size(model.sym.xdot,1) ~= size(model.sym.x,1)
        error(['Please provide model in which the number of rows in the '...
               'autonomous dynamics vector (f) is equal to the number of '...
               'the state variables.']);
    end
    
    % Check existance and dimensionality of control vector matrix (g)
    if isfield(model.sym,'g')
        if ~isempty(model.sym.g)
            if size(model.sym.g,1) ~= size(model.sym.x,1)
                error(['Please provide model in which the number of rows '...
                       'in control vector matrix is equal to the number '...
                       'of state variables.']);
            end
        end
    else
        model.sym.g = [];
    end

end
