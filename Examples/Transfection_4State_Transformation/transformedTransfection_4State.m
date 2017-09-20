function model = transformedTransfection_4State()
	% Symbolic variables
	syms mRNA_div_mRNA0 GFP enz_div_mRNA0
	syms d1 d2_times_mRNA0 d3 b kTL_times_mRNA0 enz0_div_mRNA0

	% Parameters
	model.sym.p = [d1;d2_times_mRNA0;d3;b;kTL_times_mRNA0;enz0_div_mRNA0];

	% State variables
	model.sym.x = [mRNA_div_mRNA0;GFP;enz_div_mRNA0];

	% Control vectors (g)
	model.sym.g = [];

	% Autonomous dynamics (f)
	model.sym.xdot = [-mRNA_div_mRNA0*(d1 + d2_times_mRNA0*enz_div_mRNA0)
                      kTL_times_mRNA0*mRNA_div_mRNA0 - GFP*b
                      d3*enz0_div_mRNA0 - d3*enz_div_mRNA0 - d2_times_mRNA0*enz_div_mRNA0*mRNA_div_mRNA0];

	% Initial conditions
	model.sym.x0 = [1;0;enz0_div_mRNA0];

	% Observables
	model.sym.y = [GFP];
end