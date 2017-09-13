function model = TransfectionTransformation()
	syms mRNAnew GFPnew enznew
	syms d1 d2tmRNA0 d3 b kTLtmRNA0 enz0dmRNA0
	model.sym.x = [mRNAnew,GFPnew,enznew];
	model.sym.g = [];
	model.sym.p = [d1,d2tmRNA0,d3,b,kTLtmRNA0,enz0dmRNA0];
	model.sym.x0 = [1,0,enz0dmRNA0];
	model.sym.y = [GFPnew];
	model.sym.xdot = [- d1*mRNAnew - d2tmRNA0*enznew*mRNAnew,kTLtmRNA0*mRNAnew - GFPnew*b,enz0dmRNA0*d3 - d2tmRNA0*enznew*mRNAnew - d3*enznew];
end