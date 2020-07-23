% Copy the coordinates of an array to a point in structure array.
function[point] = copy_from_array(num, point, array)
    for i=1:3
        point.coord(num, i) = array(i);
    end
end