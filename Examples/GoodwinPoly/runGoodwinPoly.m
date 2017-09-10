Name = 'Goodwin';
copyfile(fullfile('..',Name,[Name,'.m']),[Name,'.m']);
genssiToPolynomial('Goodwin','GoodwinPoly');
genssiMain('GoodwinPoly',4);