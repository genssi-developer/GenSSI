function genssiToAmici (modelNameIn,modelNameOut)
    % GenSsiToAmici converts a GenSSI model to AMICI model format and
    %  saves the results in the examples directory.
    %
    % Parameters:
    %  modelNameIn: name of the GenSSI model (string)
    %  modelNameOut: name of the AMICI model (string)
    %
    % Return values:
    %  void
    %  
    isSaveAmiciModel=true;
    model.Name=modelNameOut;
    GenSSIDir=fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples','AMICI'));
    runModel = str2func(modelNameIn);
    modelG=runModel();
    model.atol = 1e-8;
    model.rtol = 1e-8;
    model.maxsteps = 1e4;
    model.sym.x = modelG.X;
    model.sym.u = sym(modelG.G);
    model.sym.u = model.sym.u(1:modelG.Noc);
    model.sym.xdot = modelG.F;
    model.sym.p = modelG.Par;
    model.sym.x0 = sym(modelG.IC);
    model.sym.y = modelG.H;
    save(fullfile(GenSSIDir,'Examples','AMICI',[model.Name '.mat']),'model');
    if isSaveAmiciModel
        amiciStructToSource(model);
    end
end