% function options = GenSSI_generating_series(modelName,fileFormat)
function varargout = genssiMain(varargin)
    % genssiMain is the main function of GenSSI. It reads a model and 
    %  calls all other functions necessary for analyzing the model.
    %
    % Parameters:
    %  varargin: generic input arguments
    %  modelName: the name of the model to be analyzed (a string)
    %  fileFormat: the format of the model file
    %   'model': (default) if the model is a function file (e.g.
    %    Goodwinn.m)
    %   'mat': if the model is a Matlab file (e.g. Goodwin.mat)
    %
    % Return values:
    %  varargout: generic output arguments
    %  options: struct containing options
    %
    if nargin >= 1
        modelName = varargin{1};
    else
        error('please supply the name of a model in the first parameter');
    end
    if nargin >= 2
        fileFormat = varargin{2};
    else
        fileFormat = 'function';
    end
    if strcmp(fileFormat,'mat')
        load(modelName,'model');
    else
        runModel = str2func(modelName);
        model = runModel();
    end
    options.verbose=true;
    GenSSIDir=fileparts(mfilename('fullpath'));
    resultsDir=fullfile(GenSSIDir,'Results');
    runNumber=1;
    subfolder=strcat('run',num2str(runNumber));
    options.problem_folder_path=fullfile(resultsDir,model.Name,subfolder);
    runSearch=true;
    while (runSearch)
        if exist(options.problem_folder_path,'dir')
            runNumber=runNumber+1;
            subfolder=strcat('run',num2str(runNumber));
            options.problem_folder_path=fullfile(resultsDir,model.Name,subfolder);
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
    varargout{1} = options;
end
