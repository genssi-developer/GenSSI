function [vectorOut,keepBoolean,keepIndex]=genssiRemoveZeroElementsC(vectorIn)
    % genssiRemoveZeroElements removes zero columns from a row vecor
    %
    % Parameters:
    %  vectorIn: input (array)
    %
    % Return values:
    %  vectorOut: output (array)
    %  keepBoolean: boolean vector of indices kept (array)
    %  keepIndex: vector of indices kept (array)
    %  
    keepBoolean=any(vectorIn~=0,2);
    vectorOut=vectorIn(keepBoolean);
    keepIndex=find(keepBoolean)';
end

