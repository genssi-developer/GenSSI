function options = genssiMain(modelName,Nder,Par)
    % genssiMain is the main function of GenSSI. It reads a model and 
    %  calls all other functions necessary for analyzing the model.
    %
    % Parameters:
    %  modelName: the name of the model to be analyzed (a string)
    %  Nder: number of Lie derivatives
    %  Par: vector of parameters to be considered
    %
    % Return values:
    %  options: struct containing options
    %
    if ~exist('modelName','var')
        error('please supply the name of a model in the first parameter');
    end
    runModel = str2func(modelName);
    model = runModel();
    model.sym.Name = modelName;
    options.verbose=true; % maximum (verbose) information in results file
    options.noRank=false; % no rank calculation (for speed with loss)
    options.closeFigure=true; % closes figures
    GenSSIDir=fileparts(mfilename('fullpath'));
    resultsDir=fullfile(GenSSIDir,'Results');
    runNumber=1;
    subfolder=strcat('run',num2str(runNumber));
    options.problem_folder_path=fullfile(resultsDir,modelName,subfolder);
    runSearch=true;
    while (runSearch)
        if exist(options.problem_folder_path,'dir')
            runNumber=runNumber+1;
            subfolder=strcat('run',num2str(runNumber));
            options.problem_folder_path=fullfile(resultsDir,model.sym.Name,subfolder);
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
    model.sym.Neq = length(model.sym.x);
    if ~isfield(model.sym,'u')
        model.sym.u = [];
    end
%     model.sym.G=sym(zeros(1,model.sym.Neq)); % required even if Noc=0
    model.sym.G=sym(zeros(max(size(model.sym.u,1),1),model.sym.Neq)); % required even if Noc=0
    if isfield(model.sym,'u')
%         for iC = 1:length(model.sym.u)
%             model.sym.G(iC) = model.sym.u(iC);
%         end
%         model.sym.Noc=length(model.sym.u);
        for iCrow = 1:size(model.sym.u,1)
%             model.sym.G(iC,:) = model.sym.u(iC,:);
            for iCcol = 1:size(model.sym.u,2)
                model.sym.G(iCrow,iCcol) = model.sym.u(iCrow,iCcol);
            end
        end
        model.sym.Noc=size(model.sym.u,2);
    else
        model.sym.Noc=0;
    end
    if iscolumn(model.sym.G)
        model.sym.G = transpose(model.sym.G);
    end
    if iscolumn(model.sym.y)
        model.sym.y = transpose(model.sym.y);
    end
    model.sym.Nobs = length(model.sym.y);
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
