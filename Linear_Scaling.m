function fitness=Linear_Scaling(y,index)
c=2;    %selection pressure   
n=length(y); 

if index==1,
    y = -y;
end

y_min=min(y);
y_max=max(y);
if y_max==y_min,          %handle y=[0,0,0,0]'
    fitness = ones(n,1);     
    return;
end

f_av= mean(y);
if f_av<=0,                         %[0 1 -1 0] for f_av=0
    y=SigmaTruncation(y);
    y_min=min(y);
    y_max=max(y);
    f_av= mean(y);
end

if y_min>=(c*f_av-y_max)/(c-1), %test: y=[1,2,2,4]' [1 2 3 90]' 
    a=f_av*(c-1)./(y_max-f_av);
    b=(y_max-c*f_av).*f_av./(y_max-f_av);
else,                                         %test: y=[-1,2,3,4]
    a=f_av./(f_av-y_min);
    b=-f_av.*y_min./(f_av-y_min);
    %c=(y_max-y_min)./(f_av-y_min)  
end
 
fitness=a*y+b;
end

        
    

