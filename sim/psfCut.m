function [figure_out] = psfCut(psf, cut_props, cut_io_props)

c = cut_props;
o = cut_io_props;

image = log10(psf.data ./ max(max(psf.data)));

upx_min = 1 + round(psf.pixels_per_ld * (c.u_limits(1) - psf.ld_bounds(1,1)));
upx_max = 1 + round(psf.pixels_per_ld * (c.u_limits(2) - psf.ld_bounds(1,1)));
v_px =    1 + round(psf.pixels_per_ld * (0 - psf.ld_bounds(1,1)));
u = psf.ld_bounds(1,1) + ((upx_min:upx_max) - 1) / psf.pixels_per_ld;
w = image(upx_min:upx_max,v_px);

figure_out = figure;
set(figure_out, 'Position', [0 0 c.nominal_plot_size]);
hold on;

if (c.show_target)
    h2 = plot(u, c.target * ones(1, size(u,2)), 'Color', c.target_line_color, 'LineStyle', '--', 'LineWidth', c.target_line_thickness);
end

h1 = plot(u, w, 'Color', c.primary_color);

hold off;
if (c.show_target)
    legend([h1 h2], c.label, 'contrast target');
else
    legend(h1, c.label);
end
xlabel(c.u_title);
ylabel(c.w_title);
xlim(c.u_limits);  % Change this to something encoded in cut_props
ylim(c.w_limits);
set(gca,'FontSize',c.font_size,'fontWeight','bold');
set(gca, 'XTick', (c.u_limits(1)):c.u_spacing:c.u_limits(2));
set(gca, 'YTick', (c.w_limits(1)):c.w_spacing:c.w_limits(2));
set(h1,'LineWidth',c.cut_line_thickness);
caxis([c.c_limits(1) c.c_limits(2)]);
cb = colorbar('westoutside');
% colormap(cb, [linspace(0, colors(2,1), 256)' linspace(0, colors(2,2), 256)' linspace(0, colors(2,3), 256)']);
colormap(cb, [linspace(0, 1, 256)' linspace(0, 1, 256)' linspace(0, 1, 256)']);
set(cb, 'TickLabels', []);
set(cb, 'AxisLocation', 'in');
set(cb, 'Limits', c.w_limits);
set(cb, 'Ticks', (c.w_limits(1)):c.w_spacing:c.w_limits(2));
% cb2 = colorbar;
% set(cb2, 'Limits', p.cut_vert_lims);
% set(cb2, 'Ticks', (p.cut_vert_lims(1)):p.cut_y_axis_spacing:p.cut_vert_lims(2));
% set(cb2, 'TickLabels', []);
% set(cb2, 'AxisLocation', 'in');
% cb2.Position(1) = cb.Position(1) - cb.Position(3);
% colormap(cb2, [linspace(0, colors(1,1), 256)' linspace(0, colors(1,2), 256)' linspace(0, colors(1,3), 256)']);
my_title = title(c.plot_title);
title_pos = get(my_title, 'Position');
set(gca,'FontSize',c.font_size,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',c.font_size,'fontWeight','bold');
set(my_title, 'Position', title_pos + [0 c.extra_title_margin 0]);
% print('-depsc', '-painters', o.eps_location);
% print('-dpng', o.png_location);
% if (persist_figures)
%     figure_num = figure_num + 1;
% else
%     close(figure_out);
% end

if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
