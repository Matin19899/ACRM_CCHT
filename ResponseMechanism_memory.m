%in the name of god
function emp=ResponseMechanism_memory(emp,indxImp,pop,memory,Nm)
    global ProblemSettings ;
    CostFunction=ProblemSettings.CostFunction;
    VarSize=ProblemSettings.VarSize;
    VarMin=ProblemSettings.VarMin;
    VarMax=ProblemSettings.VarMax;
        numOfObj=ProblemSettings.numOfObj;
    nVar=ProblemSettings.nVar;

    w = 0.5;              % Inertia Weight
beta = 2;             % Leader Selection Pressure

%                 pop = non_domination_sort_mod(pop, numOfObj, nVar);
%          Best_solution_index=numel(find([pop.Front]<=1));
%          pop1=pop(1:Best_solution_index);
        
         meanD=mean([pop( [find([pop.crowded_dis]~=inf)]).crowded_dis]);
         
         
         %^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  Reproduction and
         %Gusian 
         count1=1;
         Reproduction(1)=pop(1);%% for determine stracture  only
         for i=1: numel (pop)
             if pop(i).crowded_dis>(meanD)
                 RP=2;
             else
                 RP=1;
             end
                 for j1=1:RP
         Reproduction(count1).Position=[pop(i).Position]+normrnd(0,1,1,nVar);
         %unifrnd(VarMin,VarMax,VarSize);    
         %^^^^^^^^^^^^^^^^^  check boundry^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         for  j=1:nVar
    if Reproduction(count1).Position(j)<VarMin(1,j)
               Reproduction(count1).Position(j)= min(VarMax(1,j),2*VarMin(1,j)- Reproduction(count1).Position(j));
    end
        if  Reproduction(count1).Position(j)>VarMax(1,j)
               Reproduction(count1).Position(j) = max(VarMin(1,j),2*VarMax(1,j)- Reproduction(count1).Position(j));
        end  
end
         
         %^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
         Reproduction(count1).Cost=CostFunction(Reproduction(count1).Position);      
         Reproduction(count1).violation=check_feasibility(Reproduction(count1).Position);

         count1=count1+1;
                 end
         end
         %%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^     delete redundency element ^^^^^^^^^^^^^^^^^
         Reproduction=Reproduction';
         memory=memory';
         Reproduction= [Reproduction;pop;memory];
         for i1=1:numel(Reproduction)
         pos(i1,1:2)=[Reproduction(i1).Cost];
         end
         [pos1,indx,indx2]=unique(pos,'rows');
         Reproduction=Reproduction(indx);
         %^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

         Reproduction = non_domination_sort_mod(Reproduction, numOfObj, nVar);
         
         nGrid=7;
         alpha=0.1;
         %%%%%%%%% start Gride 
         Grid = CreateGrid(Reproduction, nGrid, alpha);
for i = 1:numel(Reproduction)
    Reproduction1(i) = FindGridIndex(Reproduction(i), Grid);
end
        leader= SelectLeader(Reproduction1, beta,Nm);

 for i=1:numel (pop)
   
pop(i).Position=     leader(i).Position;
pop(i).Cost=     leader(i).Cost;
pop(i).Front=     leader(i).Front;
pop(i).crowded_dis=     leader(i).crowded_dis;
% pop(i).dis_ideal=     leader(i).dis_ideal;
pop(i).violation=     check_feasibility( leader(i).Position);%%%%%%%%%%note after change
      end    
             pop = non_domination_sort_mod(pop, numOfObj, nVar);     
             emp(indxImp).Imp=pop(1);
          for i=1:numel(pop)-1
            emp(indxImp).Col(i)=pop(i+1);
          end   
             emp(indxImp).nCol=numel(pop)-1;
      
         
%         emp(j).Imp.Col=pop;
%           for i=2:numel(pop)
%             emp(j).Col(i)=pop(i);
%           end   
          
          