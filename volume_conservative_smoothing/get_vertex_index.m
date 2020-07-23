% Retrieve the indices of neighboring vertices
function[store_idx, next_idx] = get_vertex_index(centroid_idx)
    if (centroid_idx == 1)
        store_idx = 2;
        next_idx = 3;
    elseif (centroid_idx == 2)
        store_idx = 3;
        next_idx = 1;
    else
        store_idx = 1;
        next_idx = 2;
    end
end