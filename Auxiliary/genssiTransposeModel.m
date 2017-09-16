function model = genssiTransposeModel(model)

    model.sym.p = transpose(model.sym.p);
    model.sym.x = transpose(model.sym.x);
    model.sym.xdot = transpose(model.sym.xdot);
    model.sym.x0 = transpose(model.sym.x0);
    model.sym.g = transpose(model.sym.g);
    model.sym.y = transpose(model.sym.y);

end