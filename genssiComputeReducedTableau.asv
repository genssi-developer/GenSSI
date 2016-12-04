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
    sizeJacParam=size(JacParam);
    RJacParam=[];
    keepIndex=[];
    rankOld=0;
    for i=1:sizeJacParam(1)
        if verLessThan('matlab','7.7') || size([RJacParam; JacParam(i,:)],2)==1
            rankNew=double(rank([RJacParam; JacParam(i,:)]));
        else
            rankNew=double(feval(symengine,'linalg::rank',[RJacParam; JacParam(i,:)]));
        end
        if rankNew > rankOld
            RJacParam=[RJacParam; JacParam(i,:)];
            if verLessThan('matlab','7.7') || size(RJacParam,2)==1
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
    sizeRJacParam=size(RJacParam);
    RJacParam01=zeros(sizeRJacParam);
    if verLessThan('matlab','8') || sizeRJacParam(2)==1 %%8 is R2012b
        RJacParam01=double(RJacParam~=0);
    else
        RJacParam01(find(RJacParam))=1;
    end
    
    if sizeRJacParam(1)==1
        [RJacParam01,keepB,tilde]=genssiRemoveZeroElementsR(RJacParam01);
    else
        [RJacParam01,keepB,tilde]=genssiRemoveZeroColumns(RJacParam01);
    end
    Non_identifiable_param = rParam(~keepB);
    index_non_id = find(~keepB);
    rParam = rParam(keepB);
    
    %Represents graphically the 0-1 reduced identifiability tableau
    genssiTableauImage(02,RJacParam01,rParam,options);
    results.Non_identifiable_param=Non_identifiable_param;
end
