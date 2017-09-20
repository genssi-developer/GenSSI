function [z,fz,gz,z0,yz,xi,inv_xi] = genssiPolySys(x,f,g,x0,y)
    % genssiPolySys converts a model to polynomial form.
    %  [z,fz,gz,z0,yz,xi,inv_xi] = genssiPolySys(x,f,g,x0,y)
    %
    % Parameters:
    %  x: the state variables of the input model (a vector, nx x 1)
    %  f: the vector field of the autonomous system of the input model (a vector, nx x 1)
    %  g: the control matrix of the input model (a matrix, nx x nu)
    %  x0: the initial conditions of the input model (a vector, nx x 1)
    %  y: the output variables of the input model (a vector, ny x 1)
    %
    % Return values:
    %  z: the state variables of the transformed model (a vector, nz x 1)
    %  fz: the vector field of the autonomous system of the transformed model (a vector, nz x 1)
    %  gz: the control matrix of the transformed model (a matrix, nz x nu)
    %  z0: the initial conditions of the transformed model (a vector, nz x 1)
    %  yz: the output variables of the transformed model (a vector, ny x 1)
    %  xi: the set of denominators
    %  inv_xi: the set of unique denominators
    
    user_defined = 0;
    if nargin == 6
        if ~isempty(varargin{6})
            inv_xi  = varargin{6};
            user_defined = 1;
        end
    end

    % Automatic construction of inv_xi
    if ~user_defined
        % Determine nominators and denominators of summands
        all_children = children([f;g(:)]);

        % Determine set of unique denominators
        inv_xi = sym([]);
        for i = 1:size(all_children,1)
            if size(all_children,1)<=1
                for j = 1:length(all_children(i,:))
                    [tilde,D] = numden(all_children(i,j));
                    D = factor(D);
                    inv_xi(end+1:end+length(D),1) = transpose(D);
                end

            else
                for j = 1:length(all_children{i})
                    [tilde,D] = numden(all_children{i}(j));
                    D = factor(D);
                    inv_xi(end+1:end+length(D),1) = transpose(D);
                end
            end
        end
        inv_xi = unique(inv_xi(~double(floor(inv_xi)-inv_xi == 0)));
    end

    % Construction of xi vector for substitution
    % (Note: xi corresponds to the set of denominators)
    xi = sym('xi',[length(inv_xi),1]);

    % Determine transformed vector field and control matrix for x as well as
    % transformed output
    f_tf = subs(f,inv_xi,1./xi);
    if ~isempty(g)
        g_tf = subs(g,inv_xi,1./xi);
    else
        g_tf = [];
    end
    y_tf = subs(y,inv_xi,1./xi);
    
    % Determine vector field, control matrix and initial conditions for xi
    fxi = subs(jacobian(1./expand(inv_xi),x),expand(inv_xi),1./xi)*f_tf;
    if ~isempty(g)
        gxi = subs(jacobian(1./expand(inv_xi),x),expand(inv_xi),1./xi)*g_tf;
    else
        gxi = [];
    end
    xi0 = subs(1./inv_xi,x,x0);

    % Assemble polynomial system
    % (Note that z0 is in general not polynomial.)
    z = [x;xi];
    fz = [f_tf;fxi];
    gz = [g_tf;gxi];
    z0 = [x0;xi0];
    yz = y_tf;

    % Check success of symbolic representation
    [~,Df] = numden(fz);
    if ~isempty(g)
        [~,Dg] = numden(gz);
    else
        Dg = 1;
    end
    if min([isinf(1./(Df-1));isinf(1./(Dg(:)-1))]) == 0
        warning('Transformation to polynomial systems seems to have failed. Please check the results.');
    end
end