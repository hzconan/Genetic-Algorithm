function [x_opt, y_opt]=g_a()

%=============== Parameter Setting=====================

index=1;   %index=1 for minimization; index=0 for maximization
n=50;         % number of individuals in a population
p_c=1;      % crossover probability, practically 0.65~0.8   
p_m=0.05; %mutation probability
repeat=3;                %number of independent evolutions of GA before local search
count_max=60;       %maximum number of generations in each evolution
epsilon1=200*10^-4;  %parameter for crawling
epsilon2=40*10^-4;    %parameter for hill climbing
r=7;  %radius for crawling


num_dgt=[4 4 4 4 4];     % decimal digits accuracy
x_lo=[-500 -500 -500 -500 -500];        %lower bound of the variables
x_hi=[500 500 500 500 500];  %upper bound of the variables 
f=@(x) 418.9829*5-x(:,1).*sin(abs(x(:,1)).^(1/2))-x(:,2).*sin(abs(x(:,2)).^(1/2))-x(:,3).*sin(abs(x(:,3)).^(1/2))-x(:,4).*sin(abs(x(:,4)).^(1/2))-x(:,5).*sin(abs(x(:,5)).^(1/2));

%=======================Test Functions==================
%f=@(x) dejong5(x)
%f=@(x) rastriginsfcn(x);                               %f(0)=0
%z=-0.0001*(abs(sin(x).*sin(y).*exp(abs(100-1/pi*(x.^2+y.^2).^(1/2))))+1).^(0.1);
%f=@(x) -0.0001*(abs(sin(x(:,1)).*sin(x(:,2)).*exp(abs(100-1/pi*(x(:,1).^2+x(:,2).^2).^(1/2))))+1).^(0.1);
%z=-(y+47).*sin((abs(x/2+y+47)).^(1/2))-x.*sin((abs(x-(y+47))).^(1/2));
%f=@(x) -(x(:,2)+47).*sin((abs(x(:,1)/2+x(:,2)+47)).^(1/2))-x(:,1).*sin((abs(x(:,1)-(x(:,2)+47))).^(1/2));

% abs(x)+cos(x);                                             %f(0)=1 -inf<x<inf     
% abs(x)+sin(x);                                              %f(0)=0 -inf<x<inf    
% x(:,1).^2+x(:,2).^2;                                      %f(0,0)=0 -inf<x<inf
% 0.5+((sin((x(:,1).^2+x(:,2).^2).^(1/2)).^2)-0.5)./(1+0.1*(x(:,1).^2+x(:,2).^2));      %f([0,0])=0 -inf<x,y<inf       
% 100*(x(:,2)-x(:,1).^2).^2+(1-x(:,1)).^2;         %f(1,1)=0   
% abs(x(:,1))-10*cos(abs(10*x(:,1)).^(1/2))+abs(x(:,2))-10*cos(abs(10*x(:,2)).^(1/2)) f(x)=-20 at x=0

% (x.^2+x).*cos(x);                                         %f(9.6204)=-100.2238 -10<x<10                     
% sin(4*x(:,1)).*x(:,2)+1.1*x(:,1).*sin(2*x(:,2));    %f(9.0400,8.6645)=-18.5916 0<x,y<10            
% 20+exp(1)-20*exp(-0.2*((x(:,1).^2+x(:,2).^2)/2).^(1/2))-exp((cos(0.5*x(:,1))+cos(0.5*x(:,2)))/2) %f(0)=0 -30<x,y<30   
% -exp(-0.2*(x(:,1).^2+x(:,2).^2).^(1/2)+3*(cos(2*x(:,1))+sin(2*x(:,2))))  %f(0,0.7687)=-345.3599 -5<x,y<5
% -x(:,1).*sin((abs(x(:,1)-(x(:,2)+9))).^(1/2))-(x(:,2)+9).*sin((abs(x(:,2)+0.5*x(:,1)+9)).^(1/2)); %f(-17.0070,2.0730)=-25.2305  -20<x,y<20
%====================================================

