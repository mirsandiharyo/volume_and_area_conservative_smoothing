% Store the neighboring points and markers of a given point.
function[point] = create_point_connectivity(marker, point)
    global max_neighbor
    % point to point connectivity and point to marker connectivity
    [point.connect_pt, point.connect_mrk] = ...
        deal(zeros(point.total, max_neighbor)-1);
    % counters
    [point.pt_count, point.mrk_count] = deal(zeros(point.total, 1));
 
    % create point to marker connectivity
    for mrk_num=1:marker.total
        for vertex=1:3
            pt_num = marker.vertex(mrk_num, vertex);
            point.mrk_count(pt_num) = point.mrk_count(pt_num)+1;
            point.connect_mrk(pt_num, point.mrk_count(pt_num)) = mrk_num;
        end   
    end
    
    % create point to point connectivity
    for pt_num=1:point.total
        % copy the point to marker connectivity to a temporary list
        list = copy_marker_list(pt_num, point);
        list_count = point.mrk_count(pt_num);
        % mark the vertex number of the current point on each marker
        centroid = zeros(list_count, 1)-1;
        for i=1:list_count
            mrk_num = list(i);
            for idx=1:3
                vertex = marker.vertex(mrk_num, idx);
                if (vertex == pt_num)
                    centroid(i) = idx;
                end
            end            
        end
        % store the neighboring points in counter-clockwise direction
        mrk_num = list(list_count);
        [store_idx, next_idx] = get_vertex_index(centroid(list_count));
        % store the first neighboring point only
        store_vertex = marker.vertex(mrk_num, store_idx);
        point.pt_count(pt_num) = point.pt_count(pt_num)+1;
        point.connect_pt(pt_num, point.pt_count(pt_num)) = store_vertex;
        next_vertex = marker.vertex(mrk_num, next_idx);
        centroid(list_count) = -1;  % for debugging
        list(list_count) = -1;      % for debugging 
        list_count = list_count -1;
        while (list_count > 0)
            flag_store = false;
            flag_edge = false;
            for i=1:list_count
                mrk_num = list(i);
                [store_idx, next_idx] = get_vertex_index(centroid(i));
                store_vertex = marker.vertex(mrk_num, store_idx);
                if (store_vertex == next_vertex)
                    point.pt_count(pt_num) = point.pt_count(pt_num)+1;
                    point.connect_pt(pt_num, point.pt_count(pt_num)) = store_vertex;
                    next_vertex = marker.vertex(mrk_num, next_idx);
                    list(i) = list(list_count);
                    centroid(i) = centroid(list_count);
                    centroid(list_count) = -1;  % for debugging
                    list(list_count) = -1;      % for debugging
                    list_count = list_count -1;
                    flag_store = true;
                end
                % if the neighboring point is already stored 
                if (flag_store)
                    break; 
                end
                % if reaching the end without storing the point 
                if (i == list_count)
                    flag_edge = true;
                end                
            end
            % if the last next point is not equal to the first point
            if ((list_count == 0) && ...
                (next_vertex ~= point.connect_pt(pt_num, 1)))
                flag_edge = true;                
            end
            if (flag_edge)
                % set the point count to -1 for flagging
                point.pt_count(pt_num) = -1;
                break;
            end
        end       
    end
end