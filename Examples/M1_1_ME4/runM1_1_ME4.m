Name = 'M1_1_U2';
copyfile(fullfile('..',Name,[Name,'.m']),[Name,'.m']);
genssiMultiExperiment('M1_1_U2','M1_1_eDef4','M1_1_ME4');
genssiMain('M1_1_ME4',3);
