function amiciStructToSource(model)
    % amiciStructToSource converts a model definition (struct) to a
    %  source format (MATLAB function file) and saves the results in the
    %  examples directory.
    %
    % Parameters:
    %  model: model definition (struct)
    %
    % Return values:
    %  void
    %  
    GenSSIDir = fileparts(mfilename('fullpath'));
    fileName = fullfile(GenSSIDir,'Examples','AMICI',[model.Name,'.m']);
    if exist(fileName,'file')
        delete(fileName);
    end
    fileID = fopen(fileName,'w');
    fprintf(fileID,['function model = ' model.Name '()\n']);
    strSyms = 'syms';
    for iStr = 1:length(model.sym.x)
        strSyms = [strSyms ' ' char(model.sym.x(iStr))];
    end
    fprintf(fileID,['\t' strSyms '\n']);
    strSyms = 'syms';
    for iStr = 1:length(model.sym.p)
        strSyms = [strSyms ' ' char(model.sym.p(iStr))];
    end
    fprintf(fileID,['\t' strSyms '\n']);
    
    strMat = '\tmodel.sym.x = [';
    if ~isempty(model.sym.x)
        strMat = [strMat char(model.sym.x(1))];
    end
    if length(model.sym.x)>1
        for iStr = 2:length(model.sym.x)
            strMat = [strMat ',' char(model.sym.x(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    
    strMat = '\tmodel.sym.y = [';
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
        
    strMat = '\tmodel.sym.p = [';
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
    
    strMat = '\tmodel.sym.x0 = [';
    if ~isempty(model.sym.x0)
        strMat = [strMat char(model.sym.x0(1))];
    end
    if length(model.sym.x0)>1
        for iStr = 2:length(model.sym.x0)
            strMat = [strMat ',' char(model.sym.x0(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    
    strMat = '\tmodel.sym.g = [';
    if ~isempty(model.sym.g)
        strMat = [strMat char(model.sym.g(1,:))];
    end
    if size(model.sym.g,1)>1
        for iStr = 2:size(model.sym.g,1)
            strMat = [strMat ',' char(model.sym.g(iStr,:))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    
    strMat = '\tmodel.sym.xdot = [';
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
    
    fprintf(fileID,'end');
    fclose(fileID);
end

