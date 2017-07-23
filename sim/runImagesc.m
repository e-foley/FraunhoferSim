function [figure_num] = runImagesc(log_scaled, plot_props, ld_bounds, ld_lim, color_map, mag_lims, figure_num, save_eps, save_png, eps_name, png_name)

p = plot_props;

% Use the automatic image scale/plot function so that axes are labeled
scaled_fig = figure(figure_num);
set(scaled_fig, 'Position', [0 0 p.nominal_plot_size]);
imagesc(ld_bounds(1,:), ld_bounds(2,:), flipud(log_scaled));  % actually plot result; flip makes coords agree with convolution
colormap(figure_num, color_map);
caxis([-mag_lims(2), -mag_lims(1)]);  % bound color axis
h = colorbar;
ylabel(h, 'log_1_0 contrast');
axis on;
% these seem redundant, but performance consistent only with them all
axis square;
axis equal;
xlim([-ld_lim, ld_lim]);
ylim([-ld_lim, ld_lim]);
set(gca, 'XTick', -ld_lim:p.ld_u_axis_tick_spacing:ld_lim);
set(gca, 'YTick', -ld_lim:p.ld_v_axis_tick_spacing:ld_lim);
set(gca, 'YDir', 'normal');
set(gca, 'TickDir', 'out');  % draw ticks outside of PSF area
xlabel('u [\lambda/D]');
ylabel('v [\lambda/D]');
the_title = title(p.my_title);
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
figure_num = figure_num + 1;  % TODO: Consider closing this figure right afterward per parameter
end
