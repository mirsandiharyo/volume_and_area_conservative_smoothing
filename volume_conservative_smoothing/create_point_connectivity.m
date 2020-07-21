% Store the neighbouring points and markers of a given point.
function[point] = create_point_connectivity(marker, point)
    max_neighbours = 15;
    % point to point connectivity and point to marker connectivity
    [point.connect_pt, point.connect_mrk] = ...
        deal(zeros(point.total, max_neighbours)-1);
    % counters
    [point.pt_count, point.mrk_count] = deal(zeros(point.total, 1));
    for mrk_num=1:marker.total
        for vertex=1:3
            pt_num = marker.vertex(mrk_num, vertex);
            for i=1:2
                index = get_vertex_index(vertex, i);
                store_num = marker.vertex(mrk_num, index);
                % point to point connectivity
                % check whether the point is already stored
                flag_store = check_list(pt_num, store_num, point.connect_pt, ...
                    point.pt_count);
                if (flag_store)
                    point.pt_count(pt_num) = point.pt_count(pt_num)+1;
                    point.connect_pt(pt_num, point.pt_count(pt_num)) = store_num;
                end
            end
            % point to marker connectivity
            point.mrk_count(pt_num) = point.mrk_count(pt_num)+1;
            point.connect_mrk(pt_num, point.mrk_count(pt_num)) = mrk_num;
        end   
    end
end