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
    fh=figure(figNum);
    [tabX,tabY]=size(tabMat);
    if tabX~=1
        tabMat=-tabMat;
    end
    imagesc(double(tabMat));
    if tabX==1||tabY==1
        colormap(gray(1));
    else
        colormap(gray(2));
    end
    % The next 4 lines are for Matlab R2008a.
    ticklabels=char(paramDisplay(1));
    for iParam=2:size(paramDisplay,2)
        ticklabels= char(ticklabels, char(paramDisplay(iParam)));
    end
    % The next 1 line is for Matlab 20015b.
%     ticklabels=arrayfun(@char,paramDisplay,'UniformOutput',false);
    numIter=figNum-1;
    set(gca,'XTick',1:1:size(paramDisplay,2),'XTickLabel',ticklabels);
    if tabX < 6
        set(gca,'YTick',1:1:tabX);
    end
    switch figNum
        case 1
            title('Identifiability tableau');
        case 2
            title('First order reduced Identifiability tableau');
        case 3
            title('Second order reduced identifiability tableau');
        case 4
            title(['The reduced identifiability tableau of order ',num2str(numIter)]);
        otherwise
            title(['The reduced identifiability tableau of order ',num2str(numIter)]);
    end
    figName = ['Figure' num2str(figNum) '.fig'];
    fileName=fullfile(options.problem_folder_path,figName);
    saveas(figure(figNum),fileName);
    close(fh);
    clear('fh')
end

