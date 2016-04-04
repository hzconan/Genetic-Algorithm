function ppl=Mut(ppl,p_m)  %bit-wise operation
[n,k]=size(ppl);
ind =find(rand(n,k)<p_m);               
ppl(ind)=1-ppl(ind);                         %flip a bit
%mute_bit=length(ind)/(n*k);
end