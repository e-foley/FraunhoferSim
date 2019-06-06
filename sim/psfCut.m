function [figure_out] = psfCut(psf, cut_props, cut_io_props)

c = cut_props;
o = cut_io_props;

% Condition color_map and labels into cell arrays so that they work in loops.
if (~iscell(c.color_map))
    c.color_map = {c.color_map};
end
if (~iscell(c.labels))
    c.labels = {c.labels};
end

num_psfs = numel(psf);
num_maps = numel(c.color_map);
u = cell(1, num_psfs);
w = cell(1, num_psfs);

for i=1:num_psfs
    image = log10(psf(i).data ./ max(max(psf(i).data)));
    upx_min = 1 + round(psf(i).pixels_per_ld * (c.u_limits(1) - psf(i).ld_bounds(1,1)));
    upx_max = 1 + round(psf(i).pixels_per_ld * (c.u_limits(2) - psf(i).ld_bounds(1,1)));
    v_px =    1 + round(psf(i).pixels_per_ld * (0 - psf(i).ld_bounds(1,1)));
    u{i} = psf(i).ld_bounds(1,1) + ((upx_min:upx_max) - 1) / psf(i).pixels_per_ld;
    w{i} = image(upx_min:upx_max,v_px);
end

figure_out = figure;
set(figure_out, 'Position', [0 0 c.nominal_plot_size]);
hold on;

h = zeros(1, num_psfs + c.show_target);

if (c.show_target)
    h(end) = plot([c.u_limits(1) c.u_limits(2)], [c.target c.target], ...
        'Color', c.target_line_color, 'LineStyle', '--', 'LineWidth', ...
        c.target_line_thickness);
end

line_styles = {'-', '--', ':', '-.'};
for i=num_psfs:-1:1
    h(i) = plot(u{i}, w{i}, 'Color', c.line_colors{i});
    set(h(i), 'LineWidth', c.cut_line_thickness);
    set(h(i), 'LineStyle', line_styles{i});
end
    
hold off;
if (c.show_target)
    legend(h, c.labels, 'contrast target');
else
    legend(h, c.labels);
end
xlabel(c.u_title);
ylabel(c.w_title);
xlim(c.u_limits);
ylim(c.w_limits);
set(gca,'FontSize', c.font_size, 'fontWeight', 'bold');
set(gca, 'XTick', (c.u_limits(1)):c.u_spacing:c.u_limits(2));
set(gca, 'YTick', (c.w_limits(1)):c.w_spacing:c.w_limits(2));

if (c.show_color_bar)
    cb = colorbar('westoutside');
    colormap(cb, c.color_map{end});
    caxis(c.c_limits);
    color_bar_pos = cb.Position;
    set(cb, 'TickLabels', []);
    set(cb, 'AxisLocation', 'in');
    set(cb, 'Limits', c.w_limits);
    set(cb, 'Ticks', (c.w_limits(1)):c.w_spacing:c.w_limits(2));
    
    for i=1:(num_maps-1)
        cb = colorbar;
        colormap(cb, c.color_map{i});
        caxis(c.c_limits);
        cb.Position = color_bar_pos - [(num_maps-i)*color_bar_pos(3) 0 0 0];
        set(cb, 'TickLabels', []);
        set(cb, 'AxisLocation', 'in');
        set(cb, 'Limits', c.w_limits);
        set(cb, 'Ticks', (c.w_limits(1)):c.w_spacing:c.w_limits(2));
    end
end

my_title = title(c.plot_title);
title_pos = get(my_title, 'Position');
set(gca,'FontSize',c.font_size,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',c.font_size,'fontWeight','bold');
set(my_title, 'Position', title_pos + [0 c.extra_title_margin 0]);

if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
