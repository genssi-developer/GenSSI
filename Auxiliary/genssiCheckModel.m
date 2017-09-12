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
    %

    % Correct dimensionality of parameter vectors
    if ~isrow(model.sym.Par)
        model.sym.Par = transpose(model.sym.Par);
    end
    if ~isrow(model.sym.p)
        model.sym.p = transpose(model.sym.p);
    end
    
    % Correct dimensionality of state vector
    if ~isrow(model.sym.x)
        model.sym.x = transpose(model.sym.x);
    end
    
    % Correct dimensionality of output vector
    if ~isrow(model.sym.y)
        model.sym.y = transpose(model.sym.y);
    end
    
    % Check and correct dimensionality of autonomous dynamics (f)
    if ~isrow(model.sym.xdot)
        model.sym.xdot = transpose(model.sym.xdot);
    end
    if size(model.sym.xdot,2) ~= size(model.sym.x,2)
        error('number of columns in autonomous dynamics vector must equal number of state variables');
    end
    
    % Check existance and dimensionality of control vector matrix (g)
    if isfield(model.sym,'g')
        if ~isempty(model.sym.g)
            if size(model.sym.g,2) ~= size(model.sym.x,2)
                error('number of columns in control vector matrix must equal number of state variables');
            end
        end
    else
        model.sym.g = [];
    end

end
