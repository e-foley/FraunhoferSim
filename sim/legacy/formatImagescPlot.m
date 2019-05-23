% Run this after calling imagesc.
function formatImagescPlot(imagesc_props, the_figure, full_limits, plot_title)
% function formatImagescPlot(ld_lim, ld_u_axis_tick_spacing, ld_v_axis_tick_spacing, font_size, plot_title, extra_title_margin)

s = imagesc_props;

set(the_figure, 'Position', [0 0 s.nominal_plot_size]);
axis on;
% these seem redundant, but performance consistent only with them all
axis square;
axis equal;
xlim([-full_limits, full_limits]);
ylim([-full_limits, full_limits]);
set(gca, 'XTick', -full_limits:s.h_axis_tick_spacing:full_limits);
set(gca, 'YTick', -full_limits:s.v_axis_tick_spacing:full_limits);
set(gca, 'YDir', 'normal');
set(gca, 'TickDir', 'out');  % draw ticks outside of PSF area
xlabel(s.h_axis_title);
ylabel(s.v_axis_title);
my_title = title(plot_title);
title_pos = get(my_title, 'Position');
set(my_title, 'Position', title_pos + [0 s.extra_title_margin 0]);
set(gca,'FontSize',s.font_size,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',s.font_size,'fontWeight','bold');

end