% Visualize the grid
function[] = visualize_grid(faces, vertices, xmin, xmax, ymin, ymax, ...
    zmin, zmax, iter)
    h = patch('Faces',faces,'Vertices',vertices,'FaceColor','red');
    alpha(0.5);
    % set the limit and aspect ratio of the image
    xlim([xmin xmax]);
    ylim([ymin ymax]);
    zlim([zmin zmax]);    
    xlabel('x');
    ylabel('y');
    zlabel('z');
    view(3);
    pbaspect([(xmax-xmin) (ymax-ymin) (zmax-zmin)]);
    % change the camera angle
    camorbit(0,-15,'camera');
    drawnow;
    % set the caption
    caption = sprintf('Iteration = %d', iter);
	title(caption, 'FontSize', 10);
    % save the plot     
    caption = sprintf('output/iter_%03d.png',iter);
    saveas(h, caption);
    pause(0.02);
end