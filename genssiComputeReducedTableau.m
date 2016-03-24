function [options,results,RJacParam01,ECC,rParam]=genssiComputeReducedTableau...
    (model,results,VectorLieDerivatives,JacParam,options)
    % genssiComputeReducedTableau computes reduced tableaus of the
    % jacobian by eliminating rows and columns where solutions to 
    % relationships can found or excluded.
    % 
    % Parameters:
    %  model: model definition (struct)
    %  results: results of compute tableau (symbolic matrix)
    %  VectorLieDerivatives: vector of Lie derivatives (symbolic array)
    %  JacParam: jacobian with respect to parameters (symbolic matrix)
    %  options: options (struct)
    %
    % Return values:
    %  options: options (struct)
    %  results: results of compute tableau (symbolic matrix)
    %  RJacParam01: reduced tableau (binary matrix)
    %  ECC: equations (symbolic matrix)
    %  rParam: reduced list of parameters (symbolic array)
    %  
    fprintf(1,'\n\n************************************************\n');
    fprintf(1,'-> COMPUTE REDUCED IDENTIFIABILITY TABLEAUS\n');
    fprintf(1,'************************************************\n');
    rParam=model.Par; % reduced parameter list starts as model parameter list
    [JacParamx,tilde]=size(JacParam);
    RJacParam=[];
    keepIndex=[];
    rankOld=0;
    for i=1:JacParamx
        if verLessThan('matlab','7.7')
            rankNew=double(rank([RJacParam; JacParam(i,:)]));
        else
            rankNew=double(feval(symengine,'linalg::rank',[RJacParam; JacParam(i,:)]));
        end
        if rankNew > rankOld
            RJacParam=[RJacParam; JacParam(i,:)];
            if verLessThan('matlab','7.7')
                rankOld=double(rank(RJacParam));
            else
                rankOld=double(feval(symengine,'linalg::rank',RJacParam));
            end
            keepIndex=[keepIndex i];
        end   
    end
    
    % Lie Derivatives that can be used to compute parameters
    def_useful_Lie_index=results.useful_Lie_index(keepIndex);
    UI=length(def_useful_Lie_index);
    Equations=sym(zeros(1,UI));
    Equations(:)=VectorLieDerivatives(def_useful_Lie_index(:));
    NrEq=length(Equations);
    Const=sym(zeros(NrEq,1)); % preallocation for R2008a
    % Const=sym('c',[NrEq,1]); % preallocation for R2015b
    for j=1:NrEq
        Const(j)=sym(strcat('c',num2str(j)));
    end

    fprintf(1,'\n\n*****************************************************\n');
    fprintf(1,'-> THE RELATIONS NEEDED FOR COMPUTING THE PARAMETERS\n');
    fprintf(1,'*****************************************************\n\n');

    ECC=Equations.'-Const;
    Equ=Equations.';
    disp(sym(Equ)-sym(Const));
    %Construct the reduced 0-1 tableau 
    RJacParam01=double(RJacParam~=0);
        
    RJac_Reduced=RJacParam01;
    [RJac_Reduced_x,tilde]=size(RJac_Reduced);
    if RJac_Reduced_x==1
        [RJac_Reduced,keepB,tilde]=genssiRemoveZeroElementsR(RJac_Reduced);
    else
        [RJac_Reduced,keepB,tilde]=genssiRemoveZeroColumns(RJac_Reduced);
    end
    Non_identifiable_param = rParam(~keepB);
    index_non_id = find(~keepB);
    rParam = rParam(keepB);
    
    %Represents graphically the 0-1 reduced identifiability tableau
    genssiTableauImage(02,RJac_Reduced,...
        rParam,options);
    RJacParam01=RJac_Reduced;
    results.Non_identifiable_param=Non_identifiable_param;
end
