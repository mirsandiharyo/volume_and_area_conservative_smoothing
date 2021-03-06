% Perform substraction of two points.
function[result] = substract_points(num1, num2, point)
    result = zeros(3, 1);
    for i=1:3
        result(i) = point.coord(num2, i) - point.coord(num1, i);
    end
end