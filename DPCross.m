function ppl=DPCross(ppl,r,m,num_var) %Two-point Crossover
mating_size=length(r);
m_1=cumsum(m);
m_2=m_1-m+1;
m_3=m_1-1;
for j=1:num_var,
    c=sort(randsample(m_2(j):m_3(j), 2));     %cross site/cutting point 
    for i=1:(mating_size/2),
        ppl([r(2*i-1),r(2*i)], c(1)+1:c(2))=ppl([r(2*i),r(2*i-1)],c(1)+1:c(2));
    end
end




%sort quicker than c(1)=min(c) c(2)=max(c)
%“‘«∞ «ppl([r(2*i-1),r(2*i)], c(1)+1:c(2))=ppl([r(2*i),r(2*i-1)],c(1)+1:c(2));