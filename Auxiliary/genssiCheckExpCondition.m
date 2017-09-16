function expCond = genssiCheckExpCondition(model,expCond)
    % genssiCheckExpCondition checks the consistency of a GenSSI 
    % experiment condition for a given model.
    %
    % Parameters:
    %  model: GenSSI model
    %  expCond: GenSSI experiment condition
    %
    % Return values:
    %  expCond: GenSSI experiment condition

    % Check model
    model = genssiCheckModel(model);
    
    % Check dimensionality of control matrix
    if isfield(expCond.sym,'u')
        if size(expCond.sym.u,1) ~= size(model.sym.g,2)
            error('Please provide an input matrix with as many rows as there are controls.');
        end
    else
        expCond.sym.u = [];
    end

    % Check dimensionality of initial conditions matrix
    if isfield(expCond.sym,'x0')
        if size(expCond.sym.x0,1) ~= size(model.sym.x,1)
            error('Please provide a matrix of initial conditions with as many rows as there are state variables.');
        end
    else
        expCond.sym.x0 = [];
    end

    % Check consistency of initial conditions matrix and control matrix
    if ~isempty(expCond.sym.u) && ~isempty(expCond.sym.x0)
        if (size(expCond.sym.u,2)>=2) && (size(expCond.sym.x0,2)>=2)
            if size(expCond.sym.u,2) ~= size(expCond.sym.x0,2)
                error(['Please provide provide matrices of initial conditions '...
                       'and controls which have either the same number of '...
                       'column. Alternatively, initial conditions are controls '...
                       'can have only one column.'])
            end
        end
        % Duplicate controls to match initial conditions
        if (size(expCond.sym.u,2)==1) && (size(expCond.sym.x0,2)>=2)
            expCond.sym.u = repmat(expCond.sym.u,1,size(expCond.sym.x0,2));
        end
        % Duplicate initial conditions to match controls
        if (size(expCond.sym.u,2)>=2) && (size(expCond.sym.x0,2)==1)
            expCond.sym.x0 = repmat(expCond.sym.x0,1,size(expCond.sym.u,2));
        end
    else
        expCond.sym.x0 = [];
    end
end
