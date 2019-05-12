function [figure_number] = plotAperture(aperture, imagesc_props, my_title, persist_figure, figure_number, save_eps, save_png, eps_location, png_location)
s = imagesc_props;

my_figure = figure(figure_number);
imagesc([-0.5 0.5], [0.5 -0.5], aperture);
formatImagescPlot(imagesc_props, my_figure, 0.5, my_title);
colormap(s.color_map);  % needed to plot black/white if lingering colormap

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