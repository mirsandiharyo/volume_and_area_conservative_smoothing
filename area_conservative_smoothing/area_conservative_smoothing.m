%% 
% Area conserving smoothing of curve grids using single node 
% or two nodes relaxations.
% Reference: Kuprat et al., J Comput. Phys., 172 (2001), 99-118.
% Created by: Haryo Mirsandi

close all;
clearvars;
mkdir output;
delete output/iter_*;

%% set the smoothing parameter and method
max_iter = 50;
two_nodes = true; % if false then single node relaxation is used.

%% read the grid
[marker, point] = read_grid();

%% visualize the initial grid
% set the boundary for visualization
[xmin, xmax, ymin, ymax] = set_boundary(point);
visualize_grid(point.coord, xmin, xmax, ymin, ymax, 0);

%% create point connectivity
point = create_point_connectivity(marker, point);
