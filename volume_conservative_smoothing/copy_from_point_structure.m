% Copy the coordinates from a point in structure array.
function[result] = copy_from_point_structure(num, point)
    result = zeros(3, 1);
    for i=1:3
        result(i) = point.coord(num, i);
    end
end