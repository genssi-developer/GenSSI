function options = genssiMain(modelName,Nder,Par,optionsIn)
    % genssiMain is the main function of GenSSI. It reads a model and 
    %  calls all other functions necessary for analyzing the model.
    %
    % Parameters:
    %  modelName: the name of the model to be analyzed (a string)
    %  Nder: number of Lie derivatives
    %  Par: vector of parameters to be considered
    %  optionsIn: struct of options for analysis
    %
    % Return values:
    %  options: struct containing options
    %
    if ~exist('modelName','var')
        error('please supply the name of a model in the first parameter');
    end
    model = eval(modelName);
    model.sym.Name = modelName; % needed for genssiReportInputs

    % Set default number of derivatives
    if exist('Nder','var')
        if ~isempty(Nder)
            model.sym.Nder = Nder;
        else
            model.sym.Nder = 4;
        end
    else
        model.sym.Nder = 4;
    end

    % Set and assign default options
    options.verbose = true; % maximum (verbose) information in results file 
    options.noRank  = false; % rank calculation (increases computational time)
    options.closeFigure = true; % closes figures
    options.store = true; % write results to file
    if exist ('optionsIn','var')
        if isfield(optionsIn,'verbose')
            options.verbose = optionsIn.verbose;   
        end
        if isfield(optionsIn,'noRank')
            options.noRank = optionsIn.noRank;   
        end
        if isfield(optionsIn,'closeFigure')
            options.closeFigure = optionsIn.closeFigure;   
        end        
        if isfield(optionsIn,'store')
            options.store = optionsIn.store;   
        end        
    end
    
    % Setup results folder and initialize reporting (if results are stored) 
    if options.store
        GenSSIDir = fileparts(mfilename('fullpath'));
        resultsDir = fullfile(GenSSIDir,'Examples');
        runNumber = 1;
        subfolder = strcat('run',num2str(runNumber));
        options.problem_folder_path=fullfile(resultsDir,modelName,subfolder);
        runSearch=true;
        while (runSearch)
            if exist(options.problem_folder_path,'dir')
                runNumber = runNumber+1;
                subfolder = strcat('run',num2str(runNumber));
                options.problem_folder_path=fullfile(resultsDir,modelName,subfolder);
            else
                runSearch=false;
            end
        end
        mkdir(options.problem_folder_path);
        diaryFile = fullfile(options.problem_folder_path,'model_information.txt');
        diary(diaryFile);
        fid = fopen(diaryFile,'w');    
        frewind(fid);
    end
    if options.verbose
        tocTotal=0;
        tic;
    end
        
    % Assign parameters with respect to which structural identifiability
    % analysis is performed
    if exist('Par','var')
        if ~isempty(Par)
            model.sym.Par = Par;
        end
    elseif isfield(model.sym,'p')
        model.sym.Par = model.sym.p;
    else
        error(['please supply a vector of paramaters to be ',...
               'considered in the third parameter ',...
               '(or a full list of parameters in model.sym.p)']);
    end
    
    % Check consistency of model
    model = genssiCheckModel(model);

    % Report inputs
    options = genssiReportInputs(model,options);
    if options.verbose
        disp(['Report inputs elapsed time: ' num2str(toc)]);
        tocTotal = tocTotal + toc; tic;
    end
    
    % Compute Lie derivatives
    [options,VectorLieDerivatives] = genssiComputeLieDerivatives(model,options);
    if options.verbose
        disp(['Compute Lie derivatives elapsed time: ' num2str(toc)]);
        tocTotal = tocTotal + toc; tic;
    end
    
    % Compute identifiability tableau
    [options,results,JacParam] = ...
        genssiComputeTableau(model,VectorLieDerivatives,options);
    if options.verbose
        disp(['Compute tableau elapsed time: ' num2str(toc)]);
        tocTotal = tocTotal + toc; tic;
    end
    
    % Compute reduced identifiability tableau
    [options,results,RJacParam01,ECC,rParam] = ...
        genssiComputeReducedTableau(model,results,VectorLieDerivatives,JacParam,options);
    clear('VectorLieDerivatives','JacParam');
    if options.verbose
        disp(['Compute reduced tableau  elapsed time: ' num2str(toc)]);
        tocTotal = tocTotal+toc; tic;
    end
    
    % Compute (reduced) identifiability tableau
    [options,results] = genssiOrderTableau(model,results,RJacParam01,ECC,rParam,options);
    clear('JacParam01','RJacParam01','ECC');
    if options.verbose
        disp(['Order tableau elapsed time: ' num2str(toc)]);
        tocTotal=tocTotal+toc;
        tic;
    end
    
    % Report results
    options = genssiReportResults(model,results,options);
    if options.verbose
        disp(['Report results elapsed time: ' num2str(toc)]);
        tocTotal=tocTotal+toc;
        disp(['Total elapsed time: ' num2str(tocTotal)]);
    end
    diary off
    if options.store
        fclose(fid);
        fprintf(1,'\n\n');
        fprintf(1,'\n ---> THE RESULTS ARE STORED IN: \n'); 
        disp(options.problem_folder_path)
        fprintf(1,'\n\n');
    end
end
