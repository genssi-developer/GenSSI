function str = genssiGetSymChar(str)
    % genssiGetSymChar converts a char into an other char which can be 
    % used as name of a symbolic variable. Therefore, matheamtical
    % operatores ('+', '-', '*', '/' and '^') are replaced by strings.
    %
    % Parameters:
    %  str: a char   
    %
    % Return values:
    %  str: a char    
    %  

    str = strrep(str,'/','_div_');
    str = strrep(str,'*','_times_');
    str = strrep(str,'+','_plus_');
    str = strrep(str,'-','_minus_');
    str = strrep(str,'^','_pow_');
end