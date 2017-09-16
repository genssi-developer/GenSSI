function genssiAskForConfirmation(expectedRuntime)
    % genssiAskForConfirmation informs the user about the expected runtime
    % for an example and asks the user to confirm that the example is
    % executed.
    %
    % Parameters:
    %  expectedRuntime: expected runtime in seconds
    %
    % Return values:
    %  void

    % Check that installation was performed
    if ~exist('genssiUserSpecificDefaults.m')
        error('Please run genssiInstall.m before performing your first analysis.');
    end

    % Check that installation was performed
    if genssiUserSpecificDefaults('feedbackRequired')
        prompt = ['\nThe structural identifiability analysis will take roughly ' num2str(expectedRuntime) ' seconds. \n' ...
          'Please confirm that you want to run. (yes/no)  \n\n'];
        if ~strcmp(input(prompt,'s'),'yes')
            error('Calculation discontinued by user')
        end
    end
end 