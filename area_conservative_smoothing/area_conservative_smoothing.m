%% 
% Area conserving smoothing of curve grids using single node 
% or two nodes relaxations.
% % The code can handle closed and non-closed lines.
% Reference: Kuprat et al., J Comput. Phys., 172 (2001), 99-118.
% Created by: Haryo Mirsandi

close all;
clearvars;
mkdir output;
delete output/iter_*;

%% set the smoothing parameter and method
max_iter = 20;
two_nodes = true; % if false then single node relaxation is used.

%% read the grid
[marker, point] = read_grid();

%% visualize the initial grid
% set the boundary for visualization
[xmin, xmax, ymin, ymax] = set_boundary(point);
visualize_grid(point.coord, xmin, xmax, ymin, ymax, 0);

%% create point connectivity
point = create_point_connectivity(marker, point);

%% perform the smoothing
for iter=1:max_iter
    for num=1:point.total
        % retrieve the point number using the connectivity
        [x0, x1, x2, x3] = retrieve_point_num(num, point);
        if (two_nodes)
            % two nodes relaxation on x1 and x2
            % avoid edge point
            if ((x0 ~= -1) && (x3 ~= -1))
                point = two_nodes_relaxation(x0, x1, x2, x3, point);
            end           
        else
            % single node relaxation on x1
            % avoid edge point
            if ((x0 ~= -1) && (x2 ~= -1))
                point = single_node_relaxation(x0, x1, x2, point);
            end  
        end
 
    end
    % visualize the grid
    visualize_grid(point.coord, xmin, xmax, ymin, ymax, iter);
end
