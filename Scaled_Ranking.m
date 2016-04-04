function fitness=Scaled_Ranking(y,index)       % fitness assignment based on rank
%================Normalization===============
n=length(y);

if index==0,          % not index==1 since it is 1 over something....
    [y_sort, perm]=sort(y,'descend');
else,
    [y_sort, perm]=sort(y);
end

% sp=2.0;    % selection pressure 1.0<=sp<=2.0
%scaled_rank=2-sp+2*(sp-1)*(raw_rank-1)/(n-1);
%raw_dst(perm)=scaled_rank / sum(scaled_rank);   %Note here: inverse perm!!

raw_rank=[1:n];
scaled_rank=1./((raw_rank).^(1/2));   % it is 1 over something....
fitness(perm)=scaled_rank; 
end
