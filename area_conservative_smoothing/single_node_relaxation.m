% Perform single-node relaxation.
function[point] = single_node_relaxation(x0, x1, x2, point)
    % calculate the distance between x2 and x0
    dist_x20 = calculate_distance(x2, x0, point);
    % calculate the unit normal of x2 and x0 */
    norm_x20 = calculate_normal(x0, x2, point);
    norm_x20 = norm_x20/norm(norm_x20);          
    % calculate the signed area of triangle (x0,x1,x2)
    vec_x10 = substract_points(x0, x1, point);
    vec_x20 = substract_points(x0, x2, point);
    % determine point perpendicular to vec_x20
    perp_vec_x20(1) = -vec_x20(2);
    perp_vec_x20(2) =  vec_x20(1);
    area = 0.5*dot(perp_vec_x20, vec_x10);
    % calculate the height above the base line
    height = 2*area/dist_x20;   
    % displace the points
    for i=1:2
        point.coord(x1, i) = 0.5*(point.coord(x0, i)+ ... 
            point.coord(x2, i)) + (height*norm_x20(i));
    end 
end