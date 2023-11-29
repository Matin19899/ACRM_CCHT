%%%in the name of god

% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA118
% Project Title: Implementation of Imperialist Competitive Algorithm (ICA)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%
function violation=check_feasibility(x)
    global ProblemSettings TestProblem itrCounter window step  t;
    CostFunction=ProblemSettings.CostFunction;
    nVar=ProblemSettings.nVar;
    VarSize=ProblemSettings.VarSize;
    VarMin=ProblemSettings.VarMin;
    VarMax=ProblemSettings.VarMax;
%                   t =floor(itrCounter/window);
f=CostFunction(x);
target=0;

                  if TestProblem>41  &&  TestProblem<71
       if  TestProblem == 42
s_t=max(3.5-0.14*t,0.7+0.14*t);%                 
m_t=max(1.43-0.05*t,-0.43+0.05*t);     %  
Wt=2;%
target=0;
   elseif   TestProblem ==52
           s_t=max(2.5-0.05*t,1.5+0.05*t);%                 
m_t=max(1.16-0.075*t,-0.34+0.075*t);     %  
Wt=2;%
target=TestProblem;
   elseif   TestProblem==53
s_t=max(2.1+0.14*t,4.9-0.14*t);%                 
m_t=max(0.93+0.05*t,1.93-0.05*t);     %  
Wt=2;%  
target=TestProblem;
   elseif   TestProblem==54
s_t=max(2+0.05*t,3-0.05*t);%                 
m_t=max(0.41+0.075*t,1.91-0.075*t);     %  
Wt=2;%
target=TestProblem;
   elseif  TestProblem == 55
 s_t=max(3.5-0.14*t,0.7+0.14*t);%     

m_t=max(1.43-0.05*t,0.43+0.05*t);     %  
Wt=6*sin(0.2*pi*(t+1));%
t=floor(itrCounter/window);

target=TestProblem;
   elseif   TestProblem ==56
           s_t=max(2.5-0.05*t,1.5+0.05*t);%                 
m_t=max(1.16-0.075*t,-0.34+0.075*t);     %  
Wt=6*sin(0.2*pi*(t+1));%
target=TestProblem;
   elseif   TestProblem==57
s_t=max(2.1+0.14*t,4.9-0.14*t);%                 
m_t=max(0.93+0.05*t,1.93-0.05*t);     %  
Wt=6*sin(0.2*pi*(t+1));%
target=TestProblem;
   elseif   TestProblem==58
s_t=max(2+0.05*t,3-0.05*t);%                 
m_t=max(0.41+0.075*t,1.91-0.075*t);     %  
Wt=6*sin(0.2*pi*(t+1));%
target=TestProblem;
       end
                  end          
    if TestProblem >=71
if  TestProblem==71
    D=30;  
elseif  TestProblem==72
    D=30;  C=1; a=0.2; b=10; c=1; d=6; e=1; teta=-0.2*pi;
elseif  TestProblem==73
    D=30;  C=1; a=0.1; b=10; c=1; d=0.5; e=1; teta=-0.2*pi;
elseif  TestProblem==74
    D=30;  C=1; a=0.75; b=10; c=1; d=0.5; e=1; teta=-0.2*pi;
elseif  TestProblem==75
    D=30;  C=1; a=0.1; b=10; c=2; d=0.5; e=1; teta=-0.2*pi;%%c=1;
elseif  TestProblem==76
    D=30;  C=1; a=40; b=0.5; c=1; d=2; e=-2; teta=0.1*pi;
elseif  TestProblem==77
    D=30;  C=1; a=40; b=5; c=1; d=6; e=0; teta=-0.05*pi;
elseif  TestProblem==78
    D=30;  C=2; a=40; b=0.5; c=1; d=2; e=-2; teta=-0.1*pi;
                  
end                                                                                           
    end       
   if TestProblem == 71      
       violation=0;
       constrain1=(f(2)/t)-(0.858*exp(-0.541*f(1)));
constrain2=(f(2)/t)-(0.728*exp(-0.295*f(1)));
%        violation=[constrain1,constrain2];   
if constrain1<0
              violation=violation+abs(constrain1);        
end
if constrain2<0
              violation=violation+abs(constrain2);        
end
   
   elseif TestProblem ==72   
          violation=0;
 exp1= (((f(2)/t-e)*cos(teta))-(f(1)*sin(teta)));
