function fitness=Ranking(y,index)       % fitness assignment based on rank
%================Normalization===============
n=length(y);

if index==1,          
    [y_sort, perm]=sort(y,'descend');
else,
    [y_sort, perm]=sort(y);
end

raw_rank=[1:n];
fitness(perm)=raw_rank; 
end
