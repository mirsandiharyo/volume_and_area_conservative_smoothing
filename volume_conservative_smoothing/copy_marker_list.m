function[list] = copy_marker_list(pt_num, point)
    list_count = point.mrk_count(pt_num);
    list = zeros(list_count, 1)-1;
    for count=1:list_count
        list(count) = point.connect_mrk(pt_num, count);
    end
end