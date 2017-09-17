function genssiToPolynomial (modelNameIn,modelNameOut)
    % genssiToPolynomial converts a GenSSI model to polynomial form.
    % It reads the input model, converts to polynomial form, and creates
    % an output model as a Matlab function modelNameOut.m and as a
    % Matlab file modelnameOut.m.
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
    model = eval(modelNameIn);
    
    % Check consistency of model
    model = genssiCheckModel(model);
    
    % Transform to polynomial system
    [model.sym.x,model.sym.xdot,model.sym.g,model.sym.x0,model.sym.y,model.sym.xi,model.sym.inv_xi]...
        = genssiPolySys(model.sym.x,model.sym.xdot,model.sym.g,model.sym.x0,model.sym.y);

    % Writing transformed model to file
    genssiStructToSource(model,modelNameOut);
end
