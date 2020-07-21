% set the boundary for visualization
function[xmin, xmax, ymin, ymax, zmin, zmax] = set_boundary(point)
    xmin = min(point.coord(:, 1));
    xmax = max(point.coord(:, 1));
    dist_x = xmax-xmin;
    ymin = min(point.coord(:, 2));
    ymax = max(point.coord(:, 2));
    dist_y = ymax-ymin;
    zmin = min(point.coord(:, 3));
    zmax = max(point.coord(:, 3));
    dist_z = zmax-zmin;    
    xmin = xmin-(0.3*dist_x);
    xmax = xmax+(0.3*dist_x);
    ymin = ymin-(0.3*dist_y);
    ymax = ymax+(0.3*dist_y);
    zmin = zmin-(0.3*dist_z);
    zmax = zmax+(0.3*dist_z);    
end