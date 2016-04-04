function partition= intpartition(r,num_var)   %radius 'r' for dimension 'num_var'
    partition=[];
	a = zeros(r,1);
    k = 1;
	y = r - 1;
    while k ~= 0
        x = a(k) + 1;
        k = k-1;
        while 2*x <= y
            a(k+1) = x;
            y = y - x;
            k = k + 1;
        end
        l = k + 1;
        while x <= y
            a(k+1) = x;
            a(l+1) = y;
            if k+2<=num_var,
                partition=[partition; perms([a(1:k+2)', zeros(1,num_var-(k+2))])];
            end
            x = x + 1;
            y = y - 1;
        end
        a(k+1) = x + y;
        y = x + y - 1;
        if k+1<=num_var,
            partition=[partition ; perms([a(1:k+1)', zeros(1,num_var-(k+1))])];
        end
    end
   partition=unique(partition,'rows');
end