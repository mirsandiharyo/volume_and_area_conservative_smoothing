% Calculate the distance between two points.
function [distance] = calculate_distance(num1, num2, point)
    distance = sqrt((point.coord(num1, 1)-point.coord(num2, 1))^2 + ...
                    (point.coord(num1, 2)-point.coord(num2, 2))^2);
end