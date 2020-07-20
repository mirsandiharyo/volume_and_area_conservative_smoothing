% Perform two nodes relaxation.
function[point] = two_nodes_relaxation(x0, x1, x2, x3, point)
    % calculate the distance between x3 and x0
    dist_x30 = calculate_distance(x3, x0, point);
    % calculate the unit normal of x3 and x0 */
    norm_x30 = calculate_normal(x0, x3, point);
    norm_x30 = norm_x30/norm(norm_x30);          
    % calculate the signed area of quad (x0,x1,x2,x3)
    vec_x10 = substract_points(x0, x1, point);
    vec_x20 = substract_points(x0, x2, point);
    vec_x30 = substract_points(x0, x3, point);
    % determine point perpendicular to vec_x20 and vec_x30
    perp_vec_x20(1) = -vec_x20(2);
    perp_vec_x20(2) =  vec_x20(1);
    perp_vec_x30(1) = -vec_x30(2);
    perp_vec_x30(2) =  vec_x30(1);
    area = (0.5*dot(perp_vec_x30, vec_x20))+(0.5*dot(perp_vec_x20, vec_x10));
    % calculate the height above the base line
    height = 1.5*area/dist_x30;   
    % displace the points
    for i=1:2
        point.coord(x1, i) = (2/3*point.coord(x0, i))+ ...
                             (1/3*point.coord(x3, i))+(height*norm_x30(i));
        point.coord(x2, i) = (1/3*point.coord(x0, i))+ ...
                             (2/3*point.coord(x3, i))+(height*norm_x30(i));
    end 
end