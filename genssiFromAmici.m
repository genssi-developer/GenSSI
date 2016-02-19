function genssiFromAmici (modelNameIn,modelNameOut)
    % GenSsiFromAmici converts an AMICI model to a GenSSI model and puts
    %  the results into the examples directory.
    %
    % Parameters:
    %  modelNameIn: name of the AMICI model (string)
    %  modelNameOut: name of the GenSSI model (string)
    %  
    % Return values:
    %  void
    %
    isSaveGenSSIModel=true;
    model.Name=modelNameOut;
    GenSSIDir=fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples','AMICI'));
    runModel = str2func(modelNameIn);
    AModel=runModel();
    model.Nder=4;                                % Number of derivatives  
    model.X=AModel.sym.x;
    model.Neq=length(model.X);
    model.G=zeros(1,model.Neq); % required even if Noc=0
    if isfield(AModel.sym,'u')
        for iC = 1:length(AModel.sym.u)
            model.G(iC) = Amodel.sym.u(iC);
        end
        model.Noc=length(AModel.sym.u);
    else
        model.Noc=0;
    end
    model.Par=AModel.sym.p;
    model.Npar=length(model.Par);
    model.IC=AModel.sym.x0';
    model.H=AModel.sym.y;
    model.Nobs=length(model.H);
    model.F=AModel.sym.xdot;
    options.verbose=true;
    save(fullfile(GenSSIDir,'Examples',[model.Name '.mat']),'model');
    if isSaveGenSSIModel
        genSsiStructToSource(model);
    end
end
