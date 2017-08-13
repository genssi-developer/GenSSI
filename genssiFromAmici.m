function genssiFromAmici (modelNameIn,modelNameOut)
    % genssiFromAmici converts an AMICI model in the examples/AMICI
    % directory to a GenSSI model and puts the results into the examples 
    % directory.
    %
    % Parameters:
    %  modelNameIn: name of the AMICI model (string)
    %  modelNameOut: name of the GenSSI model (string)
    %  
    % Return values:
    %  void
    %
    isSaveGenSSIModel=true;
    if ~exist('ModelNameOut','var')
        modelNameOut = modelNameIn;
    end
    model.Name=modelNameOut;
    GenSSIDir=fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples','AMICI'));
    runModel = str2func(modelNameIn);
    AModel=runModel();
    model.Nder=4;                                % Number of derivatives  
    model.X=AModel.sym.x;
    if iscolumn(model.X)
        model.X = transpose(model.X);
    end
    model.Neq=length(model.X);
    model.G=sym(zeros(1,model.Neq)); % required even if Noc=0
    if isfield(AModel.sym,'u')
        for iC = 1:length(AModel.sym.u)
            model.G(iC) = AModel.sym.u(iC);
        end
        model.Noc=length(AModel.sym.u);
    else
        model.Noc=0;
    end
    if iscolumn(model.G)
        model.G = transpose(model.G);
    end
    model.Par=AModel.sym.p;
    if iscolumn(model.Par)
        model.Par = transpose(model.Par);
    end
    model.Npar=length(model.Par);
    model.IC=AModel.sym.x0;
    if iscolumn(model.IC)
        model.IC = transpose(model.IC);
    end
    model.H=AModel.sym.y;
    if iscolumn(model.H)
        model.H = transpose(model.H);
    end
    model.Nobs=length(model.H);
    model.F=AModel.sym.xdot;
    if iscolumn(model.F)
        model.F = transpose(model.F);
    end
    options.verbose=true;
    save(fullfile(GenSSIDir,'Examples',[model.Name '.mat']),'model');
    if isSaveGenSSIModel
        genssiStructToSource(model);
    end
end
