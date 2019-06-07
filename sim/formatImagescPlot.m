% Run this after calling imagesc.
function formatImagescPlot(the_figure, imagesc_props)
s = imagesc_props;

set(the_figure, 'Position', [0 0 s.nominal_plot_size_px]);
axis on;
% these seem redundant, but performance consistent only with them all
axis square;
axis equal;
xlim(s.field_limits(1,:));
ylim(s.field_limits(2,:));
xticks(s.field_limits(1,1):s.h_axis_tick_spacing:s.field_limits(1,2));
yticks(s.field_limits(2,1):s.v_axis_tick_spacing:s.field_limits(2,2));
set(gca, 'YDir', 'normal');
set(gca, 'TickDir', 'out');  % draw ticks outside of PSF area
xlabel(s.h_axis_title);
ylabel(s.v_axis_title);
my_title = title(s.plot_title);
title_pos = get(my_title, 'Position');
set(my_title, 'Position', title_pos + [0 s.extra_title_margin 0]);
set(gca,'FontSize',s.font_size,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',s.font_size,'fontWeight','bold');

end