exp2=((f(2)/t-e)*sin(teta)+(f(1)*cos(teta)));
exp2=b*pi*(exp2).^c;
exp2=abs(sin(exp2));
exp2=a*exp2^d;
constrain1=(exp1-exp2);
if constrain1<0
       violation=abs(constrain1);        
end
   elseif TestProblem ==73  
          violation=0;
 exp1= (((f(2)/t-e)*cos(teta))-(f(1)*sin(teta)));
exp2=((f(2)/t-e)*sin(teta)+f(1)*cos(teta));
exp2=b*pi*(exp2).^c;
exp2=abs(sin(exp2));
exp2=a*exp2^d;
constrain1=(exp1-exp2);
if constrain1<0
       violation=abs(constrain1);        
end
   elseif TestProblem ==74
          violation=0;
 exp1= (((f(2)/t)-e)*cos(teta))-(f(1)*sin(teta));
exp2=(((f(2)/t)-e)*sin(teta))+f(1)*cos(teta);
exp2=b*pi*(exp2).^c;
exp2=abs(sin(exp2));
exp2=a*exp2^d;
constrain1=(exp1-exp2);
if constrain1<0
       violation=abs(constrain1);        
end
   elseif TestProblem ==75
          violation=0;
 exp1= ((f(2)/t-e)*cos(teta))-(f(1)*sin(teta));
exp2=((f(2)/t-e)*sin(teta))+f(1)*cos(teta);
exp2=b*pi*(exp2).^c;
exp2=abs(sin(exp2));
exp2=a*exp2^d;
constrain1=(exp1-exp2);
if constrain1<0
       violation=abs(constrain1);        
end
   elseif TestProblem ==77 
          violation=0;
 exp1= (((f(2)/t)-e)*cos(teta))-(f(1)*sin(teta));
exp2=(((f(2)/t)-e)*sin(teta))+(f(1)*cos(teta));
exp2=b*pi*(exp2).^c;
exp2=abs(sin(exp2));
exp2=a*exp2^d;
constrain1=(exp1-exp2);
if constrain1<0
       violation=abs(constrain1);        
end
   elseif TestProblem ==76
          violation=0;
 exp1= (((f(2)/t)-e)*cos(teta))-(f(1)*sin(teta));
exp2=(((f(2)/t)-e)*sin(teta))+(f(1)*cos(teta));
exp2=b*pi*(exp2).^c;
exp2=abs(sin(exp2));
exp2=a*exp2^d;
constrain1=(exp1-exp2);
exp3=(((f(2)/t)-e)*sin(teta))+(f(1)*cos(teta));
if constrain1<0
       violation=abs(constrain1);        
end

   end
   

   
%               switch TestProblem
%         case target
%                n   =length(x);
%         f1  =x(1);
% %          t  =(floor(itrCounter/window))/step;
% % t=floor(itrCounter/window);
% %           t            =2*floor(itrCounter/window)*(window/(step*window-window));
% n=10; %Variable number
% ata=0.4;
% fi=6;
% teta=-0.25*pi;
% a=0.2;
% b=1;
% c=1;
% d=0.5;
% e=1;
% tetap=-pi*1/16;
% At=0.05;
% %^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
% h=x(1);
% g=sum((x(2:n)-(1-0.9*sin(0.2*pi*t))).^2);
% % Wt=6*sin(0.2*pi*(t+1));
% % Wt=2;
%  z_t=6;
% %  s_t=1;
% % s_t=max(3.5-0.14*t,0.7+0.14*t);
% % m_t=max(1.43-0.05*t,0.43+0.05*t);
% %^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
% %^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
% f1=(1+g)*(h+At*sin(Wt*pi*h));
% f2=(1+g)*(s_t-h+At*sin(Wt*pi*h));
% %-------------------------------------------------   
% g1=max(0, (a*(abs(sin(b*pi*(sin(tetap)*(f2-e)+cos(tetap)*f1)^c)))^d)-(cos(teta)*(f2-e)-sin(teta)*f1-m_t));
% g2= max(0,0+(f1+f2-z_t));
% g3=max(0,(m_t-z_t));
% 
% % % % %        violation=g1+g2+g3;        
% % violation=0;
%               end
% if ((violation))>0
%     pppp=0;
% end
%                   
%                   