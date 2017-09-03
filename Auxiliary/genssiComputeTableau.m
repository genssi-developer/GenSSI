function [options,results,JacParam]=genssiComputeTableau...
    (model,VectorLieDerivatives,options)
    % genssiComputeTableau computes the tableau based on the jacobian of
    %  the Lie derivatives.
    %
    % Parameters:
    %  model: model definition (struct)
    %  VectorLieDerivatives: vector of Lie derivatives (symbolic array)
    %  options: options (struct)
    %
    % Return values:
    %  options: options (struct)
    %  results: results of calculations (struct)
    %  JacParam: jacobian of the Lie derivatives with respect to the
    %   parameters (symbolic matrix)
    %  
    fprintf(1,'\n\n***************************************\n');
    fprintf(1,'-> COMPUTE IDENTIFIABILITY TABLEAU\n');
    fprintf(1,'***************************************\n');

%     nLieDerivatives=length(VectorLieDerivatives);

    %Compute the Jacobian of each non-zero row with respect to the parameters    
    JacParam=jacobian(VectorLieDerivatives, model.sym.Par);

    %Eliminate zero rows of the Jacobian 
    [JacParam,tilde,useful_Lie_index]=genssiRemoveZeroRows(JacParam);
    results.useful_Lie_index=useful_Lie_index;

    %Compute the reduced Jacobian
    sizeJacParam=size(JacParam);
    if verLessThan('matlab','7.7') || sizeJacParam(2)==1
        RankJacParam=double(rank(JacParam));
    else
        RankJacParam=double(feval(symengine,'linalg::rank',JacParam));
    end
    %RD=double(RankE);
    fprintf(1,'\n ----->The rank of the full Jacobian matrix is %u \n', RankJacParam); 
    if RankJacParam==size(model.sym.Par,2)
        fprintf(1,'\n ---->THE RANK OF THE FULL JACOBIAN IS COMPLETE, THUS AT LEAST LOCAL IDENTIFIABILITY IS GUARANTEED.\n');
    else
        fprintf(1,'\n ----->THE FULL JACOBIAN IS RANK DEFICIENT, YOU MAY CONSIDER ADDING NEW DERIVATIVES, %u \n', double(model.sym.Nder+1));
    end

    %Construct the 0-1 tableau
    JacParam01=zeros(sizeJacParam);
    if verLessThan('matlab','R2012b') || sizeJacParam(2)==1
        JacParam01=double(JacParam~=0);
    else
        JacParam01(find(JacParam))=1;
    end
    genssiTableauImage(01,JacParam01,model.sym.Par,options);
end


