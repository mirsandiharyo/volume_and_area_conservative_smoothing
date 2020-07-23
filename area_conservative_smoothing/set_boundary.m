% Set the boundary for visualization.
function[xmin, xmax, ymin, ymax] = set_boundary(point)
    factor = 0.1;
    xmin = min(point.coord(:, 1));
    xmax = max(point.coord(:, 1));
    dist_x = xmax-xmin;
    ymin = min(point.coord(:, 2));
    ymax = max(point.coord(:, 2));
    dist_y = ymax-ymin;
    xmin = xmin-(factor*dist_x);
    xmax = xmax+(factor*dist_x);
    ymin = ymin-(factor*dist_y);
    ymax = ymax+(factor*dist_y);
end