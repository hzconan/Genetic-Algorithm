function new_ppl=  Roulette_SUS(fitness,n,ppl)   

raw_dst=fitness/sum(fitness);
%dst=tril(ones(n))*raw_dst         %using lower matrix to create cumulative distribution
dst=cumsum(raw_dst);


interval=1/n;          % n is the size of the population
r_0=interval*rand;  % r_0 is the starting point; 'rand' returns a number uniformly distributed on [0,1]
r=r_0: interval: r_0+(n-1)*interval;

for i=1:n,
    j=find(r(i)<=dst,1);
    new_ppl(i,:)=ppl(j,:);
end
end