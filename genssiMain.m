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
    runModel = str2func(modelName);
    model = runModel();
    model.sym.Name = modelName; % needed for genssiReportInputs
    % set default options
    options.verbose=true; % maximum (verbose) information in results file 
    options.noRank=false; % no rank calculation (for speed with loss)
    options.closeFigure=true; % closes figures
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
    end
    GenSSIDir=fileparts(mfilename('fullpath'));
    resultsDir=fullfile(GenSSIDir,'Examples');
    runNumber=1;
    subfolder=strcat('run',num2str(runNumber));
    options.problem_folder_path=fullfile(resultsDir,modelName,subfolder);
    runSearch=true;
    while (runSearch)
        if exist(options.problem_folder_path,'dir')
            runNumber=runNumber+1;
            subfolder=strcat('run',num2str(runNumber));
            options.problem_folder_path=fullfile(resultsDir,modelName,subfolder);
        else
            runSearch=false;
        end
    end
    mkdir(options.problem_folder_path);
    diaryFile=fullfile(options.problem_folder_path,'model_information.txt');
    diary(diaryFile);
    fid = fopen(diaryFile,'w');    
    frewind(fid);
    if options.verbose
        tocTotal=0;
        tic;
    end
    if exist('Nder','var')
        model.sym.Nder = Nder;
    else
        model.sym.Nder = 4;
    end
    if exist('Par','var')
        model.sym.Par = Par;
    else
        if isfield(model.sym,'p')
            model.sym.Par = model.sym.p;
        else
            error(['please supply a vector of paramaters to be ',...
                   'considered in the third parameter ',...
                   '(or a full list of parameters in model.sym.p)']);
        end
    end
    if iscolumn(model.sym.Par)
        model.sym.Par = transpose(model.sym.Par);
    end    
    if iscolumn(model.sym.x)
        model.sym.x = transpose(model.sym.x);
    end
    if isfield(model.sym,'g')
        if (size(model.sym.g,1) > 0) &&...
           (size(model.sym.g,2) ~= size(model.sym.x,2))
            error('length of rows in control matrix must equal number of states');
        end
    else
        model.sym.g = [];
    end
    if iscolumn(model.sym.y)
        model.sym.y = transpose(model.sym.y);
    end
    if iscolumn(model.sym.xdot)
        model.sym.xdot = transpose(model.sym.xdot);
    end     
    options=genssiReportInputs(model,options);
    if options.verbose
        disp(['Report inputs elapsed time: ' num2str(toc)]);
        tocTotal=tocTotal+toc;
        tic;
    end
    [options,VectorLieDerivatives]=genssiComputeLieDerivatives(model,options);
    if options.verbose
        disp(['Compute Lie derivatives elapsed time: ' num2str(toc)]);
        tocTotal=tocTotal+toc;
        tic;
    end
    [options,results,JacParam]=genssiComputeTableau...
        (model,VectorLieDerivatives,options);
    if options.verbose
        disp(['Compute tableau elapsed time: ' num2str(toc)]);
        tocTotal=tocTotal+toc;
        tic;
    end
    [options,results,RJacParam01,ECC,rParam]=genssiComputeReducedTableau...
        (model,results,VectorLieDerivatives,JacParam,options);
    clear('VectorLieDerivatives','JacParam');
    if options.verbose
        disp(['Compute reduced tableau  elapsed time: ' num2str(toc)]);
        tocTotal=tocTotal+toc;
        tic;
    end
    [options,results]=genssiOrderTableau(model,results,...
        RJacParam01,ECC,rParam,options);
    clear('JacParam01','RJacParam01','ECC');
    if options.verbose
        disp(['Order tableau elapsed time: ' num2str(toc)]);
        tocTotal=tocTotal+toc;
        tic;
    end
    options=genssiReportResults(model,results,options);
    if options.verbose
        disp(['Report results elapsed time: ' num2str(toc)]);
        tocTotal=tocTotal+toc;
        disp(['Total elapsed time: ' num2str(tocTotal)]);
    end
    fclose(fid);
    diary off
    fprintf(1,'\n\n');
    fprintf(1,'\n --->THE RESULTS ARE STORED IN: \n'); 
    disp(options.problem_folder_path)
    fprintf(1,'\n\n');
%     varargout{1} = options;
end
