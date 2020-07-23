% Calculate the normal vector of a line segment consists of two points.
function[norm_vec] = calculate_normal(num1, num2, point)
    norm_vec = zeros(2, 1);
    norm_vec(1) = -(point.coord(num2, 2) - point.coord(num1, 2));
    norm_vec(2) =  (point.coord(num2, 1) - point.coord(num1, 1));
end 