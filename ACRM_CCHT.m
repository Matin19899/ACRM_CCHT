%in the name of god 
%?? ???? ?? ?? ?? ??? ?? ??? ?? ??? ?? ??? ?? ???? ?? ????
function improved_DNSGA_II_A_TCA_2()
 

% load ('sp.mat')
%  for  tot=1:10
 clear all
close all
global ideal_point   nPop  itrCounter TestProblem step window  CostFunction nVar VarMin VarMax numOfObj ns nt     t mp Cr First_Chenge
 figure('Color',[1,1,1]);

%  rng(0);
 run_t1=0;
 change_conter=0;

 for  run_t=1:30
% step =10;%nT  intensity
% window =3;%Tt  ferequency  (Tt,nT)(5,10) (10,10)
t=1;
window=25;%change frequancy 
TestProblem = 72;
nPop = 100;
ns=round(nPop/2);%sample from source domain
nt=round(nPop);%sample from target domain
pool = round(nPop/2);
tour = 2;
[numOfObj, nVar, VarMin, VarMax] = objective_description_function();
mu = 5;%crossover index 2017
mum = 15;%mutation index 2017
Cr=0.7;%refrence 2017
mp=0.01;%1/nVar;%refrence 2017
value_move=0;
ideal_point=0;
%  VarMin(1,:)=0.01;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ICA
%% Problem Definition
% CostFunction=@(x) Sphere(x);        % Cost Function
% nVar=5;             % Number of Decision Variables
VarSize=[1 nVar];   % Decision Variables Matrix Size
% VarMin=-10;         % Lower Bound of Variables
% VarMax= 10;         % Upper Bound of Variables
%% ICA Parameters
MaxIt=2000;         % Maximum Number of Iterations
% nPop=100;            % Population Size
alpha=1;            % Selection Pressure
nEmp=3;            % Number of Empires/Imperialists
%% Globalization of Parameters and Settings
global ProblemSettings;
ProblemSettings.CostFunction=CostFunction;
ProblemSettings.nVar=nVar;
ProblemSettings.VarSize=VarSize;
ProblemSettings.VarMin=VarMin;
ProblemSettings.VarMax=VarMax;
ProblemSettings.numOfObj=numOfObj;
global ICASettings;
ICASettings.MaxIt=MaxIt;
ICASettings.nPop=nPop;
ICASettings.nEmp=nEmp;
ICASettings.alpha=alpha;

emp=CreateInitialEmpires();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%****************************
ideal_point = zeros(numOfObj, 1)';
%% Initialization
% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,2);
% value_move=0;
%^^^^^^^^^^^^^^^^^^^^^^^^^^^main^^^^^^^^^^^^^^^^^^^^
memory=[];
pool=50;
tour=2;
first_run=1;
chromosome = [];
value_move=0.5;
t1=[1,2,3,4,5];
itrCounter1=1;
chromosome = initialize_variables1(chromosome, 1);
chromosome = non_domination_sort_mod1(chromosome, numOfObj, nVar);
ebsilon_change=[];
change_conter1=0;%JY6%JY3
change_conter2=0;

%      t =floor(itrCounter/window)/step;
%      t =floor(itrCounter/window);
t_step=0;
itr=1;
memory=[];
Q = zeros(1,2,2);%*******************************Q LEARNING******$$$$$$$$$$$$$$$$$$$$$$$$$
 Q(1,2,2)=1;%Q value initialization
row=1; col=2;
action_index1=[0.25;0.5];
action_index2=[0.75;1];
% reward_shaping=zeros(1,2,2);%%%%reward shaping+++design 2
% reward_shaping(1,2,2)=0.2;%%%%reward shaping+++ design2
% reward_shaping=ones(1,2,2);%%%reward shaping+++design 1
% reward_shaping(1,2,2)=2;%%%%reward shaping+++ design1

