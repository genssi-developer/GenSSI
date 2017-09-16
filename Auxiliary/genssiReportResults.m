function options=genssiReportResults(model,results,options)
    % genssiReportResults reports the results of the analysis.
    %
    % Parameters:
    %  model: model definition (struct)
    %  results: results of previous steps (struct)
    %  options: options (struct)
    %
    % Return values:
    %  options: options (struct)

    fprintf(1,'***************************************\n');
    fprintf(1,'* RESULTS OF IDENTIFIABILITY ANALYSIS *\n');
    fprintf(1,'***************************************\n\n');

    % Assignment of parameter
    gloIdentPar = results.global_ident_par;
    locIdentPar = results.Param_local;
    nonIdentPar = results.Non_identifiable_param;

    % Report identifiability properties of model
    if (length(model.sym.Par)==length(gloIdentPar))&&(size(locIdentPar,2)==0)&&(length(nonIdentPar)==0)
        fprintf(1,'=> THE MODEL IS STRUCTURALLY GLOBALLY IDENTIFIABLE \n\n');
    end
    if (size(locIdentPar,2)~=0)&&(length(nonIdentPar)==0)
        fprintf(1,'=> THE MODEL IS STRUCTURALLY LOCALLY IDENTIFIABLE \n\n');
    end          
    if length(nonIdentPar)~=0       
        fprintf(1,'=> THE MODEL IS STRUCTURALLY NON-IDENTIFIABLE \n\n');
    end
    
    % Report of structurally globally identifiable parameters
    fprintf(1,'Structurally globally identifiable parameters: \n');     
    if size(gloIdentPar,2) == 0
        disp(' []'); disp(' ');
    else
        disp(gloIdentPar)
    end
    
    % Report of structurally locally identifiable parameters
    fprintf(1,'Structurally locally identifiable parameters: \n');
    if length(locIdentPar) == 0
        disp(' []'); disp(' ');
    else
        disp(locIdentPar)
    end
    
    % Report of structurally non-identifiable parameters
    fprintf(1,'Structurally non-identifiable parameters: \n');
    if length(nonIdentPar) == 0
        disp(' []'); disp(' ');
    else
        disp(nonIdentPar)
    end
end