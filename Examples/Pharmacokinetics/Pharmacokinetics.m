function model = Pharmacokinetics()
    % Pharmacokinetics provides the GenSSI implementation of the model
    % of the pharmacokinetics of glucose-oxidase introduced by
    % 
    %    Demignot, S. and Domurado, D. (1987). Effect of prosthetic 
    %    sugar groups on the pharmacokinetics of glucose-oxidase, 
    %    Drug. Des. Deliv., 1, 333-348.

    % Symbolic variables
    syms x1 x2 x3 x4
    syms a1 a2 b1 b2 ka kc vm c0 g

    % Parameters
    model.sym.p = [a1,a2,b1,b2,ka,kc,vm,c0,g];

    % State variables
    model.sym.x = [x1,x2,x3,x4];

    % Control vectors (g)
    model.sym.g = [];

    % Autonomous dynamics (f)
    model.sym.xdot=[a1*(x2-x1)-ka*vm*x1/(kc*ka+kc*x3+ka*x1),...
                    a2*(x1-x2),...
                    b1*(x4-x3)-kc*vm*x3/(kc*ka+kc*x3+ka*x1),...
                    b2*(x3-x4)];

    % Initial conditions
    model.sym.x0=[c0,0,g*c0,0];

    % Observables
    model.sym.y = [x1,x2,x3];
end

