% Set the boundary for visualization.
function[xmin, xmax, ymin, ymax, zmin, zmax] = set_boundary(point)
    factor = 0.3;
    xmin = min(point.coord(:, 1));
    xmax = max(point.coord(:, 1));
    dist_x = xmax-xmin;
    ymin = min(point.coord(:, 2));
    ymax = max(point.coord(:, 2));
    dist_y = ymax-ymin;
    zmin = min(point.coord(:, 3));
    zmax = max(point.coord(:, 3));
    dist_z = zmax-zmin;    
    xmin = xmin-(factor*dist_x);
    xmax = xmax+(factor*dist_x);
    ymin = ymin-(factor*dist_y);
    ymax = ymax+(factor*dist_y);
    zmin = zmin-(factor*dist_z);
    zmax = zmax+(factor*dist_z);    
end