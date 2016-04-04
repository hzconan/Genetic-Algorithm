function ppl=Scaled_Rank(y,n,ppl,index)       % fitness assignment based on rank
if index==0,           % not index==1 since it is 1 over something....
    [y_sort, perm]=sort(y,'descend');
else,
    [y_sort, perm]=sort(y);
end

raw_rank=[1:n];
scaled_rank=1./((raw_rank).^(1/2));          % it is one over something...
raw_dst(perm)=scaled_rank/sum(scaled_rank); 

dst=cumsum(raw_dst);   
r=rand(1,n-1);
for i=1:n-1,
    j=find(r(i)<=dst,1);  
    new_ppl(i,:)=ppl(j,:);
end
new_ppl(n,:)=ppl(perm(1),:);  %make sure the best is always selected!   Here not ppl(perm(end),:) since it is 1 over something....
ppl=new_ppl;
end
