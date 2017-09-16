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
    modelIn = genssiTransposeModel(eval(modelNameIn));
    
    % Check consistency of model
    modelIn = genssiCheckModel(modelIn);
    
    % Transform to polynomial system
    [x,f,g,x0,y,xi,inv_xi] = genssiPolySys(modelIn.sym.x,...
                                           modelIn.sym.xdot,...
                                           modelIn.sym.g,...
                                           modelIn.sym.x0,...
                                           modelIn.sym.y);
                  
    % Transpose entries as genssiPolySys uses column vectors
    model.sym.p = modelIn.sym.p;
    model.sym.x = x;
    model.sym.xdot = f;
    model.sym.g = g;
    model.sym.x0 = x0;
    model.sym.y = y;
    if length(xi) >= 1
        model.sym.xi_name = transpose(xi);
        model.sym.xi = transpose(1./inv_xi);
    end
    model = genssiTransposeModel(model);

    
    % Writing transformed model to file
    genssiStructToSource(model,modelNameOut);
end
