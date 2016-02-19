function [options,results]=genssiOrderTableau(model,results,...
    RJacParam01,ECC,rParam,options)
    % genssiOrderTableau orders tableaus, searches for new opportunities to
    %  eliminate rows or columns be solving equations, and creates new
    %  (reduced) tableaus.
    %
    % Parameters:
    %  model: model definition (struct)
    %  results: results of previous steps (struct)
    %  RJacParam01: reduced tableau, i.e. binary form of jacobian of the
    %   Lie derivatives with respect to the parameters (binary matrix)
    %  ECC: equations (symbolic array)
    %  rParam: reduced list of parameters (symbolic array)
    %  options: options (struct)
    %
    % Return values:
    %  options: options (struct)
    %  results: results of previous steps (struct)
    %  
    fprintf(1,'\n\n******************************************************************************************\n');
    fprintf(1,'-> DETECT (DIRECT) STRUCTURALLY GLOBALLY IDENTIFIABLE PARAMETERS AND REORGANIZES TABLEAU\n');
    fprintf(1,'*******************************************************************************************\n\n');

% set of parameters for which identifiability is done (came from GenSSI_compute_reduced_tableau)
    Param_local=[];	% initialize the vector of locally identifiable parameters
    global_ident_par=[];  % initialize the vector of globally identifiable parameters
    [RJacParam01x,RJacParam01y]=size(RJacParam01);  

    % DETECT GLOBALLY IDENTIFIABLE PARAMETERS 
    RJacParam01_1elem=[]; % the matrix containing only the rows having just 1 non-zero element
    [tilde,Parametery]=size(rParam);
    fprintf(1,'\n\n');
    fprintf(1,' -> STRUCTURALLY GLOBALLY IDENTIFIABLE PARAMETERS DETERMINED DIRECTLY \n');
    fprintf(1,'   (parameters corresponding to one non-zero element in the reduced identifiability tableau)\n\n');
    % solution vector of solutions of Par(j) after solving the equation ECC(i,:) 
	% stores the position of globally identifiable parameters that appear in Par minus 
    % those parameters that cannot be identified (corresponding to a null column in the 
    % Identifiability tableau). For example in the Arabidopsis
    % example the parameters are p1 p2 p5 p8 p11 p12 p15 p18 p26 p27. p10 is not identifiable, and p1,
    % p2 p26 and p27 are globally identifiable. So, in global_ident_par_index1 stores the positions 2 9 10 1.
    global_ident_par_index1=[];
    length_sol=[];
    local_ident_par_index_j=[];		% index for parameters
    local_ident_par_index_i=[];		% index for relations

    for kk=1:Parametery
        for i=1:RJacParam01x
            count_ordered_n=(sum(RJacParam01,2));
            if count_ordered_n(i)==1
                RJacParam01_1elem=[RJacParam01_1elem; RJacParam01(i,:)];
                for j=1:RJacParam01y
                    if (count_ordered_n(i)==1)&&(RJacParam01(i,j)==1)
                        RJacParam01(:,j)=zeros(RJacParam01x,1);
                        solution_ident_par=solve(ECC(i,:),rParam(j));
                        % if the solution is unique, then the parameter is globally identifiable, otherwise it is locally identifiable
                        if length(solution_ident_par)==1   
                            global_ident_par=[global_ident_par rParam(j)];
                            length_sol=[length_sol length(solution_ident_par)];
                            disp(['----->The parameter', ' ', char(rParam(j)),' ','is structurally globally identifiable. It has the solution:' ])
                            disp([' ', ' ',  ' ', ' ', ' ', ' ', ' ',char(rParam(j)),'= ', char(solution_ident_par),'.' ])
                            global_ident_par_index1=[global_ident_par_index1 j];
                        else
                            % if the parameter has multiple solutions, then it will be stored as a locally identifiable
							Param_local=[Param_local rParam(j)];
                            local_ident_par_index_j=[local_ident_par_index_j j]; % index for parameters
                            local_ident_par_index_i=[local_ident_par_index_i i]; % index for relations
                        end
                        RJacParam01(i,:)=0;
                        RJacParam01(:,j)=0;    
                    end 
                end
                % equals to zero the columns corresponding to the global identifiable parameters and corresponding relations row
				RJacParam01(i,:)=zeros(1,RJacParam01y);	
            end
        end
     
    end
    Param_local_l=Param_local;
    % DETECT LOCALLY IDENTIFIABLE PARAMETERS 
    if ~isempty(Param_local_l)
        fprintf(1,'\n\n');
        fprintf(1,' -> STRUCTURALLY LOCALLY IDENTIFIABLE PARAMETERS DETERMINED DIRECTLY \n\n');
        % computation for those parameters condidered 'globally identifiable' but with multiple solutions
        for il=1:length(local_ident_par_index_i)
            for jl=1:length(local_ident_par_index_j)
                solution_ident_local_par=solve(ECC(local_ident_par_index_i(il),:),rParam(local_ident_par_index_j(jl)));
                disp(['----->The parameter', ' ', char(rParam(local_ident_par_index_j(jl))),' ','is structurally locally identifiable. It has the solution:' ])
                disp([' ', ' ', sym(solution_ident_local_par)])
            end
        end
    end
	% equals to zero those columns corresponding to the globally and 'globally' parameters 
    index_elimin_param=[global_ident_par_index1 local_ident_par_index_j];
    for i=1:length(index_elimin_param)
        rParam(index_elimin_param(i))=0;
    end
    sum_glob_id=sum(rParam);
    %eliminate non-zero rows from RJacParam01 and the corresponding relations ECC
    keepRows=any(RJacParam01~=0,2);
    RJacParam01_nonzero_rows=RJacParam01(keepRows,:);
    ECC=ECC(keepRows);
    % DISPLAYS GLOBALLY NON-IDENTIFIABLE PARAMETERS 
    % If all the parameters are globally identifiable, don't have to compute the solution
    Param=rParam;	
	% vector of parameters, with 0 instead of the globally identifiable. 
	% For Arabidopsis Par=[   0,   0,  p5,  p8, p11, p12, p15, p18,   0,   0]
    if isempty(RJacParam01_nonzero_rows)==0    % eliminates the 0s. 
	% Param=[  p5,  p8, p11, p12, p15, p18]
        RJacParam01_nonzero_rows=genssiRemoveZeroColumns(RJacParam01_nonzero_rows);
        Param=genssiRemoveZeroElementsR(Param);
    end
    %Compute the solution
	% if all the parameters are globally identified the set of parameters is empty
    if (length(global_ident_par)==length(Param))&&isequal(global_ident_par,Param)
        Param=[];
    end
    if (~isempty(Param))&&(sum_glob_id~=0)	 
		% computes the remaining parameters, apart of the globally already computed.
        % A function can be constructed, as it repeats later on (until line 739 may be an option, but maybe can be split).
        fprintf(1,'\n\n************************************************************************************************************\n');
        fprintf(1,'->THE REMAINING PARAMETERS (APART FROM IDENTIFIABLE OR NON-IDENTIFIABLE), AND THE CORRESPONDING RELATIONS  \n');
        fprintf(1,'************************************************************************************************************\n\n');
        fprintf(1,'-----> Parameters: \n');
        disp(sym(Param));
        fprintf(1,'-----> Relations: \n');
        disp(sym(ECC));
        % the second order tableau is RJacParam01_nonzero_rows from above
		tableau_for_second_reduced_tableau=RJacParam01_nonzero_rows;
        % vector of remaining parameters from above
		parameters_for_second_reduced_tableau=Param;
        [ECC_index_row,Mat_index]=...
            getIndexOfDuplicateParams...
            (ECC,RJacParam01_nonzero_rows);
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        [Mat_index_x,Mat_index_y]=size(Mat_index);
        if Mat_index_x~=0
            ECC_new=[];
            length_sol=[];
            length_Mat_index=[];	% number of elements on each row of Mat_index
            for i=1:Mat_index_x
                length_Mat_index=[length_Mat_index length(Mat_index(i,:))];
            end
            Mat_row_index=[];
            sum_RJacParam01_nonzero_rows=[];
            ECC_bb=[];
            
            for j=1:Mat_index_y
                aa=Mat_index(1,j);
