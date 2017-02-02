function genssiStructToSource(model)
    % genSsiStructToSource converts a model definition (struct) to a
    %  source format (Matlab function file) ans saves the results in the
    %  examples directory.
    %
    % Parameters:
    %  model: model definition (struct)
    %  
    % Return values:
    %  void
    %
    GenSSIDir = fileparts(mfilename('fullpath'));
    fileName = fullfile(GenSSIDir,'Examples',[model.Name,'.m']);
    if exist(fileName,'file')
        delete(fileName);
    end
    fileID = fopen(fileName,'w');
    fprintf(fileID,['function model = ' model.Name '()\n']);
    strSyms = 'syms';
    for iStr = 1:length(model.X)
        strSyms = [strSyms ' ' char(model.X(iStr))];
    end
    fprintf(fileID,['\t' strSyms '\n']);
    strSyms = 'syms';
    if isfield(model,'P')
        for iStr = 1:length(model.P)
            strSyms = [strSyms ' ' char(model.P(iStr))];
        end
    else
        for iStr = 1:length(model.Par)
            strSyms = [strSyms ' ' char(model.Par(iStr))];
        end
    end
    fprintf(fileID,['\t' strSyms '\n']);
    fprintf(fileID,['\t' 'model.Name = ''' model.Name ''';\n']);
    fprintf(fileID,['\t' 'model.Nder = ' num2str(model.Nder) ';\n']);
    strMat = '\tmodel.X = [';
    if ~isempty(model.X)
        strMat = [strMat char(model.X(1))];
    end
    if length(model.X)>1
        for iStr = 2:length(model.X)
            strMat = [strMat ',' char(model.X(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    fprintf(fileID,['\t' 'model.Neq = ' num2str(model.Neq) ';\n']);      
    if isnumeric(model.G)
        strMat = ['\tmodel.G = [' num2str(model.G) '];\n'];
    else
        strMat = '\tmodel.G = [';
        if ~isempty(model.G)
            for iRow = 1:size(model.G,1)
                if iRow>1
                    strMat = [strMat ';'];
                end
                for iCol = 1:size(model.G,2)
                    if iCol>1
                        strMat = [strMat ','];
                    end
                    strMat = [strMat char(model.G(iRow,iCol))];
                end
            end
        end
        strMat = [strMat '];\n'];
    end
    fprintf(fileID,strMat);
    fprintf(fileID,['\t' 'model.Noc = ' num2str(model.Noc) ';\n']);
    strMat = '\tmodel.P = [';
    if isfield(model,'P')
        if ~isempty(model.Par)
            strMat = [strMat char(model.Par(1))];
        end
        if length(model.Par)>1
            for iStr = 2:length(model.Par)
                strMat = [strMat ',' char(model.Par(iStr))];
            end
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    strMat = '\tmodel.Par = [';
    if ~isempty(model.Par)
        strMat = [strMat char(model.Par(1))];
    end
    if length(model.Par)>1
        for iStr = 2:length(model.Par)
            strMat = [strMat ',' char(model.Par(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    fprintf(fileID,['\t' 'model.Npar = ' num2str(model.Npar) ';\n']);     
    strMat = '\tmodel.IC = [';
    if ~isempty(model.IC)
        strMat = [strMat char(sym(model.IC(1)))];
    end
    if length(model.IC)>1
        for iStr = 2:length(model.IC)
            strMat = [strMat ',' char(sym(model.IC(iStr)))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    strMat = '\tmodel.H = [';
    if ~isempty(model.H)
        strMat = [strMat char(model.H(1))];
    end
    if length(model.H)>1
        for iStr = 2:length(model.H)
            strMat = [strMat ',' char(model.H(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    fprintf(fileID,['\t' 'model.Nobs = ' num2str(model.Nobs) ';\n']);             
    strMat = '\tmodel.F = [';
    if ~isempty(model.F)
        strMat = [strMat char(model.F(1))];
    end
    if length(model.F)>1
        for iStr = 2:length(model.F)
            strMat = [strMat ',' char(model.F(iStr))];
        end
    end
    strMat = [strMat '];\n'];
    fprintf(fileID,strMat);
    fprintf(fileID,'end');
    fclose(fileID);
end

