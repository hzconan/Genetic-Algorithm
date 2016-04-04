function ppl=de2bn(x,x_lo,precision,m,num_var)  %floor version
m_1=cumsum(m);
m_2=m_1-m+1;
k=sum(m);

ppl=ones(size(x,1),k);
for i=1:num_var,
    ppl(:, m_2(i):m_1(i) )=de2bi(floor((x(:,i)-x_lo(i))/precision(i)),m(i));
end