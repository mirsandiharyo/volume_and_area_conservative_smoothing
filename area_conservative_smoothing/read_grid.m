% Read the grid from the input file. 
% Each marker element consists of two points (vertices). 
% The points are stored in counter-clockwise direction for consistent
% calculation of normal vector.
function[marker, point] = read_grid()
    origin_path = pwd;
    disp('choose the input file (.txt)');
    [input_name, file_path] = uigetfile('.txt');
    cd(file_path);
    fid = fopen(input_name);
    % read the marker elements
    read_line = regexp(fgetl(fid), '\t', 'split');
    marker.total = str2double(read_line{2});
    marker.vertex = zeros(marker.total, 2);
    fgetl(fid);
    % each marker has two vertices
    for num=1:marker.total
        read_line = regexp(fgetl(fid), '\t', 'split');
        marker_num = str2double(read_line{1});
        marker.vertex(marker_num, 1) = str2double(read_line{2});
        marker.vertex(marker_num, 2) = str2double(read_line{3});    
    end
    fgetl(fid);
    % read the point coordinates
    read_line = regexp(fgetl(fid), '\t', 'split');
    point.total = str2double(read_line{2});
    point.coord = zeros(point.total, 2);
    fgetl(fid);
    for num=1:point.total
        read_line = regexp(fgetl(fid), '\t', 'split');
        point_num = str2double(read_line{1});
        % x and y coordinates
        point.coord(point_num, 1) = str2double(read_line{2});
        point.coord(point_num, 2) = str2double(read_line{3});    
    end
    fclose(fid);
    cd(origin_path);
end