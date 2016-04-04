function [neighbour] = nb(r,num_var) 
first_q = intpartition(r,num_var); 
len=length(first_q);
neighbour=[];
for i=1:len,
    neighbour=[neighbour ; mirror(first_q(i,:))];
end 


% r is distance from initial point,   
%mirror function list all the reflections along all axes
%decompose r into non-negative integers

%scatter(neighbour(:,1), neighbour(:,2),'b');
%hold on
%plot(0,0,'b*')
%scatter3(neighbour(:,1), neighbour(:,2),neighbour(:,3));
%hold on
%plot3(0,0,0,'b*')



%[x,y] = meshgrid([-2:.2:2]);
%z = x.*exp(-x.^2-y.^2);
%surf(x,y,z,gradient(z))
%hold on
%[a,b]=find(z==max(max(z)))
%plot3(x(a,b),y(a,b),z(a,b),'b*','MarkerSize',10)