num_var=length(x_lo);
m=ceil(log((x_hi-x_lo).*10.^(num_dgt)+1)/log(2));
precision=(x_hi-x_lo)./(2.^m-1);
m_1=cumsum(m);
m_2=m_1-m+1;

%===============Population Initialization=======================
%k=m_1(end);                       
%ppl=rand(n,k)>0.5; %Random Initialization 
%x=bn2de(ppl,x_lo,precision,m,num_var);
%scatter(x(:,1),x(:,2),5,'r');

x=zeros(n,num_var);
x(:,1)=x_lo(1) : (x_hi(1)-x_lo(1))/(n-1) : x_hi(1);
if num_var>1,
    for i=2:num_var,
        temp =x_lo(i) : (x_hi(i)-x_lo(i))/(n-1) : x_hi(i);  %generate initial x (including boundary x_lo and x_high)
        x(:,i)=temp(randperm(n));
    end
end

%ppl=zeros(n,k);
%split=[ones(n/2,1) ; zeros(n/2,1)]; % 'split' is a vector of ones and zeros, n is the size of population
%for i=1:num_var, % num_var is the number of variables                                        
   % ppl(:,m_2(i):(m_1(i)-1)) =rand(n,m(i)-1)>0.5; %m(i) is the length of chromosome of variable i  
                                            %this step randomly initialize part of chromosome of size n*(m(i)-1)             
    %ppl(:,m_1(i))=split(randperm(n)); % fill the last column with a random permutation of vector 'split'
%end

ppl=de2bn(x,x_lo,precision,m,num_var);
%x=bn2de(ppl,x_lo,precision,m,num_var)
%scatter(x(:,1),x(:,2),5,'r')

%=============== Main Program====================================================================
x_main=ones(repeat,num_var);
y_main=ones(repeat,1);
ppl_main=ones(repeat, sum(m));

for j=1:repeat,   
[ppl_main(j,:), x_main(j,:),y_main(j)]= g_aMain1(index,n,p_c,p_m,num_var,num_dgt,x_lo,m,precision,f,ppl,count_max);
end
%===============Local Search=============================

[y_unique,perm]=unique(round(y_main,4));  %accurate to 4 decimal places
len=length(y_unique);

initial_points=x_main(perm,:)
initial_fitness=y_main(perm)

x_mut=zeros(len,num_var);
y_mut=zeros(len,1);

if index==1,
    for i=1:len, 
        x_mut1=crawl(x_main(perm(i),:), epsilon1, r );
        n_mut=length(x_mut1);
        idx1=find(prod(x_mut1>=repmat(x_lo,n_mut,1) & x_mut1<=repmat(x_hi,n_mut,1),2)>0);  %ensure that variables are crawling within the domain
        x_feasible1=x_mut1(idx1,:);
        [~,ind]=min(f(x_feasible1));
        [x_mut(i,:), y_mut(i)]=hc_bound( x_feasible1(ind,:), epsilon2, f, x_lo,x_hi, 1);  
    end
else,
    for i=1:len, 
        x_mut1=crawl(x_main(perm(i),:), epsilon1, r );
        n_mut=length(x_mut1);
        idx1=find(prod(x_mut1>=repmat(x_lo,n_mut,1) & x_mut1<=repmat(x_hi,n_mut,1),2)>0); 
        x_feasible1=x_mut1(idx1,:);
        [~,ind]=max(f(x_feasible1));
        [x_mut(i,:), y_mut(i)]=hc_bound( x_feasible1(ind,:), epsilon2,f, x_lo,x_hi,0);  %ensure that variables are crawling within the domain
    end
end

if index==1,
    [y_opt,id]=min(y_mut);
else,
    [y_opt,id]=max(y_mut);
end   
x_opt=x_mut(id,:);

end
