% Perform two-nodes relaxation.
function[point] = two_nodes_relaxation(num1, num2, point, omega)
    global max_neighbor
    % copy the coordinates; to arrays to make the calculation easier
    point_num1 = copy_from_point_structure(num1, point);
    point_num2 = copy_from_point_structure(num2, point);
    
    % create list of neighbors for point num1 such that the list starts
    % and ends with point num2
    list1 = create_neighbor_list(num1, num2, point);
    list1_count = point.pt_count(num1);
    % similarly for num2
    list2 = create_neighbor_list(num2, num1, point);
    list2_count = point.pt_count(num2);
    
    % calculate sum of marker normals adjacent to point num1
    [sum_norm1, sum_norm2] = deal(zeros(3, 1));
    for count=1:list1_count
        e0 = substract_points(num1, list1(count), point);
        e1 = substract_points(num1, list1(count+1), point);
        res = cross(e0, e1);       
        sum_norm1 = sum_norm1 + res;
    end
    % similary for point num2
    for count=1:list2_count
        e0 = substract_points(num2, list2(count), point);
        e1 = substract_points(num2, list2(count+1), point);
        res = cross(e0, e1);      
        sum_norm2 = sum_norm2 + res;
    end
    
    % calculate the volume change caused by motion of the nodes
    % calculate the term v
    e2n2 = substract_points(num2, list2(list2_count), point);
    e22  = substract_points(num2, list2(2), point);
    vv = e2n2 - e22;   
    
    % calculate the term w1 and w2
    [w1, w2] = deal(zeros(max_neighbor, 1));
    % calculate the term w1
    sum = 0.0;
    for idx = 1:list1_count
        idxplus1 = idx + 1;
        if (idxplus1 > list1_count)
            idxplus1 = idxplus1 - list1_count;
        end
        idxmin1 = idx - 1;
        if (idxmin1 < 1)
            idxmin1 = idxmin1 + list1_count;        
        end
        for i=1:3
            w1(idx) = w1(idx) + (point.coord(list1(idxplus1), i) - ...
                                 point.coord(list1(idxmin1 ), i))^2;
        end
        sum = sum + w1(idx);
    end
    w1 = w1/sum;
    
    sum = 0.0;
    for idx = 1:list2_count
        idxplus1 = idx + 1;
        if (idxplus1 > list2_count)
            idxplus1 = idxplus1 - list2_count;
        end
        idxmin1 = idx - 1;
        if (idxmin1 < 1)
            idxmin1 = idxmin1 + list2_count;        
        end
        for i=1:3
            w2(idx) = w2(idx) + (point.coord(list2(idxplus1), i) - ...
                                 point.coord(list2(idxmin1 ), i))^2;
        end
        sum = sum + w2(idx);
    end    
    w2 = w2/sum;
    
    % calculate the term sum1 and sum2
    [sum1, sum2] = deal(zeros(3, 1));
    for idx=2:list1_count
        for i=1:3
            sum1(i) = sum1(i) + w1(idx)*point.coord(list1(idx), i);
        end
    end
    for idx=2:list2_count
        for i=1:3
            sum2(i) = sum2(i) + w2(idx)*point.coord(list2(idx), i);
        end
    end
    
    % calculate the new position of points num1 and num2
    xs1 = (w1(1)*sum2 + sum1)/(1.0 - w1(1)*w2(1));
    xs2 = w2(1)*xs1 + sum2;

    % calculate the displacement between the new and old positions
    dxs1 = omega*(xs1 - point_num1);
    dxs2 = omega*(xs2 - point_num2);
    
    % calculate the correction verctor hh that needs to be added to new
    % positions to ensure volume conservation is calculated
    temp1 = dxs1 - dxs2;
    temp2 = cross(vv, temp1);
    temp1 = sum_norm1 + sum_norm2;
    aa = temp1 + temp2;
    if (norm(aa) > 1e-10)
        norm_aa = aa/norm(aa);
        temp1 = cross(vv, dxs1);
        hh = -(dot(dxs1, sum_norm1) + dot(dxs2, sum_norm2) + ...
               dot(dxs2, temp1))/norm(aa);
        % calculate the new positions given by underrelaxed Laplacian
        % smoothing omega
        xs1 = point_num1 + dxs1 + hh * norm_aa;
        xs2 = point_num2 + dxs2 + hh * norm_aa;
        % update the new positions
        point = copy_from_array(num1, point, xs1);
        point = copy_from_array(num2, point, xs2);        
    end
end