% num_change_reward_shap=7;%%%%reward shaping
epsilon=0.5;
action=2;
value_action=1;
IGD_old=100;
SP_old=100;
MS_old=100;
gamma1=0.5;
alpha1=0.8;
precol=1;
prerow=1;
F_best=false;
First_Chenge=false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
 while itr<=MaxIt   %%%%%%%%%%%%refrence 2019
     intermediate_chromosome=[];
  for n_p=1:nPop
      %change Detection
    [flag_change,ebsilon_t]=ChangeDetection(chromosome);
    if flag_change==true

             if ebsilon_t ~= 0
    %%%%%%%%%%%%adjusting rate rando prediction memory population   
    ebsilon_change(change_conter1+1,:)=[ebsilon_t,change_conter1+1];
    mean_ebsilon_t=mean(ebsilon_change(:,1));
    end
             ebsilon_t=ebsilon_t;
        if t>0 
        t;
        change_conter=change_conter+1;
        change_conter2=change_conter2+1;
        itrCounter1=itrCounter1+1;
         if change_conter>1
IGD_old=IGD1(end);
SP_old=SP1(end);
MS_old=MS(end);
         end
 if change_conter2==1
    First_Chenge=true;%%%%%%%%%%%%%    FDA&&CDP
 else 
    First_Chenge=false;%%%%%%%%%%%%%    FDA&&CDP  
 end
       % plot front solution
 [MS(change_conter),SP1(change_conter),IGD1(change_conter),HV_ratio(change_conter)]=PlotFrontSolution(PF_front1, value_move,t_old);
 %***************************************************add for plotVVVVVVV
 if run_t==1
 best_solution_IGD(t)=IGD1(change_conter);
 best_solution_value(t).pop_t=PF_front1;
 elseif best_solution_IGD(t)>IGD1(change_conter)
 best_solution_IGD(t)=IGD1(change_conter);
 best_solution_value(t).pop_t=PF_front1; 
 end
  %***************************************************add for plot^^^^^^^^

if itrCounter1> size(t1,2)
    break
end
        if change_conter>1
        Evals_t_Evals_t_1=window*numel(t1);
         rewardVal=(((((SP_old)/((SP1(end))))-1)+(((IGD_old)/((IGD1(end))))-1)+((((MS(end)))/(MS_old))-1)))/(Evals_t_Evals_t_1);
% % % if change_conter2==num_change_reward_shap
% % % %     reward_shaping=zeros(1,2,2);  %% %%%%reward shaping++design 2
% % %     reward_shaping=ones(1,2,2);  %% %%%%reward shaping++design 1
% % % end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %   Q(prerow,precol,action) = Q(prerow,precol,action) + alpha1*((rewardVal+reward_shaping(prerow,precol,action))+gamma1*max(Q(row,col,:)) - Q(prerow,precol,action));%% %%%%reward shaping++design 2
     Q(prerow,precol,action) = Q(prerow,precol,action) + alpha1*(rewardVal+gamma1*max(Q(row,col,:)) - Q(prerow,precol,action));%% %%%%Q_value_function   
                %%%%%%%%%%%
%                 Q
%                 epsilon
%                 rewardVal
             if rand>=epsilon   % exploit
             [val,index] = max(Q(row,col,:));
        [xx,yy] = find(Q(row,col,:) == val);
        if size(yy,1) > 1            
            index = 1+round(rand*(size(yy,1)-1));
            action = yy(index,1);
        else
            action = index;
        end
         if epsilon>=0.5
            epsilon=epsilon*0.99999; % decrease epsilon
         else
             epsilon=epsilon*0.9999; % decrease epsilon
         end
         
     else        % explore
     index=    randi([1 , size(Q,3)]);
     action=index;
             if epsilon>=0.5
                epsilon=epsilon*0.99999; % decrease epsilon
             else
                epsilon=epsilon*0.9999; % decrease epsilon
             end
             end                      
            
        if row==1 && col==1 
            value_action=action_index1(index);
        end
        if row==1 && col==2
            value_action=action_index2(index);
        end
%          if row==1 && col==3
%             value_action=action_index3(index);
%         end
 end
 precol=col; prerow=row;