%                 row_index_1=RJacParam01_nonzero_rows(Mat_index(j),:)
                % from reduced tableau RJacParam01_nonzero_rows row_index_1 collects the rows 
                % needed to compute the group of parameters. For Arabidopsis row_index_1 =     0     1     0     0     1     0
                if aa~=0
                    row_index_1=RJacParam01_nonzero_rows(Mat_index(j),:);
                    ECC_bb=[ECC_bb; ECC(aa)];
					% ECC_bb are the relations needed to compute the group of parameters. In Arabidopsis ECC_bb =
                    %                    -p2*p8/p15-c2
                    % p2*(p8^2/p15^2+2*p2*p8/p15^2)-c4 
                    % to compute p8 and p15
                    row_index_1=RJacParam01_nonzero_rows(aa,:);
                    sum_RJacParam01_nonzero_rows=[sum_RJacParam01_nonzero_rows sum(RJacParam01_nonzero_rows(Mat_index(j),:))];
                    Mat_row_index=[Mat_row_index; row_index_1];
                end
%                 sum_RJacParam01_nonzero_rows=[sum_RJacParam01_nonzero_rows sum(RJacParam01_nonzero_rows(Mat_index(j),:))];
%                 Mat_row_index=[Mat_row_index; row_index_1];
            end
            
            sum_RJacParam01_nonzero_rows_t=sum_RJacParam01_nonzero_rows.';
            sum_row_index_1=sum(row_index_1);
			% calculate the group of parameters from the group of relations
            if (length(ECC_bb)==sum_row_index_1)&&(~isempty(ECC_index_row))
                fprintf(1,'**********************************************************************************\n');
                fprintf(1,'-> COMPUTE HIGHER ORDER REDUCED IDENTIFIABILITY TABLEAU(S) \n\n');
                fprintf(1,'   (display the group of 2/more depending parameters,\n');
                fprintf(1,'            the associated algebraic relations,  \n');
                fprintf(1,'            the corresponding solution (solutions))\n\n');
                fprintf(1,'**********************************************************************************\n\n');
            end    
            RJacparam_new=RJacParam01_nonzero_rows;
            if (length(ECC_bb)==sum_row_index_1)&&(~isempty(ECC_index_row))   
                [Param_local,Param_remaining,global_ident_par,...
                    display_tableau_RJacparam_new,ECC_remaining,...
                    Param_display,number_fig]=...
                    displayRelevantParameters...
                    (Param,Param_local,global_ident_par,...
                    Mat_index,RJacparam_new,RJacParam01_nonzero_rows,...
                    sum_RJacParam01_nonzero_rows_t,ECC,ECC_new,options);
                sum0=sum(display_tableau_RJacparam_new,2).';
				% for the reduced identifiability tableau, look if some globally identfiability parameter can be found, this is equivalent 
                % to the existence of a row with just one non zero element. For Arabidopsis example with all states observables.
                % In this case display_tableau_RJacparam_new =
                %     1     0     1
                %     0     1     0
                % the second row has one non zero element, so the corresponding parameter may be globally identified (if it has unique solution)
                % eliminate 0 elements from the vector of relations
                ECC_remaining=genssiRemoveZeroRows(ECC_remaining);
                % compute the unique element from the corresponding relations
                if (ismember(1,sum0)==1)&&((ismember(2,sum0)==1)||(ismember(3,sum0)==1)||(ismember(4,sum0)==1)||(ismember(5,sum0)==1)||(ismember(6,sum0)==1)||(ismember(7,sum0)==1))       
                    [ECC_remaining,...
                        Param_local,Param_remaining,global_ident_par,display_tableau_RJacparam_new,number_fig]=...
                        displayReducedTableau...
                        (ECC_remaining,Param_local,Param_display,global_ident_par,...
                        display_tableau_RJacparam_new,number_fig,options);
                    %%%%%%%%%%% line 739 %%%%%%%%%%%%%%%%
                end
                % continue the calculus for the remaining group of parameters and relations
                if ~isempty(Param_remaining)
                    [Param_local,global_ident_par]=...
                        displayRemainingParameters...
                        (ECC_remaining,...
                        Param_local,Param_remaining,global_ident_par,display_tableau_RJacparam_new,row_index_1,...
                        tableau_for_second_reduced_tableau,parameters_for_second_reduced_tableau,number_fig,options);
                end
            else
                [Param_local,global_ident_par]=...
                solveRemPar...
                    (ECC,Param,Param_local,global_ident_par);
                genssiTableauImage(03,tableau_for_second_reduced_tableau,...
                    parameters_for_second_reduced_tableau,options);
            end
        else
            [Param_local,global_ident_par]=...
                solveRemPar...
                (ECC,Param,Param_local,global_ident_par);
        end
        genssiTableauImage(03,tableau_for_second_reduced_tableau,...
            parameters_for_second_reduced_tableau,options);
    end
    results.length_sol=length_sol;
    results.global_ident_par=global_ident_par;
    results.Param_local=Param_local;
