%in the name of god
function chromosome=ResponseMechanism(chromosome,memory,mean_ebsilon_t,ebsilon_t,value_action)

global Pr col row  nVar numOfObj;
% mean_ebsilon_t=mean_ebsilon_t;
if ebsilon_t<=0.001
col=1;row=1;
elseif ebsilon_t>0.001 
col=2;row=1;
end

%%%%%%%%%%%%%%%%%%%%%%%

%archive   means current population
% global  nVar  numOfObj
 emp=convert_chromosome_emp(chromosome);%new
    nEmp=numel(emp);
         pop=[emp(1).Imp];
         for j=1:emp(1).nCol
         pop=[pop;emp(1).Col(j)];
         end
        for k=2:nEmp
         pop=[pop;emp(k).Imp];
         for j=1:emp(k).nCol
         pop=[pop;emp(k).Col(j)];
         end
        end
     Archive = non_domination_sort_mod(pop, numOfObj, nVar);
        L=numel(Archive);
    Pr=value_action;
 Nr=floor(Pr*(L*0.33));
 remain=(33-Nr)+67;
 NTr_sp=floor(remain/2);
  Nm=ceil(remain/2);
    %%%^^^^^^^^^^^^^^^^^^^^^^^^^^ Empire random^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  emp=ResponseMechanism_rnd(emp,1,Archive(L-Nr:L));
      %%%^^^^^^^^^^^^^^^^^^^^^^^^^^ Empire prediction^^^^^^^^^^^^^^^^^^^^^^^^^^^^
%   emp=ResponseMechanism_predict(emp,2,Archive(round(L*(1/3)):round(L*(2/3))));
  emp=ResponseMechanism_predict(emp,2,Archive,NTr_sp);
    %%%^^^^^^^^^^^^^^^^^^^^^^^^^^ Empire memory^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  if numel(memory)<1
      memory=chromosome(1:emp(3).nCol+1,:);
  end
  %convert memory
     for i=1: numel(memory(:,1))
         memory1(i).Position=memory(i,1:nVar);
         memory1(i).Cost=memory(i,nVar+1:nVar+numOfObj);
         memory1(i).Front=memory(i,nVar+numOfObj+1);
         memory1(i).crowded_dis=memory(i,nVar+numOfObj+2);
         memory1(i).violation=memory(i,nVar+numOfObj+3);
     end
  %%%%%%%%%%%%%%%%%%%
  emp=ResponseMechanism_memory(emp,3,Archive(1:Nm),memory1,Nm);
%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%covert emp to chromosome
     nEmp=numel(emp);
         pop=[emp(1).Imp];
         for j=1:emp(1).nCol
         pop=[pop;emp(1).Col(j)];
         end
        for k=2:nEmp
         pop=[pop;emp(k).Imp];
         for j=1:emp(k).nCol
         pop=[pop;emp(k).Col(j)];
         end
        end
   %%%%%%%%%%%
   for i=1: numel(pop)
   % [[pop(i).Position],[pop(i).Cost],[pop(i).Front],[pop(i).crowded_dis]]
x(i,1:nVar+numOfObj+3)=[[pop(i).Position],[pop(i).Cost],[pop(i).Front],[pop(i).crowded_dis],[pop(i).violation]];
   end
%       for i=1: numel(memory)
%    % [[pop(i).Position],[pop(i).Cost],[pop(i).Front],[pop(i).crowded_dis]]
% memory1(i,1:nVar+numOfObj+3)=[[memory(i).Position],[memory(i).Cost],[memory(i).Front],[memory(i).crowded_dis],[memory(i).violation]];
%%%%%%%%%%%%%%%%
    chromosome=x;
    chromosome = non_domination_sort_mod1(chromosome, numOfObj, nVar);
        