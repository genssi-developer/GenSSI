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
    GenSSIDir = fileparts(mfilename('fullpath'));
    fileName = fullfile(GenSSIDir,'Examples',[modelName,'.m']);
    if exist(fileName,'file')
        delete(fileName);
    end
    fileID = fopen(fileName,'w');
    fprintf(fileID,['function model = ' modelName '()\n']);
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
    if isnumeric(model.sym.u)
        strMat = ['\tmodel.sym.u = [' num2str(model.sym.u) '];\n'];
    else
        strMat = '\tmodel.sym.u = [';
        if ~isempty(model.sym.u)
            for iRow = 1:size(model.sym.u,1)
                if iRow>1
                    strMat = [strMat ';'];
                end
                for iCol = 1:size(model.sym.u,2)
                    if iCol>1
                        strMat = [strMat ','];
                    end
                    strMat = [strMat char(model.sym.u(iRow,iCol))];
                end
            end
        end
        strMat = [strMat '];\n'];
    end
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
        strMat = [strMat char(sym(model.sym.x0(1)))];
    end
    if length(model.sym.x0)>1
        for iStr = 2:length(model.sym.x0)
            strMat = [strMat ',' char(sym(model.sym.x0(iStr)))];
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

