function options = genssiReportInputs(model,options)   
    % genssiReportInputs reports inputs, i.e. model definition.
    %
    % Parameters:
    %  model: model definition (struct)
    %  options: options (struct)
    %
    % Return values:
    %  options: options (struct)
    %  
    fprintf(1,'**********************************************************************************\n');
    fprintf(1,'*                                                                                                      \n');
    fprintf(1,'* GENERATING SERIES approach for Structural Identifiability Analysis   \n');
    fprintf(1,'*                                                                                                      \n');
    fprintf(1,'* Oana Chis, Julio R. Banga and Eva Balsa-Canto                                \n');
    fprintf(1,'*  BioProcess Engineering Group, IIM-CSIC, Vigo-Spain                        \n');
    fprintf(1,'*  contact: [chisoana,julio,ebalsa]@iim.csic.es                                     \n');
    fprintf(1,'*                                                                                                        \n');
    fprintf(1,'**********************************************************************************\n\n');
    if options.verbose
        strDisp=['Matlab version=',version];
        disp(strDisp);
        strDisp=['Computer=',computer];
        disp(strDisp);
        disp('options:');
        disp(options);
    end
    fprintf(1,'STRUCTURAL IDENTIFIABILITY ANALYSIS FOR: %s Model\n ', model.sym.Name);
    fprintf(1,'\n\n');
    fprintf(1,'***************\n');
    fprintf(1,'* INPUT DATA \n');
    fprintf(1,'***************\n\n');

    fprintf(1,'-----> Maximum number of derivatives for the analysis: %u\n',model.sym.Nder);
    fprintf(1,'-----> Dynamic model:\n');
    for i=1:length(model.sym.x)
        fprintf(1,'\tA%u=',i);
        disp(model.sym.xdot(i));
    end

    fprintf(1,'-----> Control variables:\n');
    for i=1:model.sym.Noc
        fprintf(1,'\tG%u=',i);
        if size(model.sym.G,1)>1
            disp(sym(transpose(model.sym.G(:,i))));
        else
            disp(sym(model.sym.G(i)));
        end
    end

    fprintf(1,'-----> Observables:\n');
    for i=1:length(model.sym.y)
        fprintf(1,'\tH%u=',i);
        disp(model.sym.y(i));
    end

    fprintf(1,'-----> Initial conditions:\n\tIC=');
    disp(sym(model.sym.x0));
    
    fprintf(1,'-----> Parameters to be considered in the analysis:\n\tPar=');
    disp(model.sym.Par);
    fprintf(1,'\n\n\n');
end



