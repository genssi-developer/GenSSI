Name = 'Arabidopsis';
copyfile(fullfile('..',Name,[Name,'.m']),[Name,'.m']);
genssiToPolynomial('Arabidopsis','ArabidopsisPoly');
genssiMain('ArabidopsisPoly',7); 