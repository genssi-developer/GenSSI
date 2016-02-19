function [matrixOut,keepBoolean,keepIndex]=genssiRemoveZeroColumns(matrixIn)
    % genssiRemoveZeroColumns removes zero columns from a matrix
    %
    % Parameters:
    %  matrixIn: input (matrix)
    %
    % Return values:
    %  matrixOut: output (matrix)
    %  keepBoolean: boolean vector of indices kept (array)
    %  keepIndex: vector of indices keept (array)
    %  
    keepBoolean=any(matrixIn~=0,1);
    matrixOut=matrixIn(:,keepBoolean);
    keepIndex=find(keepBoolean)';
end

