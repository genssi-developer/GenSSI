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
    GenSSIDir=fileparts(mfilename('fullpath'));
    addpath(fullfile(GenSSIDir,'Examples'));
    runModel = str2func(modelNameIn);
    modelIn=runModel();
    [model.sym.x,model.sym.xdot,model.sym.x0] = genssiPolySys(transpose(modelIn.sym.x),transpose(modelIn.sym.xdot),transpose(modelIn.sym.x0));
    model.sym.x = transpose(model.sym.x);
    model.sym.xdot = transpose(model.sym.xdot);
    model.sym.x0 = transpose(model.sym.x0);
    model.sym.u = sym(zeros(1,length(model.sym.x)));
    model.sym.y = model.sym.x;
    model.sym.p = modelIn.sym.p;
    genssiStructToSource(model,modelNameOut);
end
