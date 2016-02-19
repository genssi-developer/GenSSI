function genssiToPolynomial (modelNameIn,modelNameOut)
    % genssiToPolynomial converts a GenSSI model to polynomial form.
    % It reads the input model, converts to polynomial form, and creates
    % an output model as a Matlab function modelNameOut.m and as a
    % Matlab file modelnameOut.mat, both in the Examples folder.
    %
    % Parameters:
    %  modelNameIn: the name of the input model (a string)
    %  modelNameOut: the name of the output model (a string)
    %
    % Return values:
    %  void
    %  
    isSaveGenSSIModel=true;
    GenSSIDir=fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples'));
    runModel = str2func(modelNameIn);
    modelIn=runModel();
    model.Name=modelNameOut;
    [model.X,model.F,model.IC] = convert2PolySys(transpose(modelIn.X),transpose(modelIn.F),transpose(modelIn.IC));
    model.X = transpose(model.X);
    model.F = transpose(model.F);
    model.IC = transpose(model.IC);
    model.Nder=4;
    model.Neq = length(model.X);
    model.G = sym(zeros(1,length(model.X)));
    model.Noc = 0;
    model.H = model.X;
    model.Nobs = length(model.H);
    model.Par = modelIn.Par;
    model.Npar = length(model.Par);
    save(fullfile(GenSSIDir,'Examples',[model.Name '.mat']),'model');
    if isSaveGenSSIModel
        genSsiStructToSource(model);
    end
end