end

function [Param_local,Param_remaining,global_ident_par,...
        display_tableau_RJacparam_new,ECC_remaining,...
        Param_display,number_fig]=...
        displayRelevantParameters...
        (Param,Param_local,global_ident_par,...
        Mat_index,RJacparam_new,RJacParam01_nonzero_rows,...
        sum_RJacParam01_nonzero_rows_t,ECC,ECC_new,options)
    % displayRelevantParameters displays relevant parameters
    %
    % Parameters:
    %
    % Return values:
    %  
    [Mat_index_x,Mat_index_y]=size(Mat_index);
    for indX=1:Mat_index_x
        Mat_index_row=Mat_index(indX,:);
        for indY=Mat_index_y:-1:1
            Mat_index_component=Mat_index(indX,indY);
            if Mat_index_component==0
                 Mat_index_row(:,indY)=[];% fa ca aici sa nu imi dispara toata coloana, numai elementuls
                 % takes each row from Mat_index_row. As I wrote you, the row may contain 0 elements 
                 % if in the second order reduced tableau there are group of two parameters and two corresponding
                 % relation and 3 relations to compute 3 parameters. If 0s exist, than eliminate them.
            end
        end
        [Mat_index_row_x,tilde]=size(Mat_index_row);
        length_Mat_index=[];
        for iindex=1:Mat_index_row_x
            length_Mat_index=[length_Mat_index length(Mat_index_row(iindex,:))];
        end
        length_Mat_index_t=length_Mat_index.';
        if sum_RJacParam01_nonzero_rows_t(indX,:)==length_Mat_index_t;
            if Mat_index_row==0
                Mat_index_row=[];
            end
            Non_zero_elem_index=find(RJacParam01_nonzero_rows(Mat_index_row(indX),:));
            % position of 1s (parameters) in the corresponding rows. For Arabidopsis Non_zero_elem_index =
            % 2     5
            % parameters in the Non_zero_elem_index possitions. For Arabidopsis reduced_param =[  p8, p15]
            reduced_param=Param(Non_zero_elem_index);
            % relations in the index Mat_index_row
            ECC_new=[ECC_new; ECC(Mat_index_row)]; 
            % this part of computing the parameters are repeated many times, it can be
            % put in a function (until line 545).
            fprintf(1,'-----> The group of parameters to be considered in the calculus and the corresponding relations:\n\n');
            fprintf(1,'-> Parameters: \n');
            fprintf(1,'   \t[');
            for i2=1:size(reduced_param,2)
                 fprintf(1,'%s\t',char(reduced_param(i2)));
            end
            fprintf(1,']\n\n\n');
            fprintf(1,'-> Relations: \n');
            disp(sym(ECC_new));
            if length(reduced_param)==length(ECC_new)      % compute the solution for each pair of parameters   
                [Param_local,global_ident_par]=...
                    solveRemPar...
                    (ECC_new,reduced_param,Param_local,global_ident_par);  
                ECC_reduced_it=ECC;
                for j=Mat_index_y:-1:1   
                    % equals to 0 the 1s corresponding to the already computind parameters
                    RJacparam_new(Mat_index(indX,j),:)=0;
                    % remaining relations after computing the first group, equaling to 0 the ones we have used. 
                    ECC_reduced_it(Mat_index(indX,j),:)=0;
                end
                index_global=[];
                % if the columns in RJacparam_new have no elements, store that column (parameter) in index_global
                Sum_L=sum(RJacparam_new);
                for m=1:length(Sum_L)
                    if Sum_L(m)==0
                        index_global=[index_global m];
                    end
                end      
                display_RJacparam_new=RJacparam_new;
                % for Arabidopsis display_RJacparam_new =
                %    0     0     0     0     0     0
                %    0     0     0     0     0     0
                %    0     0     1     0     0     1
                %    1     0     0     1     0     0
                %    0     0     1     0     0     1             
                compute_reduced_par=Param;
                % eliminates 0 rows (relations) and 0 col
                [display_RJacparam_new,keepB,tilde] = genssiRemoveZeroRows(display_RJacparam_new);
