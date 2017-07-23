function [figure_num] = runImagesc(log_scaled, plot_props, ld_bounds, crop_scale_props, my_title, persist_figure, figure_num, save_eps, save_png, eps_name, png_name)

p = plot_props;
c = crop_scale_props;

% Use the automatic image scale/plot function so that axes are labeled
scaled_fig = figure(figure_num);
set(scaled_fig, 'Position', [0 0 p.nominal_plot_size]);
imagesc(ld_bounds(1,:), ld_bounds(2,:), flipud(log_scaled));  % actually plot result; flip makes coords agree with convolution
colormap(figure_num, p.color_map);
caxis([-c.mag_lims(2), -c.mag_lims(1)]);  % bound color axis
h = colorbar;
ylabel(h, 'log_1_0 contrast');
axis on;
% these seem redundant, but performance consistent only with them all
axis square;
axis equal;
xlim([-c.ld_lim, c.ld_lim]);
ylim([-c.ld_lim, c.ld_lim]);
set(gca, 'XTick', -c.ld_lim:p.ld_u_axis_tick_spacing:c.ld_lim);
set(gca, 'YTick', -c.ld_lim:p.ld_v_axis_tick_spacing:c.ld_lim);
set(gca, 'YDir', 'normal');
set(gca, 'TickDir', 'out');  % draw ticks outside of PSF area
xlabel('u [\lambda/D]');
ylabel('v [\lambda/D]');
the_title = title(my_title);
title_pos = get(the_title, 'Position');
set(the_title, 'Position', title_pos + [0 p.extra_title_margin 0]);
set(gca,'FontSize',p.font_size,'fontWeight','bold');
set(h, 'FontSize', p.font_size, 'fontWeight', 'bold');  % color bar axis font
set(findall(gcf,'type','text'),'FontSize',p.font_size,'fontWeight','bold');
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
