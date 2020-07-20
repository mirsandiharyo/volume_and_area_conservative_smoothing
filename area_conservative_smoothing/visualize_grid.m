% Visualize the grid
function[] = visualize_grid(point, xmin, xmax, ymin, ymax, iter)
    h = plot(point(:,1), point(:,2), '-o','color','black','MarkerEdgeColor', ...
        'red','MarkerFaceColor','red');
    xlim([xmin xmax]);
    ylim([ymin ymax]);
    xlabel('x');
    ylabel('y');
    pbaspect([(xmax-xmin) (ymax-ymin) 1]);
    % set the caption
    caption = sprintf('Iteration = %d', iter);
	title(caption, 'FontSize', 10);
    % save the plot     
    caption = sprintf('output/iter_%03d.png',iter);
    saveas(h, caption);
    pause(0.02);
end