%% 
% Volume conserving smoothing of surface grids using two nodes relaxations.
% The code can handle closed and non-closed surfaces.
% Reference: Kuprat et al., J Comput. Phys., 172 (2001), 99-118.
% Created by: Haryo Mirsandi

close all;
clearvars;
mkdir output;
delete output/iter_*;

%% set the smoothing parameter and method
global max_neighbor
max_neighbor = 20; % maximum neighboring points
max_iter = 200;    % maximum iteration
two_nodes = true;  % if false then single node relaxation is used
read_file = false; % if true then it will read the input file 
omega = 1;         % relaxation parameter (0 <= omega <= 1)
output_freq = 10;  % output frequency

%% read the grid
if (read_file)
    [marker, point] = read_grid();
else
    [marker, point] = create_cuboid_grid();
end

%% visualize the initial grid
% set the boundary for visualization
[xmin, xmax, ymin, ymax, zmin, zmax] = set_boundary(point);
visualize_grid(marker.vertex, point.coord, xmin, xmax, ymin, ymax, ...
    zmin, zmax, 0);

%% create point connectivity
point = create_point_connectivity(marker, point);

%% perform the smoothing
for iter=1:max_iter
    for num1=1:point.total
        % two nodes relaxation
        % avoid edge point
        if (point.pt_count(num1) ~= -1)
            for count=1:point.pt_count(num1)
                num2 = point.connect_pt(num1, count);
                if (point.pt_count(num2) ~= -1)
                    % only for higher ID
                    if (num1 < num2)
                        point = two_nodes_relaxation(num1, num2, point, omega);
                    end
                end
            end
        end
    end
    % visualize the grid
    if (mod(iter, output_freq) == 0)
        visualize_grid(marker.vertex, point.coord, xmin, xmax, ymin, ymax, ...
        zmin, zmax, iter);
    end
end
