function cand = genssiGetCandForTransformation(model)
    % genssiGetCandForTransformation provides candidates for a reduced
    % parameterisation of a model
    %
    % Parameters:
    %  model: GenSSI model    
    %
    % Return values:
    %  cand: vector of candidates   
    %  
    
    % Concentrate elements of all functions
    expr = [model.sym.xdot(:)
            model.sym.g(:)
            model.sym.x0(:)
            model.sym.y(:)];

    % Determine nominators and denominators of summands
    % (Note: We add one to avoid the decomposition of products.)
    all_children = children(expand(expr)+1);

    % Determine 
    elements = sym([]);
    for i = 1:size(all_children,1)
        if size(all_children,1)<=1
            for j = 1:length(all_children(i,:))
    %             [N,D] = numden(all_children(i,j));
    %             N = factor(N);
    %             D = factor(D);
    %             cand(end+1:end+length(N)+length(D),1) = [transpose(N);transpose(D)];
                elements(end+1,1) = all_children(i,j);
            end
        else
            for j = 1:length(all_children{i})
    %             [N,D] = numden(all_children{i}(j));
    %             N = factor(N);
    %             D = factor(D);
    %             cand(end+1:end+length(N)+length(D),1) = [transpose(N);transpose(D)];
                elements(end+1,1) = all_children{i}(j);
            end
        end
    end
    % Reduce to unique set and remove constants
    elements = unique(elements(~double(floor(elements)-elements == 0)));

    % Elimination of states
    elements = setdiff(elements,model.sym.x);

    % Set state variables to one
    elements = subs(elements,model.sym.x,ones(size(model.sym.x)));

    % Initialize candidate vector
    cand = sym([]);

    % Search for individual parameters
    repeat = 1;
    while repeat
        repeat = 0;
        i = 1;
        while i <= length(elements)
            symvar_i = symvar(elements(i));
            if length(symvar_i) == 1
                elements(i) = [];
                repeat = 1;
                if ~any(ismember(cand,symvar_i))
                    cand(end+1,1) = symvar_i;
                end
            end
            i = i+1;
        end
    end

    % Replace individual parameters by one and reduce to unique set
    elements = unique(subs(elements,cand,ones(size(cand))));

    % Complement candidates list
    cand = [cand;elements];
end