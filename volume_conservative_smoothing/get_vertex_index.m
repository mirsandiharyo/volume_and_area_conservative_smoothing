% Retrieve the index of the neighbouring vertex.
function[index] = get_vertex_index(vertex, i)
    index = mod(vertex, 3)+i;
    if (index == 4)
        index = 1;
    end
end