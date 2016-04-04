function M = mirror(v)
    g = repmat({[-1 1]}, 1, numel(v));
   
    C = cell(1, numel(g));
    [C{:}] = ndgrid(g{:});
 
    M = cell2mat(cellfun(@(x) x(:), C, 'Uniform',false));
    M = bsxfun(@times, M, v);
    M = unique(M, 'rows');   % in case there were zeros, -0 == +0
end

