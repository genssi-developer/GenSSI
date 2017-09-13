Name = 'Transfection1';
copyfile(fullfile('..',Name,[Name,'.m']),[Name,'.m']);
genssiMultiExperiment('Transfection1','MultiExDefinition4','TransfectionMultiEx');
genssiMain('TransfectionMultiEx',3);
