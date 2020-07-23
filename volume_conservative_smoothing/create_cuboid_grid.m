% Create cuboid grid using matlab functions.
function[marker, point] = create_cuboid_grid()
    % cuboid
    [X,Y,Z] = meshgrid(1:15);
    x = X(:);
    y = Y(:);
    z = Z(:);
    DT = delaunayTriangulation(x,y,z);
    [Tfb,Xfb] = freeBoundary(DT);
    TR = triangulation(Tfb,Xfb);
    point.total = size(TR.Points, 1);
    point.coord = TR.Points;
    marker.total = size(TR.ConnectivityList, 1);
    marker.vertex = TR.ConnectivityList;
    % visualize the normal vector at the vertices to check
    V = vertexNormal(TR);
    trisurf(TR,'FaceColor',[0.9 0.9 0.9]);
    axis equal
    hold on
    quiver3(Xfb(:,1),Xfb(:,2),Xfb(:,3), ...
    V(:,1),V(:,2),V(:,3),0.5,'Color','b');
end