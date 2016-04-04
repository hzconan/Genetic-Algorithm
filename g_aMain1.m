function [ppl_1,x_1,y_1]=g_aMain1(index,n,p_c,p_m,num_var,num_dgt,x_lo,m,precision,f,ppl,count_max)

%===============Initial Population============================
x=bn2de(ppl,x_lo,precision,m,num_var);
y=f(x);                                        
[f_min, ind1]=min(y);
[f_max,ind2]=max(y);
x_min=x(ind1,:);
x_max=x(ind2,:);
f_mean=[mean(y)+1 ; mean(y)];  % to dissatisfy the convergence criteria

record=[];
record1=[];
count=0;
tic();

while f_mean(end-1)~=f_mean(end) & count<count_max,        %convergence critera
%==============Fitness Scaling==========================
count=count+1;

%fitness=Ranking(y,index);
%fitness=Scaled_Ranking(y,index);
fitness=Linear_Scaling(y,index);
%============== Selection================
%ppl=Scaled_Rank(y,n,ppl,index); 
ppl=Roulette(fitness,n,ppl); 
%=============== Crossover================
ppl_store=ppl;
r=randsample(n,2*round(n*p_c/2));     %indices of rows to be mated.

ppl=DPCross(ppl,r,m,num_var);
ppl_2n=[ppl_store;ppl(r,:)];
%=============== Mutation and Replacement================
mut_2n=Mut(ppl_2n,p_m);
sample=unique([ppl_2n; mut_2n],'rows');
[num_sample,k]=size(sample);
if num_sample<n,
    ppl=[sample; rand(n-num_sample,k)>0.5];
    x=bn2de(ppl, x_lo,precision,m,num_var);
    y=f(x);
elseif num_sample>n,
    x_sample=bn2de(sample, x_lo,precision,m,num_var);
    y_sample=f(x_sample);
    [y_sort, idx]=sort(y_sample);
    x_sort=x_sample(idx,:);
    x=x_sort(1:n,:);
    ppl_sort=sample(idx,:);
    ppl=ppl_sort(1:n,:);
    y=y_sort(1:n);
else,
    ppl=sample;
    x=bn2de(ppl, x_lo,precision,m,num_var);
    y=f(x);
end

%================Statistics====================

[y_min, ind_min]=min(y);
[y_max, ind_max]=max(y);
f_mean=[f_mean; mean(y)];

if index==1,
    x_min=[x_min; x(ind_min,:)];
    f_min=[f_min; y_min];
else
    x_max=[x_max; x(ind_max,:)];
    f_max=[f_max; y_max];
end
%==========================================

end  
elapsed_time=toc();
f_mean=f_mean(2:end); %get rid of the first row.

scatter(0:count,log(f_mean),30,'b*')
hold on;
scatter(0:count,log(f_min),30,'k*')

xlabel('Generations')
ylabel(' log(Fitness)')
legend('Average fitness','Best fitness')
%title('Fitness Tracking')
%axis equal
hold off;

if index==1,
    x_1=x_min(end,:);
    y_1=f_min(end);
    ppl_1=ppl(ind_min,:);
else,
    x_1=x_max(end,:);
    y_1=f_max(end);
    ppl_1=ppl(ind_max,:);
end

end