% Store two neighbouring points of a given point.
% The points in the clockwise and counter-clockwise directions of the given 
% point are stored in the first and second elements, respectively.
function[point] = create_point_connectivity(marker, point)
    point.connectivity = zeros(point.total, 2)-1;
    for num=1:marker.total
        vertex1 = marker.vertex(num, 1);
        vertex2 = marker.vertex(num, 2);
        point.connectivity(vertex1, 2) = vertex2;
        point.connectivity(vertex2, 1) = vertex1;    
    end
end