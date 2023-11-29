%%%in the name of god

function [flag_change,ebsilon_t]=ChangeDetection(popt)
    global ProblemSettings numOfObj nPop 
    CostFunction=ProblemSettings.CostFunction;
    nVar=ProblemSettings.nVar;
ebsilon_t=0;
%  feasibility_num=0;

    flag_change=false;
  npop=numel(popt(:,1));
  %normalization cost
      min_Cost=(min(popt(:,nVar+1:numOfObj+nVar)));
    max_Cost=(max(popt(:,nVar+1:numOfObj+nVar)));

mines1=  [max_Cost-min_Cost];
%    if size( mines1,2)<2
%        m=0;
%    end
% 
%     if mines1(1,1)==0
%         mines1(1,1)=0.01;
%     end

for i=1: size(popt,1)
%     for j=1:numOfObj
x_norm(i,:)=popt(i,:);
x_norm(i,nVar+1:numOfObj+nVar)=(popt(i,nVar+1:numOfObj+nVar)-min_Cost)./(mines1);
end  
%     rnd_index=randperm(npop,floor(npop/10));
n_change=round(npop/10);
    popt=popt(1:n_change,:);
    popt2=x_norm(1:n_change,:);

%   for i=1:numel(rnd_index)
% change_val=    change_val+sum(abs(dif1(i,:)-u));    
%   end
%     change_val=change_val/(*numOfObj);
%   popt=popt(rnd_index,:);

  for i=1:n_change
    if  ~ isequal( popt(i,nVar+1:numOfObj+nVar) , CostFunction(popt(i,1:nVar)))
flag_change=true;
break;
    end
  end
  if flag_change==true
    dif1=zeros([1,numOfObj]);
    change_val=0;
      u=(max(popt(:,nVar+1:numOfObj+nVar)));
    L=(min(popt(:,nVar+1:numOfObj+nVar)));
  for i=1:n_change
     dif1=dif1+  (abs(( popt(i,nVar+1:numOfObj+nVar)- CostFunction(popt(i,1:nVar)))./(u-L)));
  end
  ebsilon_t=sum(dif1)/(numOfObj*numel(n_change));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%% feasibility rate %%%%%%%%%%%%%%%%%%%%%%%
%    for i=1:nPop
% v(i)=check_feasibility(popt(i,1:nVar));
% if v(i)<=0
%     feasibility_num=feasibility_num+1;
%   end
%    end
  end
  
  
  
  