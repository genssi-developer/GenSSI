function varargout = convert2PolySys(varargin)

x = varargin{1};
dx = varargin{2};
x0 = varargin{3};

user_defined = 0;
if nargin == 4
    if ~isempty(varargin{4})
        inv_xi  = varargin{4};
        user_defined = 1;
    end
end

% Automatic construction of inv_xi
if ~user_defined
    % Determine nominators and denominators of summands
    children_dx = children(dx);
    
    % Determine set of unique denominators
    inv_xi = sym([]);
    for i = 1:length(dx)
        if(length(dx)==1)
            for j = 1:length(children_dx)
                [tilde,D] = numden(children_dx(j));
                D = factor(D);
                inv_xi(end+1:end+length(D),1) = transpose(D);
            end
        else
            for j = 1:length(children_dx{i})
                [tilde,D] = numden(children_dx{i}(j));
                D = factor(D);
                inv_xi(end+1:end+length(D),1) = transpose(D);
            end
        end
    end
    inv_xi = unique(inv_xi(~double(floor(inv_xi)-inv_xi == 0)));
end

% Construction of xi vector for substitution
xi = sym('xi',[length(inv_xi),1]);

% Determine derivatives and initial conditions
dx = subs(dx,inv_xi,1./xi);
dxi = subs(jacobian(1./expand(inv_xi),x),expand(inv_xi),1./xi)*dx;
xi0 = subs(1./inv_xi,x,x0);

% Construct polynomial system
% (Note that z0 is in general not polynomial.)
z = [x;xi];
dz = [dx;dxi];
z0 = [x0;xi0];

% Check success of symbolic representation
[N,D] = numden(dz);
% if min(double(floor(D)-D == 0)) == 0
%     error('Rewriting of equation as polynomial equation failed.');
% else
    varargout{1} = z;
    varargout{2} = dz;
    varargout{3} = z0;
% end
