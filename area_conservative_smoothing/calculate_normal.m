% Calculate the normal vector of a line segment consists of two points.
function[norm] = calculate_normal(num1, num2, point)
    norm(1) = -(point.coord(num2, 2) - point.coord(num1, 2));
    norm(2) =  (point.coord(num2, 1) - point.coord(num1, 1));
end

        