%                 ECC_reduced_it = ECC_reduced_it(keepB,:);
                if ECC_reduced_it==0
                     ECC_reduced_it=[];
                     disp('Test warning: Does this ever happen?');
                end
                ECC_remaining=ECC_reduced_it;
                display_RJacparam_new(:,Non_zero_elem_index)=0; % ??!!
                display_RJacparam_new(:,Non_zero_elem_index)=[]; % ??!!
                compute_reduced_par(Non_zero_elem_index)=[];
                display_tableau_RJacparam_new=display_RJacparam_new;
                Param_zero=Param;
                % equals to 0 those parameters computed (Param_zero)
                for ii=length(Param_zero):-1:1
                    for jj=1:length(Non_zero_elem_index)
                        if  ii==Non_zero_elem_index(jj)
                            Param_zero(ii)=0;
                        end
                    end
                end
                % eliminates the 0 parameters from Param_zero and generates Param_display. 
                % In Arabidopsis is [p5, p11, p12, p18]
                Param_display=Param_zero;
                Param_display=genssiRemoveZeroElementsR(Param_display);
                rem_par=compute_reduced_par;
                % if in the parameters I still have 0 elements, elliminate them.
                [rem_par,keepB,tilde] = genssiRemoveZeroElementsR(rem_par);
                display_tableau_RJacparam_new = display_tableau_RJacparam_new(:,keepB);
                ECC_new=[];
                % the remaining indexfrom Mat_index. In Arabidopsis 2 5.
                % call the function you constructed to generate the figures of the tableaus.
                Param_remaining=Param_display;
                number_fig=03+indX;
                genssiTableauImage(number_fig,display_tableau_RJacparam_new,...
                    Param_display,options);
                fprintf(1,'....................................................................................................\n\n');
                %%%%%%%%%%%%%%
                % remaining parameters and relations, but with 0 in the position of computed parameters and used relations
                ECC=ECC_reduced_it;
                Param=Param_zero;
            end
        end
    end
end

