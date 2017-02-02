function [matrixOut,keepBoolean,keepIndex]=genssiRemoveZeroRows(matrixIn)
    % genssiRemoveZeroRows removes zero rows from a matrix
    %
    % Parameters:
    %  matrixIn: input (matrix)
    %
    % Return values:
    %  matrixOut: output (matrix)
    %  keepBoolean: boolean vector of indices kept (array)
    %  keepIndex: vector of indices keept (array)
    %  
    keepBoolean=any(matrixIn~=0,2);
    matrixOut=matrixIn(keepBoolean,:);
    keepIndex=find(keepBoolean)';
end

