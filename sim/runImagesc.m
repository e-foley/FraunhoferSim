function [figure_num] = runImagesc(log_scaled, plot_props, ld_bounds, crop_scale_props, my_title, persist_figure, figure_num, save_eps, save_png, eps_name, png_name)

p = plot_props;
c = crop_scale_props;

% Use the automatic image scale/plot function so that axes are labeled
scaled_fig = figure(figure_num);
imagesc(ld_bounds(1,:), ld_bounds(2,:), flipud(log_scaled));  % actually plot result; flip makes coords agree with convolution
formatImagescPlot(p, scaled_fig, c.ld_lim, my_title);
colormap(figure_num, p.color_map);
caxis([-c.mag_lims(2), -c.mag_lims(1)]);  % bound color axis
h = colorbar;
ylabel(h, 'log_1_0 contrast');
if save_eps
    print('-depsc', '-painters', eps_name);
end
if save_png
    print('-dpng', png_name);
end
if persist_figure
    figure_num = figure_num + 1;  % TODO: Consider closing this figure right afterward per parameter
else
    close(scaled_fig);
end
end