function [ECC_remaining,...
        Param_local,Param_remaining,global_ident_par,display_tableau_RJacparam_new,number_fig]=...
        displayReducedTableau...
        (ECC_remaining,Param_local,Param_display,global_ident_par,...
        display_tableau_RJacparam_new,number_fig,options)
    % displayReducedTableau displays reduced tableaus
    %
    % Parameters:
    %
    % Return values:
    %  
    sum0=sum(display_tableau_RJacparam_new,2).';
    Par_1el=[];
    ECC_remaining_1el=[];
    Param_remaining=[];
    ECC_remaining_f=[];
    index_in=[];
    index_jn=[];   
    % take the row and column corresponding to the unique element, equivalent to sum0=1
    [display_tableau_RJacparam_new_x,display_tableau_RJacparam_new_y]=size(display_tableau_RJacparam_new);
    for indX=1:display_tableau_RJacparam_new_x
        if sum0(indX)==1
            index_in=[index_in indX];
            for indY=1:display_tableau_RJacparam_new_y
                if display_tableau_RJacparam_new(indX,indY)==1
                    % Par_1el the parameter
                    Par_1el=[Par_1el Param_display(indY)];
                    % ECC_remaining_1el the relation
                    ECC_remaining_1el=[ECC_remaining_1el ECC_remaining(indX)];
                    index_jn=[index_jn indY];
                else 
                    % Param_remaining remaining group of parameters
                    Param_remaining=[Param_remaining Param_display(indY)];
                end
            end
        else
            ECC_remaining_f=[ECC_remaining_f; ECC_remaining(indX)];
        end
    end
    [Param_local,global_ident_par]=...
        solveRemPar...
        (ECC_remaining_1el,Par_1el,Param_local,global_ident_par);        
    for i=length(index_in):-1:1
        display_tableau_RJacparam_new(index_in(i),:)=[];
    end
    for j=length(index_jn):-1:1
        display_tableau_RJacparam_new(:,index_jn(j))=[];
        Param_display(index_jn(j))=[];
    end
    number_fig=number_fig+1;
    genssiTableauImage(number_fig,display_tableau_RJacparam_new,...
        Param_display,options);
    ECC_remaining=ECC_remaining_f;
end

function [Param_local,global_ident_par]=...
        displayRemainingParameters...
        (ECC_remaining,Param_local,Param_remaining,global_ident_par,display_tableau_RJacparam_new,row_index_1,...
        tableau_for_second_reduced_tableau,parameters_for_second_reduced_tableau,number_fig,options)
    % displayReducedTableau displays the remaining parameters
    %
    % Parameters:
    %
    % Return values:
    %  
    fprintf(1,'-----> The remaining group of parameters, relations and the corresponding solutions:\n\n');
    fprintf(1,'-> Parameters: \n');
    fprintf(1,'   \t[');
    for ir=1:size(Param_remaining,2)
        fprintf(1,'%s\t',char(Param_remaining(ir)));
    end
    fprintf(1,']\n\n\n');
    [ECC_remaining,tilde,tilde] = genssiRemoveZeroElementsC(ECC_remaining);
    fprintf(1,'-> Relations: \n');
    disp(sym(ECC_remaining)) 
    genssiTableauImage(03,tableau_for_second_reduced_tableau,...
        parameters_for_second_reduced_tableau,options);
    %%%%%%%%%%%%%%%%%%  SECOND REDUCED TABLEAUS
    RJacParam01_nonzero_rows=display_tableau_RJacparam_new;
    Param=Param_remaining;
    ECC=ECC_remaining;
    [ECC_index_row,Mat_index]=...
        getIndexOfDuplicateParams...
        (ECC,RJacParam01_nonzero_rows);
    [Mat_index_x,Mat_index_y]=size(Mat_index);
    length_Mat_index=[];
    for i=1:Mat_index_x
        length_Mat_index=[length_Mat_index length(Mat_index(i,:))];
    end
    Mat_row_index=[];
    sum_RJacParam01_nonzero_rows=[];
    ECC_bb=[];
    for j=1:Mat_index_y
        aa=Mat_index(1,j);
        row_index_1=RJacParam01_nonzero_rows(Mat_index(j),:);
        if aa~=0
            ECC_bb=[ECC_bb; ECC(aa)];
        end
        sum_RJacParam01_nonzero_rows=[sum_RJacParam01_nonzero_rows sum(RJacParam01_nonzero_rows(Mat_index(j),:))];
        Mat_row_index=[Mat_row_index; row_index_1];
    end
    sum_row_index_1=sum(row_index_1);
    if Mat_index_x==0
        [Param_local,global_ident_par]=...
            solveRemPar...
            (ECC,Param,Param_local,global_ident_par);        
    end
    if Mat_index_x>=1
        ECC_new=[];
        length_Mat_index=[];
        for i=1:Mat_index_x
            length_Mat_index=[length_Mat_index length(Mat_index(i,:))];
        end
        Mat_row_index=[];
        sum_RJacParam01_nonzero_rows=[];
        for j=1:Mat_index_y
            row_index_1=RJacParam01_nonzero_rows(Mat_index(j),:);
            sum_RJacParam01_nonzero_rows=[sum_RJacParam01_nonzero_rows sum(RJacParam01_nonzero_rows(Mat_index(j),:))];
            Mat_row_index=[Mat_row_index; row_index_1];
        end
        sum_RJacParam01_nonzero_rows_t=sum_RJacParam01_nonzero_rows.';
        length(ECC_index_row);
        if (length(ECC_bb)==sum_row_index_1)&&(~isempty(ECC_index_row))
            for i=1:Mat_index_x
                %if (length(ECC_index_row)==sum_row_index)&&(length(ECC_index_row)~=0)
                fprintf(1,'**********************************************************************************\n');
                fprintf(1,'-> THE REDUCED TABLEAUS OF THE REDUCED TABLEAU  \n\n');
                fprintf(1,'   (for the remaining set of parameters and relations)  \n');
                fprintf(1,'**********************************************************************************\n\n');
                %end
                RJacparam_new=RJacParam01_nonzero_rows;
                Mat_index_row=Mat_index(i,:);
                for ij=Mat_index_y:-1:1
                    Mat_index_component=Mat_index(i,ij);
                    if Mat_index_component==0
                        Mat_index_row(:,ij)=[];% fa ca aici sa nu imi dispara toata coloana, numai elementuls
                    end
                end
                [Mat_index_row_x,tilde]=size(Mat_index_row);
                length_Mat_index=[]; 
                for iindex=1:Mat_index_row_x
                    length_Mat_index=[length_Mat_index length(Mat_index_row(iindex,:))];
                end
                length_Mat_index_t=length_Mat_index.';
                if sum_RJacParam01_nonzero_rows_t(i,:)==length_Mat_index_t;
                    if Mat_index_row==0
                        Mat_index_row=[];
                    end
                    Non_zero_elem_index=find(RJacParam01_nonzero_rows(Mat_index_row(i),:));
                    reduced_param=Param(Non_zero_elem_index);
                    ECC_new=[ECC_new; ECC(Mat_index_row)];        
                    fprintf(1,'-----> The group of parameters to be considered in the calculus and the corresponding relations:\n\n');
                    fprintf(1,'-> Parameters: \n');
                    fprintf(1,'   \t[');
                    for i2=1:size(reduced_param,2)
                         fprintf(1,'%s\t',char(reduced_param(i2)));
                    end
                    fprintf(1,']\n\n\n');
                    fprintf(1,'-> Relations: \n');
                    disp(sym(ECC_new));
                    if length(reduced_param)==length(ECC_new)           %   compute the solution for each pair of parameters       
                        [Param_local,global_ident_par]=...
                            solveRemPar...
                            (ECC_new,reduced_param,Param_local,global_ident_par);
                        ECC_reduced_it=ECC;
