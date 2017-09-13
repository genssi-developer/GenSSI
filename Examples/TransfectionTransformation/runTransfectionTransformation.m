Name = 'Transfection2';
copyfile(fullfile('..',Name,[Name,'.m']),[Name,'.m']);
genssiTransformation('Transfection2','TransformationDefinition','TransfectionTransformation');
% in the model M2_2, manually change (d3*enz0)/mRNA0 to enz0dmRNA0*d3
% then run genssiMain
% genssiMain('TransfectionTransformation',5);