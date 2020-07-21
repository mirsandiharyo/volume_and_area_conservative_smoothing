% Check whether the point is already stored in the list.
function[flag_store] = check_list(pt_num, store_num, list, list_count)
    flag_store = true;
    for count=1:list_count(pt_num)
        current_num = list(pt_num, count);
        if (store_num == current_num)
            flag_store = false;
        end
        if (flag_store == false)
            break;
        end
    end
end