%                                         Param_remaining=[];
                        for j=Mat_index_y:-1:1   
                            RJacparam_new(Mat_index(i,j),:)=0;
                            ECC_reduced_it(Mat_index(i,j),:)=0;
                        end
                        index_global=[];
                        Sum_L=sum(RJacparam_new);
                        for m=1:length(Sum_L)
                            if Sum_L(m)==0
                                RJacparam_new(i,:);
                                index_global=[index_global m];
                            end
                        end 
                        display_RJacparam_new=RJacparam_new;
                        compute_reduced_par=Param;
                        [RJacparam_new_x,tilde]=size(RJacparam_new); 
                        sum_zero_row_new=sum(display_RJacparam_new,2)';
                        for ij=RJacparam_new_x:-1:1
                            if sum_zero_row_new(ij)==0
                               display_RJacparam_new(ij,:)=[];
                            end
                            if ECC_reduced_it==0
                                 ECC_reduced_it=[];
                            end
                        end
                        ECC_remaining=ECC_reduced_it;
                        display_RJacparam_new(:,Non_zero_elem_index)=0;
                        display_RJacparam_new(:,Non_zero_elem_index)=[];
                        compute_reduced_par(Non_zero_elem_index)=[];
                        display_tableau_RJacparam_new=display_RJacparam_new; 
                        Param_zero=Param;
                        for ii=length(Param_zero):-1:1
                            for jj=1:length(Non_zero_elem_index)
                                if  ii==Non_zero_elem_index(jj)
                                    Param_zero(ii)=0;
                                end
                            end
                        end
                        Param_display=Param_zero;
                        for i3=length(Param_display):-1:1
                            if Param_display(i3)==0
                                Param_display(i3)=[];
                            end
                        end
                        rem_par=compute_reduced_par;
                        for mm=length(rem_par):-1:1
                           if rem_par(mm)==0
                               display_tableau_RJacparam_new(:,mm)=[];
                               rem_par(mm)=[];
                           end
                        end
                        ECC_new=[];
                        [display_tableau_RJacparam_new_x,display_tableau_RJacparam_new_y]=size(display_tableau_RJacparam_new);
                        Param_remaining=Param_display;
                        number_fig=number_fig+i;
                        genssiTableauImage(number_fig,display_tableau_RJacparam_new,...
                            Param_display,options);
                        fprintf(1,'....................................................................................................\n\n');
                        ECC=ECC_reduced_it;
                        Param= Param_zero;
