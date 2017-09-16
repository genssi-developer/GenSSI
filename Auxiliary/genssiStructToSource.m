function genssiStructToSource(model,modelName)
    % genSsiStructToSource converts a model definition (struct) to a
    %  source format (Matlab function file) and saves the results in the
    %  examples directory.
    %
    % Parameters:
    %  model: model definition (struct)
    %  modelName: model name
    %  
    % Return values:
    %  void
    %

    fileName = [modelName, '.m'];
    if exist(fileName,'file')
        delete(fileName);
    end
    fileID = fopen(fileName,'w');
    fprintf(fileID,['function model = ' modelName '()\n']);
    
    % Write symbolic variables
    strSyms = '\t%% Symbolic variables\n';
    strSyms = [strSyms '\t' 'syms'];
    for iStr = 1:length(model.sym.x)
        strSyms = [strSyms ' ' char(model.sym.x(iStr))];
    end
    fprintf(fileID,[strSyms '\n']);
    strSyms = ['\t' 'syms'];
    for iStr = 1:length(model.sym.p)
        strSyms = [strSyms ' ' char(model.sym.p(iStr))];
    end
    fprintf(fileID,[strSyms '\n']);
    
    % Write parameters
    strMat = '\n\t%% Parameters\n';    
    strMat = [strMat '\t' 'model.sym.p = ['];
    if ~isempty(model.sym.p)
        strMat = [strMat char(model.sym.p(1))];
    end
    if length(model.sym.p)>1
        for iStr = 2:length(model.sym.p)
            strMat = [strMat ',' char(model.sym.p(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);  
    
    % Write state variables
    strMat = '\n\t%% State variables\n';
    strMat = [strMat '\tmodel.sym.x = ['];
    strMat = [strMat char(model.sym.x(1))];
    if length(model.sym.x)>1
        for iStr = 2:length(model.sym.x)
            strMat = [strMat ',' char(model.sym.x(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);  
    
    % Write control vectors (g)
    strMat = '\n\t%% Control vectors (g)\n';    
    if isnumeric(model.sym.g)
        strMat = [strMat '\tmodel.sym.g = [' num2str(model.sym.g) '];\n'];
    else
        strMat = [strMat '\tmodel.sym.g = ['];
        if ~isempty(model.sym.g)
            for iRow = 1:size(model.sym.g,1)
                if iRow>1
                    strMat = [strMat ';'];
                end
                for iCol = 1:size(model.sym.g,2)
                    if iCol>1
                        strMat = [strMat ','];
                    end
                    strMat = [strMat char(model.sym.g(iRow,iCol))];
                end
            end
        end
        strMat = [strMat '];\n'];
    end
    fprintf(fileID,strMat);
    
    % Write autonomous dynamics (f)
    strMat = '\n\t%% Autonomous dynamics (f)\n';    
    strMat = [strMat '\tmodel.sym.xdot = ['];
    if ~isempty(model.sym.xdot)
        strMat = [strMat char(model.sym.xdot(1))];
    end
    if length(model.sym.xdot)>1
        for iStr = 2:length(model.sym.xdot)
            strMat = [strMat ',' char(model.sym.xdot(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    
    % Write initial conditions
    strMat = '\n\t%% Initial conditions\n';    
    strMat = [strMat '\tmodel.sym.x0 = ['];
    if ~isempty(model.sym.x0)
        strMat = [strMat char(sym(model.sym.x0(1)))];
    end
    if length(model.sym.x0)>1
        for iStr = 2:length(model.sym.x0)
            strMat = [strMat ',' char(sym(model.sym.x0(iStr)))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    
    % Write observables
    strMat = '\n\t%% Observables\n';    
    strMat = [strMat '\tmodel.sym.y = ['];
    if ~isempty(model.sym.y)
        strMat = [strMat char(model.sym.y(1))];
    end
    if length(model.sym.y)>1
        for iStr = 2:length(model.sym.y)
            strMat = [strMat ',' char(model.sym.y(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);   
    
    % Write meaning of state variables of extended model
    if isfield(model.sym,'xi_name') && isfield(model.sym,'xi')
        strMat = '\n\t%% Meaning of state variables of extended model \n';
        for iStr = 1:length(model.sym.xi_name)
            strMat = [strMat '\t%% ' char(model.sym.xi_name(iStr)) ' = ' char(model.sym.xi(iStr))];
        end
        strMat = [strMat '\n'];
        fprintf(fileID,strMat);
    end
        
    fprintf(fileID,'end');
    fclose(fileID);
end

