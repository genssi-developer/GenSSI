Name = 'Pharmacokinetics';
copyfile(fullfile('..',Name,[Name,'.m']),[Name,'.m']);
genssiToPolynomial('Pharmacokinetics','PharmacokineticsPoly');
genssiMain('PharmacokineticsPoly',3);