function ppl=UCross(ppl,mating_size,r,k)

w=rand(1,k)>0.5;   %0.5 control the probability of generating 0s and 1s.
ind=find(w==1);

for i=1:(mating_size/2),
    ppl([r(2*i-1),r(2*i)], ind)=ppl([r(2*i),r(2*i-1)], ind);
end
end