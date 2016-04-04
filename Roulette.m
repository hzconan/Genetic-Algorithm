function ppl=Roulette(fitness,n,ppl) 

%dst=tril(ones(n))*raw_dst         %using lower matrix to create cumulative distribution
raw_dst=fitness/sum(fitness);
[~ , ind ]=max(fitness);
dst=cumsum(raw_dst);

r=rand(1,n-1);
for i=1:n-1,
    j=find(r(i)<=dst,1);  
    new_ppl(i,:)=ppl(j,:);
end
new_ppl(n,:)=ppl(ind,:);  %make sure the best is always selected!
ppl=new_ppl;
end
