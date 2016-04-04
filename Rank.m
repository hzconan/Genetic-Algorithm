function ppl=Rank(y,n,ppl,index)       % fitness assignment based on rank
if index==1,           
    [y_sort, perm]=sort(y,'descend');
else,
    [y_sort, perm]=sort(y);
end

raw_rank=[1:n];
raw_dst(perm)=raw_rank/sum(raw_rank); 

dst=cumsum(raw_dst);   
r=rand(1,n-1);
for i=1:n-1,
    j=find(r(i)<=dst,1);  
    new_ppl(i,:)=ppl(j,:);
end
new_ppl(n,:)=ppl(perm(end),:);  
ppl=new_ppl;
end
