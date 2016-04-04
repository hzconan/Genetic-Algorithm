function [ fitness ] = SigmaTruncation(y)
c=2;   %1<=c<=3

f_av=mean(y);
sgm=std(y);
test=y-(f_av-c*sgm);
fitness=test.*(test>0);

end

