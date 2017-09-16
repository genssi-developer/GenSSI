function genssiTableauImage(figNum,tabMat,paramDisplay,options)
    % genssiTableauImage displays an identifiability tableau
    %
    % Parameters:
    %  figNum: figure number
    %  tabMat: matrix containing tableau
    %  paramDisplay: parameter vector
    %  options: options
    %
    % Return values:
    %  void
    %
    
    % Check if tabMat is non-empty
    if isempty(tabMat)
        return;
    end
    
    % Open figure
    fh = figure(figNum);
    
    % Plot tabMat entries 
    [tabX,tabY] = size(tabMat);
    if tabX ~= 1
        tabMat = -tabMat;
    end
    imagesc(double(tabMat));

    % Assign colormap
    if tabX==1 || tabY==1
        colormap(gray(1));
    else
        colormap(gray(2));
    end
    
    % Assign tick labels
    if verLessThan('matlab','8.6')
        % Code for Matlab R2008a:
        ticklabels = char(paramDisplay(1));
        for iParam = 2:length(paramDisplay)
            ticklabels = char(ticklabels, char(paramDisplay(iParam)));
        end
    else
        % Code for Matlab 20015b and newer:
        ticklabels = arrayfun(@char,paramDisplay,'UniformOutput',false);
    end
    set(gca,'XTick',1:1:length(paramDisplay),'XTickLabel',ticklabels);
    if tabX < 6
        set(gca,'YTick',1:1:tabX);
    end
    
    % Assign figure title
    switch figNum
        case 1
            title('Identifiability tableau');
        otherwise
            title(['Reduced identifiability tableau of order ',num2str(figNum-1)]);
    end
    
    % Store figures in subfolder
    if options.store
        figName  = ['Figure' num2str(figNum) '.fig'];
        fileName = fullfile(options.problem_folder_path,figName);
        saveas(figure(figNum),fileName);
    end
    
    % Close figures
    if options.closeFigure
        close(fh);
        clear('fh')
    end
end

