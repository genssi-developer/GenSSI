function options = genssiReportInputs(model,options)   
    % genssiReportInputs reports inputs, i.e. model definition.
    %
    % Parameters:
    %  model: model definition (struct)
    %  options: options (struct)
    %
    % Return values:
    %  options: options (struct)

    % General information
    fprintf(1,'**********************************************************************\n');
    fprintf(1,'* GENERATING SERIES Approach for Structural Identifiability Analysis *\n');
    fprintf(1,'**********************************************************************\n\n');
    if options.verbose
        disp(['Model name:     ' model.sym.Name]);
        disp(['Matlab version: ' version]);
        disp(['Computer:       ' computer]);
        disp('Options:'); disp(options);
    end
    
    % Model properties
    fprintf(1,'**************\n');
    fprintf(1,'* INPUT DATA *\n');
    fprintf(1,'**************\n\n');
    
    fprintf(1,'Maximum number of derivatives for the analysis: %u\n\n',model.sym.Nder);
    
    fprintf(1,'State variables (x):\n');
    disp(model.sym.x);
    
    fprintf(1,'Vector field for autonomous dynamics (f):\n');
    if isempty(model.sym.xdot)
        fprintf(1,' []\n\n')
    else
        disp(model.sym.xdot);
    end

    fprintf(1,'Control vector (g):\n');
    if isempty(model.sym.g)
        fprintf(1,' []\n\n')
    else
        disp(model.sym.g);
    end

    fprintf(1,'Initial conditions (x0):\n');
    disp(model.sym.x0);
    
    fprintf(1,'Observables (y):\n');
    disp(model.sym.y);

    fprintf(1,'Parameters considered for structural identifiability analysis:\n');
    disp(model.sym.Par);
end



