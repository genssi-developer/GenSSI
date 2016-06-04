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
    fprintf(1,'STRUCTURAL IDENTIFIABILITY ANALYSIS FOR: %s Model\n ', model.Name);
    fprintf(1,'\n\n');
    fprintf(1,'***************\n');
    fprintf(1,'* INPUT DATA \n');
    fprintf(1,'***************\n\n');

    fprintf(1,'-----> Maximum number of derivatives for the analysis: %u\n',model.Nder);
    fprintf(1,'-----> Dynamic model:\n');
    for i=1:model.Neq
        fprintf(1,'\tA%u=',i);
        disp(model.F(i));
    end

    fprintf(1,'-----> Control variables:\n');
    for i=1:model.Noc
        fprintf(1,'\tG%u=',i);
        disp(sym(model.G(i,:)));
    end

    fprintf(1,'-----> Observables:\n');
    for i=1:model.Nobs
        fprintf(1,'\tH%u=',i);
        disp(model.H(i));
    end

    fprintf(1,'-----> Initial conditions:\n\t');
    disp(sym(model.IC));
    
    fprintf(1,'-----> Parameters to be considered in the analysis:\n\t');
    disp(model.Par);
    fprintf(1,'\n\n\n');
end



