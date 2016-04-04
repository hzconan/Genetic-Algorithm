function x=bn2de(ppl,x_lo,precision,m,num_var)
m_1=cumsum(m);
m_2=m_1-m+1;
x=ones(size(ppl,1),num_var);
for j=1:num_var,
    x(:,j) =x_lo(j)+bi2de(ppl( :, m_2(j):m_1(j) ))*precision(j);    %bi2de, default='right-msb'
end
end