%% 
% Volume conserving smoothing of surface grids using single node 
% or two nodes relaxations.
% Reference: Kuprat et al., J Comput. Phys., 172 (2001), 99-118.
% Created by: Haryo Mirsandi

close all;
clearvars;
mkdir output;
delete output/iter_*;

%% set the smoothing parameter and method
max_iter = 20;

%% read the grid
[marker, point] = read_grid();

%% visualize the initial grid
% set the boundary for visualization
[xmin, xmax, ymin, ymax, zmin, zmax] = set_boundary(point);
visualize_grid(marker.vertex, point.coord, xmin, xmax, ymin, ymax, ...
    zmin, zmax, 0);
