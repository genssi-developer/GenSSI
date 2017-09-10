Name = 'M2_1_Y1';
copyfile(fullfile('..',Name,[Name,'.m']),[Name,'.m']);
genssiTransformation('M2_1_Y1','M2_1_tDef','M2_2');
% in the model M2_2, manually change (E0*d3)/m0 to E0dm0*m3
% then run genssiMain
% genssiMain('M2_2',5);