%*******************************Q LEARNING******$$$$$$$$$$$$$$$$$$$$$$$$$
%  emp=convert_chromosome_emp(chromosome);%new
%     nEmp=numel(emp);
%          pop=[emp(1).Imp];
%          for j=1:emp(1).nCol
%          pop=[pop;emp(1).Col(j)];
%          end
%         for k=2:nEmp
%          pop=[pop;emp(k).Imp];
%          for j=1:emp(k).nCol
%          pop=[pop;emp(k).Col(j)];
%          end
%         end
%      Archive = non_domination_sort_mod(pop, numOfObj, nVar);
        chromosome= ResponseMechanism(chromosome,memory,mean_ebsilon_t,ebsilon_t,value_action);

        if change_conter>1
        memory=Update_Memory(memory,PF_front1,round(nPop/3));
        end
        end
        end     
    
%_++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if n_p==1 
    parent_chromosome = tournament_selection(chromosome, pool, tour);
    end
    offspring_chromosome = ...
        genetic_operator(parent_chromosome, ...
        numOfObj, nVar, mu, mum, VarMin, VarMax, itrCounter);
        if n_p==1
            intermediate_chromosome=offspring_chromosome;
    else
    intermediate_chromosome=[intermediate_chromosome;offspring_chromosome];   
        end

    %%%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
  end
     if itrCounter1>= size(t1,2)
    break
      end
    intermediate_chromosome=[intermediate_chromosome;chromosome(:,1:numOfObj+ nVar)];
    intermediate_chromosome = ...
        non_domination_sort_mod1(intermediate_chromosome, numOfObj, nVar);
    chromosome = replace_chromosome(intermediate_chromosome, numOfObj, nVar, nPop);
%        time_run1=toc
%+++++++++++%    [Archive , PF_front1]=finalPFpreviouseChenge(chromosome);
num_feasibility=0;
                num_feasibility=numel(find( chromosome(:,(numOfObj+nVar+3))==0));
if (( First_Chenge==true) || ((num_feasibility< (nPop/4))))     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Combine APF+CDP
                    chromosome = non_domination_sort_mod1_First_Change(chromosome, numOfObj, nVar);
             First_Chenge=false;       
else
                    chromosome = non_domination_sort_mod1(chromosome, numOfObj, nVar);
end
%                 Archive=chromosome;
                Best_solution_index=find(chromosome(:,end)==0 & chromosome(:,(numOfObj+nVar+1))==1);
PF_front1=chromosome(Best_solution_index,:);
%+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%+++++++++++++++++++++++++++++++++for plot IGD++++++++++++++++++++++++++++++++++++++++++++++++
if numel(PF_front1(:,1))>=1
 best_solution_IGD(1,itr)=PlotFrontSolution_for_plot_IGD(PF_front1,value_move,t);
else
  best_solution_IGD(1,itr)=best_solution_IGD(1,itr-1);
end
%++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
t_old=t;
t_step=t_step+(1/window);
if find( t1(1,:)==floor(t_step))
    index11=t1(find( t1(1,:)==floor(t_step)));
    t= t1(1,index11);
%     itrCounter1=itrCounter1+1   
end
itr=itr+1;
t;
 end
%  toc
%  break
 %+++++++++++++++++++++++++++++++++for plot IGD++++++++++++++++++++++++++++++++++++++++++++++++
 if run_t==1
   total_soul_IGD=best_solution_IGD;
 else
        total_soul_IGD=mean([total_soul_IGD;best_solution_IGD],1);
 end
 %++++++
IGD1(find(IGD1==0))=[];
SP1(find(SP1==0))=[];
MS(find(MS==0))=[];
HV_ratio(find(HV_ratio==0))=[];

