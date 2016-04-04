function [ points ] = crawl( center_point, epsilon, r )
num_var=length(center_point);
points=[center_point];           %include itself
for i=1:r,
neighbour= nb(i,num_var);
points=[points; repmat(center_point, size(neighbour,1),1)+epsilon*neighbour];
end



%scatter(points(:,1),points(:,2),'y','filled');
%hold on;
%plot(points(1,1),points(1,2),'k*');
%hold off;

%scatter3(points(:,1),points(:,2),points(:,3))
%hold on;
%plot3(points(1,1),points(1,2),points(1,3),'b*')
%hold off;

%length(points)

