function [figure_out] = plotCut(cutu, cutw, cut_props, cut_io_props)

c = cut_props;
o = cut_io_props;

figure_out = figure;
set(figure_out, 'Position', [0 0 c.nominal_plot_size]);
hold on;

if (c.show_target)
    h2 = plot(r_axis, c.target * ones(1, size(r_axis,2)), 'Color', c.target_line_color, 'LineStyle', '--', 'LineWidth', c.target_line_thickness);
end

h1 = plot(cutu, cutw, 'Color', c.primary_color);

hold off;
if (c.show_target)
    legend([h1 h2], c.label, 'contrast target');
else
    legend(h1, c.label);
end
xlabel('{\itu} [{\it\lambda}/{\itD}]');
ylabel('log_1_0 contrast');
xlim(c.u_limits);  % Change this to something encoded in cut_props
ylim(c.cut_vert_lims);
set(gca,'FontSize',c.font_size,'fontWeight','bold');
set(gca, 'XTick', 0:c.u_axis_tick_spacing:c.u_limits);
set(gca, 'YTick', (c.cut_vert_lims(1)):c.cut_y_axis_spacing:c.cut_vert_lims(2));
set(h1,'LineWidth',c.cut_line_thickness);
caxis([-c.mag_lims(2) -c.mag_lims(1)]);
cb = colorbar('westoutside');
% colormap(cb, [linspace(0, colors(2,1), 256)' linspace(0, colors(2,2), 256)' linspace(0, colors(2,3), 256)']);
colormap(cb, [linspace(0, 1, 256)' linspace(0, 1, 256)' linspace(0, 1, 256)']);
set(cb, 'TickLabels', []);
set(cb, 'AxisLocation', 'in');
set(cb, 'Limits', c.cut_vert_lims);
set(cb, 'Ticks', (c.cut_vert_lims(1)):c.cut_y_axis_spacing:c.cut_vert_lims(2));
% cb2 = colorbar;
% set(cb2, 'Limits', p.cut_vert_lims);
% set(cb2, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
% set(cb2, 'TickLabels', []);
% set(cb2, 'AxisLocation', 'in');
% cb2.Position(1) = cb.Position(1) - cb.Position(3);
% colormap(cb2, [linspace(0, colors(1,1), 256)' linspace(0, colors(1,2), 256)' linspace(0, colors(1,3), 256)']);
my_title = title('Horizontal PSF cut');
title_pos = get(my_title, 'Position');
set(gca,'FontSize',c.font_size,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',c.font_size,'fontWeight','bold');
set(my_title, 'Position', title_pos + [0 c.extra_title_margin_cut 0]);
print('-depsc', '-painters', o.cut_overlay_location_eps);
print('-dpng', o.cut_overlay_location_png);
if (persist_figures)
    figure_num = figure_num + 1;
else
    close(figure_out);
end

end
