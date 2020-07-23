% Create list of neighbors for point num1 such that the list starts
% and ends with point num2.
function[list] = create_neighbor_list(num1, num2, point)
    max_neighbor = 30;
    list = zeros(max_neighbor, 1);
    list_count = point.pt_count(num1);
    % find the location of point num2 in the connectivity list
    loc = 1;
    while (point.connect_pt(num1, loc) ~= num2)
        loc = loc+1;
    end
    % create the new list
    for idx=loc:list_count
        list(idx-loc+1) = point.connect_pt(num1, idx);
    end
    for idx=1:loc
        list(idx-loc+list_count+1) = point.connect_pt(num1, idx);
    end
    list(list_count+1) = list(1);
end