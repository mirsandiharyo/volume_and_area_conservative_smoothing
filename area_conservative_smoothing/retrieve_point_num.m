% Retrieve the neighbouring point numbers using point connectivity.
function[x0, x1, x2, x3] = retrieve_point_num(num, point)
    x0 = point.connectivity(num, 1);
	x1 = num;
	x2 = point.connectivity(num, 2);
    if (x2 == -1)
        x3 = -1; % to avoid error
    else
        x3 = point.connectivity(x2, 2);
    end
end
