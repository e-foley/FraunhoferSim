function [figure_number] = plotApertureNew(aperture, imagesc_props, my_title, persist_figure, figure_number, save_eps, save_png, eps_location, png_location)
s = imagesc_props;
    
% extra_title_margin = 0.02;

my_figure = figure(figure_number);
imagesc([-0.5 0.5], [0.5 -0.5], aperture);
formatImagescPlot(imagesc_props, my_figure, 0.5, my_title);
colormap(s.color_map);  % needed to plot black/white if lingering colormap
% axis on;
% axis square;
% axis equal;
% xlim([-0.5 0.5]);
% ylim([-0.5 0.5]);
% set(gca, 'XTick', -0.5:0.1:0.5);
% set(gca, 'YTick', -0.5:0.1:0.5);
% set(gca, 'YDir', 'normal');  % 'reverse' is default, with values increasing as one goes down the screen
% set(gca, 'TickDir', 'out');  % draws tick marks outside aperture area
% xlabel('x'' [x/D]');
% ylabel('y'' [y/D]');
% my_title = title(aperture_name);
% title_pos = get(my_title, 'Position');
% set(my_title, 'Position', title_pos + [0 extra_title_margin 0]);
% set(gca,'FontSize',font_size,'fontWeight','bold');
% set(findall(gcf,'type','text'),'FontSize',font_size,'fontWeight','bold');
% set(my_figure, 'Position', [0 0 nominal_plot_size]);

% comment out for speed purposes
if save_eps
    print('-depsc', '-painters', eps_location);
end
if save_png
    print('-dpng', png_location);
end
    
if persist_figure
    figure_number = figure_number + 1;
else
    close(my_figure);
end

end