function [replace_me] = runCut(psf, overlay_props, psf_props, crop_scale_props, imagesc_props, overlay_io_props, primary_label, secondary_label, persist_figures, figure_num)

% creates a plot showing luminosity plotted as a function of a horizontal
% coordinate of a single point spread function

p = overlay_props;
f = psf_props;
c = crop_scale_props;
s = imagesc_props;
o = overlay_io_props;

cut_fig = figure(figure_num);
set(cut_fig, 'Position', [0 0 s.nominal_plot_size]);
hold on;

% changed
% rectangle('Position',[1.5,-2.6,6.5,2.6], 'FaceColor',[0.9 0.9 0.9], 'EdgeColor', [0.4 0.4 0.4], 'LineWidth', 0.5);
if (p.show_target)
    h3 = plot(r_axis, p.target * ones(1, size(r_axis,2)), 'Color', p.target_line_color, 'LineStyle', '--', 'LineWidth', p.target_line_thickness);
end
% end changed

h2 = plot(r_axis, m2_axis, 'Color', colors(2, :), 'LineStyle', ':');
h1 = plot(r_axis, m1_axis, 'Color', colors(1, :));

hold off;
if (p.show_target)
    legend([h1 h2 h3], primary_label, secondary_label, 'contrast target');
else
    legend([h1 h2], primary_label, secondary_label);
end
xlabel('{\itu} [{\it\lambda}/{\itD}]');
ylabel('log_1_0 contrast');
xlim([0, c.ld_lim]);
ylim(p.cut_vert_lims);
set(gca,'FontSize',s.font_size,'fontWeight','bold');
set(gca, 'XTick', 0:s.h_axis_tick_spacing:c.ld_lim);
set(gca, 'YTick', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
set([h2 h1],'LineWidth',p.cut_line_thickness);
caxis([-c.mag_lims(2) -c.mag_lims(1)]);
cb = colorbar('westoutside');
colormap(cb, [linspace(0, colors(2,1), 256)' linspace(0, colors(2,2), 256)' linspace(0, colors(2,3), 256)']);
set(cb, 'TickLabels', []);
set(cb, 'AxisLocation', 'in');
set(cb, 'Limits', p.cut_vert_lims);
set(cb, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
cb2 = colorbar;
set(cb2, 'Limits', p.cut_vert_lims);
set(cb2, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
set(cb2, 'TickLabels', []);
set(cb2, 'AxisLocation', 'in');
cb2.Position(1) = cb.Position(1) - cb.Position(3);
colormap(cb2, [linspace(0, colors(1,1), 256)' linspace(0, colors(1,2), 256)' linspace(0, colors(1,3), 256)']);
my_title = title(['Horizontal PSF cut overlay']);
title_pos = get(my_title, 'Position');
set(gca,'FontSize',s.font_size,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',s.font_size,'fontWeight','bold');
set(my_title, 'Position', title_pos + [0 p.extra_title_margin_cut 0]);
print('-depsc', '-painters', o.cut_overlay_location_eps);
print('-dpng', o.cut_overlay_location_png);
if (persist_figures)
    figure_num = figure_num + 1;
else
    close(cut_fig);
end


end