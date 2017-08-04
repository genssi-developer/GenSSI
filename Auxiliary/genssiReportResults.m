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
    %  
    max_length_sol=max(results.length_sol);
    global_ident_par=results.global_ident_par;
    Param_local=results.Param_local;
    Non_identifiable_param=results.Non_identifiable_param;
    if (length(model.Par)==length(global_ident_par))&&(size(Param_local,2)==0)&&(size(Non_identifiable_param,2)==0)
        fprintf(1,'\n\n***************************************************************\n\n');
        fprintf(1,' -----> THE MODEL IS STRUCTURALLY GLOBALLY IDENTIFIABLE \n\n');
        fprintf(1,'***************************************************************\n\n');
        fprintf(1,'        The structurally globally identifiable parameters are: \n\n');
        %disp(model.Par);
        fprintf(1,'     \t[');
        for i=1:size(global_ident_par,2)
           fprintf(1,'      %s\t',char(global_ident_par(i)));
        end
        fprintf(1,']\n\n\n');
    end
    if (size(Param_local,2)~=0)&&(size(Non_identifiable_param,2)==0)
        fprintf(1,'\n\n***************************************************************\n\n');
        fprintf(1,' -----> THE MODEL IS STRUCTURALLY LOCALLY IDENTIFIABLE \n\n');
        fprintf(1,'***************************************************************\n\n');
        fprintf(1,'        The structurally globally identifiable parameters are: \n\n');     
        if size(global_ident_par,2) == 0
            fprintf(1,'         \tNone\n\n');  
        else
            fprintf(1,'     \t[');
            for i=1:size(global_ident_par,2)
                fprintf(1,'      %s\t',char(global_ident_par(i)));
            end
            fprintf(1,']\n\n\n');  
        end               
        fprintf(1,'        The structurally locally identifiable parameters are: \n\n');
        if size(Param_local,2) == 0
            fprintf(1,'         \tNone\n\n');    
        else
            fprintf(1,'     \t[');
            for i=1:size(Param_local,2)
                fprintf(1,'      %s\t',char(Param_local(i)));
            end
            fprintf(1,']\n\n\n');    
        end
    end          
    if size(Non_identifiable_param,2)~=0       
        fprintf(1,'\n\n***************************************************************\n\n');
        fprintf(1,' -----> THE MODEL IS STRUCTURALLY NON-IDENTIFIABLE \n\n');
        fprintf(1,'***************************************************************\n\n');    
        fprintf(1,'        The structurally globally identifiable parameters are: \n\n');     
        if size(global_ident_par,2) == 0
            fprintf(1,'         \tNone\n\n');  
        else
            fprintf(1,'     \t[');
            for i=1:size(global_ident_par,2)
                fprintf(1,'      %s\t',char(global_ident_par(i)));
            end
            fprintf(1,']\n\n\n');  
        end         
        fprintf(1,'        The structurally locally identifiable parameters are: \n\n');
        if size(Param_local,2) == 0
            fprintf(1,'         \tNone\n\n');    
        else
            fprintf(1,'     \t[');
            for i=1:size(Param_local,2)
                fprintf(1,'      %s\t',char(Param_local(i)));
            end
            fprintf(1,']\n\n\n');    
        end  
        fprintf(1,'        The structurally non-identifiable parameters are: \n\n');
        if size(Non_identifiable_param,2) == 0
            fprintf(1,'         \tNone\n\n');   
        else
            fprintf(1,'     \t[');
            for i=1:size(Non_identifiable_param,2)
                fprintf(1,'      %s\t',char(Non_identifiable_param(i)));
            end
            fprintf(1,']\n\n\n');
        end
    end
end