function [ initial_point, y_opt ] = hc_bound( initial_point, epsilon, f, x_lo, x_hi, index) %hill climbing
count_max=100;  %number of steps 
num_var=length(initial_point); 
neighbour= nb(1,num_var); 
n=size(neighbour,1);
y=f(initial_point);  
y_store=y; 
store=[initial_point+1; initial_point]; %make sure (initial_point+1)~=initial_point

count=0;
while prod(store(end,:)==store((end-1),:))==0 &count<count_max,
    points=repmat(initial_point, n,1)+epsilon*neighbour;
    num_points=length(points);
    idx=find(prod(points>=repmat(x_lo,num_points,1) & points<=repmat(x_hi,num_points,1),2)>0);
    points_feasible=points(idx,:);
    x_sample=[points_feasible; initial_point];
    y_sample=[f(points_feasible); y];
    
    if index==1,
        [y, ind]=min(y_sample);
    else,
        [y, ind]=max(y_sample);
    end
    initial_point= x_sample(ind,:);
    y_store=[y_store; y];
    store=[store; initial_point];
    count=count+1;
end
y_opt=y_store(end);

%f=@(x) x(:,1).*exp(-x(:,1).^2-x(:,2).^2)         %peak
%f=@(x) x(:,1).*exp(-x(:,1).^2-x(:,2).^2)+2*exp(-(x(:,1)-2.5).^2-(x(:,2)-2.5).^2)         
%[x,y] = meshgrid([-2:.1:4]);
%[0,1.5];
%[0,2];

x_store=store(2:end,:);

%scatter3(x_store(:,1), x_store(:,2),y_store);
%plot3(x_store(:,1), x_store(:,2), y_store,'b*');

%[x,y] = meshgrid([-2:.1:2]);
%z = x.*exp(-x.^2-y.^2);
%surf(x,y,z,gradient(z))
%hold on

end