%                         Param_local=[Param_local Param_local_each];
%                         global_ident_par=[global_ident_par global_ident_par_each];
                    end
                end   
            end
            sum0=sum(display_tableau_RJacparam_new.');
            [ECC_remaining_x,tilde]=size(ECC_remaining);
            for i=ECC_remaining_x:-1:1
                if ECC_remaining(i)==0
                    ECC_remaining(i)=[];
                end
            end
            if (ismember(1,sum0)==1)&&((ismember(2,sum0)==1)||(ismember(3,sum0)==1)||(ismember(4,sum0)==1)||(ismember(5,sum0)==1)||(ismember(6,sum0)==1)||(ismember(7,sum0)==1))
                Par_1el=[];
                ECC_remaining_1el=[];
                Param_remaining_f=[];
                ECC_remaining_f=[];
                index_in=[];
                index_jn=[];      
                for i_n=1:display_tableau_RJacparam_new_x
                    if sum0(i_n)==1
                        index_in=[index_in i_n];
                        for j_n=1:display_tableau_RJacparam_new_y
                            if display_tableau_RJacparam_new(i_n,j_n)==1
                                Par_1el=[Par_1el Param_display(j_n)];
                                ECC_remaining_1el=[ECC_remaining_1el ECC_remaining(i_n)];
                                index_jn=[index_jn j_n];
                            else 
                                Param_remaining_f=[Param_remaining_f Param_display(j_n)];
                            end
                        end
                    else
                        ECC_remaining_f=[ECC_remaining_f; ECC_remaining(i_n)];
                    end
                end
                [Param_local,global_ident_par]=...
                    solveRemPar...
                    (ECC_remaining_1el,Par_1el,Param_local,global_ident_par);
                for i=length(index_in):-1:1
                    display_tableau_RJacparam_new(index_in(i),:)=[];
                end
                for j=length(index_jn):-1:1
                    display_tableau_RJacparam_new(:,index_jn(j))=[];
                    Param_display(index_jn(j))=[];
                end
                genssiTableauImage(number_fig,display_tableau_RJacparam_new,...
                    Param_display,options);                                    
                if display_tableau_RJacparam_new_x~=1 % is this if required??!!
                    Param_local=[Param_local Param_local_red_1el];
                    global_ident_par=[global_ident_par global_ident_par_red_1el]; 
                end
                Param_remaining=Param_remaining_f;
                ECC_remaining=ECC_remaining_f;
            end
        end
        fprintf(1,'-----> The remaining group of parameters, relations and the corresponding solutions:\n\n');
        fprintf(1,'-> Parameters: \n');
        fprintf(1,'   \t[');
        for ir=1:size(Param_remaining,2)
            fprintf(1,'%s\t',char(Param_remaining(ir)));
        end
        fprintf(1,']\n\n\n');
        [ECC_remaining_x,tilde]=size(ECC_remaining);
        for i=ECC_remaining_x:-1:1
            if ECC_remaining(i)==0
                  ECC_remaining(i)=[];
            end
        end
        fprintf(1,'-> Relations: \n');
        disp(sym(ECC_remaining));
        [Param_local,global_ident_par]=...
            solveRemPar...
            (ECC_remaining,Param_remaining,Param_local,global_ident_par);
        genssiTableauImage(03,tableau_for_second_reduced_tableau,...
            parameters_for_second_reduced_tableau,options);                     
    end
end

function [Param_local,global_ident_par]=...
        solveRemPar...
        (ECC,Param,Param_local,global_ident_par)
    % solveRemPar solves the remaining parameters
    %
    % Parameters:
    %
    % Return values:
    %  
    fprintf(1,'-----> THE SYMBOLIC SOLUTION OF THE REMAINING PARAMETERS: \n');
    [tilde,Paramy]=size(Param);
    Param_local_r=Param;
    [ECCx,tilde]=size(ECC);
    length_sol=[];
    global_ident_par_sol_1=[];
    Param_local_sol_1=[];
    if Paramy==ECCx
        equation_relations=mat2cell(ECC,ones(1,length(ECC)),1);
        constants=mat2cell(Param_local_r,1,ones(1,length(Param_local_r)))';
        Solution=solve(equation_relations{:}, constants{:});
        sol=fieldnames(Solution);
        [solx,tilde]=size(sol);
        if solx<=1 % because there are no fieldnames in this case
            disp(['-----> The parameter', ' ', char(Param_local_r),' ','has the solution/solutions:', ' ' ])
            disp([' ', ' ', sym(Solution)])
            length_sol=[length_sol length(Solution)];
            if length_sol==1
               global_ident_par_sol_1=[global_ident_par_sol_1 Param_local_r];
            else 
               Param_local_sol_1=[Param_local_sol_1 Param_local_r];
            end
        else
            for i=1:solx
               disp(['-----> The parameter', ' ', char(Param_local_r(i)),' ','has the solution/solutions:', ' ' ]);
               disp([' ', ' ', sym(Solution.(sol{i}))]);
               length_sol=[length_sol length(Solution.(sol{i}))];
               if length_sol==1
                   global_ident_par_sol_1=[global_ident_par_sol_1 Param_local_r(i)];
               else 
                   Param_local_sol_1=[Param_local_sol_1 Param_local_r(i)];
               end
            end
        end
    else 
        fprintf(1,' -----> WARNING: the number of parameters is higher than the number of relations! \n');
        fprintf(1,'                 An explicit solution cannot be given for this subset of parameters. \n');
        fprintf(1,'                 PLEASE CONSIDER AN EXTRA DERIVATIVE! \n\n');
    end
    Param_local=[Param_local Param_local_sol_1];
    global_ident_par=[global_ident_par global_ident_par_sol_1];              
end

function [ECC_index_row,Mat_index]=...
    getIndexOfDuplicateParams(ECC,RJacParam01_nonzero_rows)
    % getIndexOfDuplicateParams gets index of duplicate parameters
    %
    % Parameters:
    %
    % Return values:
    %  
    [RJacParam01_nonzero_rowsx, RJacParam01_nonzero_rowsy]=size(RJacParam01_nonzero_rows);
    uu1=[];
    uu2=[];
    uu=[];
    ECC_index_row=[];
    Index1=zeros(1,RJacParam01_nonzero_rowsy);
    for i=1:RJacParam01_nonzero_rowsx  
        % find a row or a column?
        if(size(RJacParam01_nonzero_rows(i,:),2) == 1);
            B = ismember(RJacParam01_nonzero_rows', RJacParam01_nonzero_rows(i,:)', 'rows')';  % boolean indexes
        else
            B = ismember(RJacParam01_nonzero_rows, RJacParam01_nonzero_rows(i,:), 'rows');     % boolean indexes
        end
        % from second order identifiability tableau find those rows that contain the same parameters. For example in 
        % Arabidopsis those indices are 1 and 2 so the first and second relation needed to compute p8 and p15, 
        % and 3 and 5 to compute p11 and p18.
        Index = find(B == true); % row/column indexes
        if length(Index)<2
        else
            Index_init=Index';
            Index_fin=Index1;
            % biggest number of relations needed to compute a group of parameters. For example in Arabidopsis it is 2 
            % (the indices are 1 2 (corresponding to relation 1 and 2 in the second order reduced tableau) to calculate 
            % p8 and p15 and 3 5 to calculate p11 and p18)
            length_Index_init=length(Index');
            length_Index_fin=length(Index1');     
            if (length_Index_fin>1)&&(length_Index_init>1)         
                if (length_Index_init>=length_Index_fin)
                    % index of those rows-{rows needed to calculate groups of parameters}. For Arabidobsis dif_Index is 4
                    dif_Index=length_Index_init-length_Index_fin;
                    Index_fin=[Index_fin zeros(1,dif_Index)];
                    uu1=[uu1; Index_fin; Index_init];
                else 
                    dif_Index=length_Index_fin-length_Index_init;
                    Index_init=[Index_init zeros(1,dif_Index)];
                    uu2=[uu2; Index_init; Index_fin];
                    % stores information about these rows needed to compute the group of parameters.
                    % for Arabidopsis it is
                    %      uu2 = 
                    %      1     2     0     0     0     0
                    %      0     0     0     0     0     0
                    %      1     2     0     0     0     0
                    %      0     0     0     0     0     0
                    %      3     5     0     0     0     0
                    %      0     0     0     0     0     0
                    %      3     5     0     0     0     0
                    %      0     0     0     0     0     0
                end        
            end
            Index1=Index_fin;
            uu=[uu1;uu2];

% From here to line 330 reduces the matrix uu to a matrix containing all the indices needed to compute the group of
% parameters. The reduced matrix is Mat_index. For Arabidopsis
% Mat_index =
%      1     2
%      3     5
% If we have groups of 2 relations and 2 parameters and also 3 relations
% for 3 parameters, then Mat_index will have 3 columns. For example (not in
% Arabidopsis)  1   2   0
%               3   5   0
%               4   6   7

            ECC_index_row=ECC(Index);
            [uu,tilde,tilde] = genssiRemoveZeroColumns(uu);
            [uu,tilde,tilde] = genssiRemoveZeroRows(uu);            
        end
    end
    [uux,tilde]=size(uu);
    Mat_index=[];
    k_index=[];
    for i=1:uux
        rank_o=double(rank(Mat_index));
        rank_n=double(rank([Mat_index; uu(i,:)]));
        if rank_n> rank_o
            Mat_index=[Mat_index; uu(i,:)];
            k_index=[k_index i];
        end   
    end %%%%%%%%% line 330 %%%%%%%%%%%
end
