function new_ppl=Tournament(y,n,ppl) 
num_cpt=3;    % No. of competitor

for i=1:n,
r=randsample(n,num_cpt);%without replacement
%r=randsample(n,num_cpt,true )%with replacement
[~,ind]=min(y(r));
new_ppl(i,:)=ppl(r(ind),:);
end

end


