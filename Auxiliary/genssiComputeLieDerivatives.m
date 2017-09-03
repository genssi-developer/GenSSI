function [options,VectorLieDerivatives]=genssiComputeLieDerivatives(model,options)
    % genssiComputeLieDerivatives computes Lie derivatives of the
    %  output functions (model.sym.y), the state vectors (model.sym.x), and the
    %  initial conditions (model.sym.x0) with respect to the equations
    %  (model.sym.xdot) and controls (model.sym.u)
    %
    % Parameters:
    %  model: model definition (struct)
    %  options: processing options (struct)
    %
    % Return values:
    %  options: processing options (struct)
    %  VectorLieDerivatives: a vector of all Lie derivatives
    %  
    fprintf(1,'*******************************\n');
    fprintf(1,'-> COMPUTE LIE DERIVATIVES\n');
    fprintf(1,'*******************************\n\n');
    vH=subs(model.sym.y,model.sym.x,model.sym.x0);
    %Compute vF and vG
    fprintf(1,'COMPUTING LIE DERIVATIVES OF ORDER 1\n');
    fprintf(1,'.................................................................\n');
    order = 1;
    rankVector = zeros(1,model.sym.Nder);
    jacTemp = transpose(jacobian(model.sym.y,model.sym.x));
    JacF = model.sym.xdot*jacTemp;
    vF=subs(JacF,model.sym.x,model.sym.x0);
    JacG = model.sym.G*jacTemp;
    vG=subs(JacG,model.sym.x,model.sym.x0);
    LDer = [vH;vF;vG];
    [rankFull,rankVector] = jacRank(LDer,rankVector,order,model,options);
    if rankFull
        LieDerivatives=[vH;vF;vG];
        VectorLieDerivatives=reshape(transpose(LieDerivatives),[1,numel(LieDerivatives)]);
        VectorLieDerivatives=genssiRemoveZeroElementsR(VectorLieDerivatives);
    else
        %%% CASE WITHOUT CONTROL
        if model.sym.Noc<1 
            Jac=JacF;
            for order = 2:model.sym.Nder
                disp(['COMPUTING LIE DERIVATIVES OF ORDER', ' ', num2str(order)])
                disp('   ')
                fprintf(1,'.................................................................\n');
                JacTemp = transpose(jacobian(reshape(JacF,[numel(JacF),1]),model.sym.x));
                JacF = reshape(model.sym.xdot*JacTemp,size(JacF));
                Jac=[Jac; JacF];    
                Jacs=subs(Jac,model.sym.x,model.sym.x0);
                LDer = [vH;vF;Jacs];
                [rankFull,rankVector] = jacRank(LDer,rankVector,order,model,options);
                if rankFull
                    break;
                end
            end
            LieDerivatives=subs([model.sym.y;vF;Jac],model.sym.x,model.sym.x0);
            VectorLieDerivatives=reshape(transpose(LieDerivatives),[1,numel(LieDerivatives)]);
            VectorLieDerivatives=genssiRemoveZeroElementsR(VectorLieDerivatives);
        else  %%% CASE WITH CONTROL VARIABLES
            %Compute all combinations of vF and vG of order 'order' (the number of derivatives)
            Jac=[JacF;JacG];
            for order = 2:model.sym.Nder
                disp(['COMPUTING LIE DERIVATIVES OF ORDER', ' ', num2str(order)])
                fprintf(1,'.................................................................\n');
%                 JacTemp = transpose(jacobian(reshape(Jac,[numel(Jac),1]),model.sym.x));
%                 JacF = reshape(model.sym.xdot*JacTemp,size(Jac));
%                 Jac=[Jac;JacF];
                for iNoc=1:model.sym.Noc
                    if ~isequal(model.sym.G(iNoc),sym(0))
                        JacTemp = transpose(jacobian(reshape(Jac,[numel(Jac),1]),model.sym.x));
                        JacG = reshape(model.sym.G(iNoc)*JacTemp(iNoc,:),size(Jac));
                        if iNoc==1
                            JacF = reshape(model.sym.xdot*JacTemp,size(Jac));
                            Jac=[Jac;JacF;JacG];
                        else
                            Jac=[Jac;JacG];
                        end
                    end
                end
                LDer=subs([model.sym.y;vF;vG;Jac],model.sym.x,model.sym.x0);
                [rankFull,rankVector] = jacRank(LDer,rankVector,order,model,options);
                if rankFull
                    break;
                end
            end
        end  
        LieDerivatives=subs([model.sym.y;vF;vG;Jac],model.sym.x,model.sym.x0);
        VectorLieDerivatives=reshape(transpose(LieDerivatives),[1,numel(LieDerivatives)]);
        VectorLieDerivatives=genssiRemoveZeroElementsR(VectorLieDerivatives);
    end
end

function [rankFull,rankVector] = jacRank(LDer,rankVector,order,model,options)
    % jacRank computes jacobian and rank, producing output text
    %
    % Parameters:
    %  LDer: model definition (struct)
    %  rankVector: vector of ranks (for results)
    %  order: for output text, computing derivatives of order
    %  model: model definition
    %  options: processing options (struct)
    %
    % Return values:
    %  rankFull: boolean, true if rank is full
    %  rankVector: vector of ranks (for results)
    %  
    if isfield(options,'noRank') && options.noRank
        rankFull = false;
        return;
    end
    % calculate 2D jacobian the way Maple does it
    JacParam=jacobian(reshape(LDer,[numel(LDer),1]),model.sym.Par);
    if verLessThan('matlab','7.7')
        rankSubJacobian=double(rank(JacParam));
    else
        rankSubJacobian=double(feval(symengine,'linalg::rank',JacParam));
    end
    if rankSubJacobian==length(model.sym.Par)
        rankFull = true;
        disp(['   ->The rank of the Jacobian generated by', ' ', num2str(order), ' derivatives is',' ',num2str(rankSubJacobian),'.' ])
    else
        rankFull = false;
        rankVector(order) = rankSubJacobian;
        if order > 1
            diff = rankSubJacobian - rankVector(order-1);
        else
            diff = 0;
        end
        if diff==0
            s2=rankSubJacobian+rankVector(1);
        else
            s2=rankSubJacobian+diff;
        end
        s3=min(double(s2),length(model.sym.Par));
        disp(['   ->The rank of the Jacobian generated by', ' ', num2str(order), ' derivatives is ', ' ', num2str(rankSubJacobian),'.' ])
        disp(['   ->The rank of the next Jacobian is expected to be maximum', ' ', int2str(s3),'.'])
        fprintf(1,'.................................................................\n');
        disp('  ')
    end
end


