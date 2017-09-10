Name = 'Degradation';
copyfile(fullfile('..',Name,[Name,'.m']),[Name,'.m']);
genssiToPolynomial('Degradation','DegradationPoly');
genssiMain('DegradationPoly',4);