meanIGD=mean(IGD1);
StdIGD=std(IGD1);
SP1=SP1;
meanSP=mean(SP1);
StdSP=std(SP1);
meanMS=mean(MS);
StdMS=std(MS);
meanHV_ratio=mean(HV_ratio);
StdHV_ratio=std(HV_ratio);
disp(['IGD_Metric=   '  num2str(   IGD1)   ,    '  meanIGD  =   ',num2str(meanIGD),'   StdIGD =   ',num2str(StdIGD)]);
disp(['SP1 Metric  =   ',num2str(SP1),'   meanSP = ',num2str(meanSP),'   StdSP  = ',num2str(StdSP)]);
disp(['MS Metric =  ',num2str(MS),'   meanMS  =  ',num2str(meanMS),'  StdMS   =  ',num2str(StdMS)]);
disp(['HV_ratio Metric =  ',num2str(HV_ratio),'   meanHV_ratio  =  ',num2str(meanHV_ratio),'  StdHV_ratio   =  ',num2str(StdHV_ratio)]);

% if numel(IGD1)==step
 %***************************************************add for plotVVVVVVV

total_IGD(run_t)=meanIGD;
total_sp(run_t)=meanSP;
total_ms(run_t)=meanMS;
total_HV_ratio(run_t)=meanHV_ratio;

% % num_plot=numel(IGD1);
% %     run_t1=run_t1+1;
% % T_IGD1(run_t1,1:num_plot)=IGD1;
% % T_SP1(run_t1,1:num_plot)=SP1;
% % T_MS(run_t1,1:num_plot)=MS;
% % meanT_IGD1= mean(T_IGD1)
% % meanT_SP1= mean (T_SP1)
% % meanT_MS=mean (T_MS)
% end

% MS=[];
% SP1=[];
% IGD1=[];
run_t
 end
total_IGD_mean=mean(total_IGD);
total_IGD_std=std(total_IGD);
total_sp_mean=mean(total_sp);
total_sp_std=std(total_sp);
total_ms_mean=mean(total_ms);
total_ms_std=std(total_ms);
total_HV_ratio_mean=mean(total_HV_ratio);
total_HV_ratio_std=std(total_HV_ratio);
disp([   '  meanIGD  =   ',num2str(total_IGD_mean),'   StdIGD =   ',num2str(total_IGD_std)]);
disp(['   meanSP = ',num2str(total_sp_mean),'   StdSP  = ',num2str(total_sp_std)]);
disp(['   meanMS  =  ',num2str(total_ms_mean),'  StdMS   =  ',num2str(total_ms_std)]);
disp(['   meanHV_ratio  =  ',num2str(total_HV_ratio_mean),'  StdMS   =  ',num2str(total_HV_ratio_std)]);

text1=strcat('total_IGD_',num2str(TestProblem),num2str(window),'.mat');
save (text1,'total_IGD');
text1=strcat('total_sp',num2str(TestProblem),num2str(window),'.mat');
save (text1,'total_sp');
text1=strcat('total_ms',num2str(TestProblem),num2str(window),'.mat');
save (text1,'total_ms');
text1=strcat('total_HV_ratio',num2str(TestProblem),num2str(window),'.mat');
save (text1,'total_HV_ratio');

text2=strcat('best_solution_value',num2str(TestProblem),num2str(window),'.mat');
save (text2,'best_solution_value');

 for t=2:5
           L2=1;
        for l1=1:numel(best_solution_value(t).pop_t(:,1))
        Best_soution_Cost(L2,:)=real([best_solution_value(t).pop_t(l1,nVar+1:numOfObj+nVar)]);       
        L2=L2+1;
        end
                 title(' penalty function');
   plot (Best_soution_Cost(:,1),Best_soution_Cost(:,2),'r.'); 
   clear Best_soution_Cost 
 end
 %***************************************************add for plot^^^^^^^^^^^^^^^
  %+++++++++++++++++++++++++++++++++for plot IGD++++++++++++++++++++++++++++++++++++++++++++++++
for i=1:numel(total_soul_IGD)
        total_soul_IGD_(i,1)=total_soul_IGD(1,i);
    total_soul_IGD_(i,2)=i;
end
text1=strcat('total_soul_IGD_',num2str(TestProblem),num2str(window),'.mat');
 save (text1,'total_soul_IGD_');
  figure('Color',[1,1,1]);
         title(' penalty function');
   plot (  total_soul_IGD_(:,2),total_soul_IGD_(:,1),'r'); 
   %++++++++++++++
