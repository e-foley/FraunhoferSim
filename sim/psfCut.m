% Creates a figure displaying the intensity of the electromagnetic field along
% the u-axis of one or more point spread functions.
%
% psfs        Psf objects representing the PSFs to cut
% cut_props   A CutProps object describing how to format the figur.
% io_props    An IoProps object determining whether and how the figure is saved
%
% figure_out  A handle to the generated figure.

function [figure_out] = psfCut(psfs, cut_props, io_props)
c = cut_props;
o = io_props;

% Condition some arguments into cell arrays so that they work in loops.
if (~iscell(c.color_maps))
    c.color_maps = {c.color_maps};
end
if (~iscell(c.labels))
    c.labels = {c.labels};
end
if (~iscell(c.line_colors))
    c.line_colors = {c.line_colors};
end

num_psfs = numel(psfs);
num_maps = numel(c.color_maps);

% Create cell arrays that will store values of u and intensity for each PSF cut.
u = cell(1, num_psfs);
w = cell(1, num_psfs);

% For each PSF, log-normalize the intensities and collect data along the u-axis.
for i=1:num_psfs
    image = log10(psfs(i).data ./ max(max(psfs(i).data)));
    upx_min = 1 + round(psfs(i).pixels_per_ld * (c.u_limits(1) - psfs(i).ld_bounds(1,1)));
    upx_max = 1 + round(psfs(i).pixels_per_ld * (c.u_limits(2) - psfs(i).ld_bounds(1,1)));
    v_px =    1 + round(psfs(i).pixels_per_ld * (0 - psfs(i).ld_bounds(1,1)));
    
    % Because we rounded to find u bound indices closest to requested limits, we
    % calculate what values of u *actually* correspond to those indices.
    u{i} = psfs(i).ld_bounds(1,1) + ((upx_min:upx_max) - 1) / psfs(i).pixels_per_ld;
    w{i} = image(upx_min:upx_max,v_px);
end

% Begin boring plot formatting stuff...
figure_out = figure;
set(figure_out, 'Position', [0 0 c.nominal_plot_size_px]);
hold on;

% Create an array of line handles, adding one extra slot if we need to show the
% contrast target also.
h = zeros(1, num_psfs + c.show_target);

% Show the contrast target if requested.
if (c.show_target)
    h(end) = plot([c.u_limits(1) c.u_limits(2)], [c.target c.target], ...
        'Color', c.target_line_color, 'LineStyle', '--', 'LineWidth', ...
        c.target_line_thickness_pt);
end

% Actually plot the cut data.
line_styles = {'-', '--', ':', '-.'};
for i=1:num_psfs
    h(i) = plot(u{i}, w{i}, 'Color', c.line_colors{i});
    set(h(i), 'LineWidth', c.cut_line_thickness_pt);
    set(h(i), 'LineStyle', line_styles{1 + num_psfs - i});
end

hold off;

% Create the legend.
if (c.show_target)
    legend(h, c.labels, 'contrast target');
else
    legend(h, c.labels);
end

% Configure the axis displays.
xlabel(c.u_title);
ylabel(c.w_title);
xlim(c.u_limits);
ylim(c.w_limits);
set(gca,'FontSize', c.font_size_pt, 'fontWeight', 'bold');
set(gca, 'XTick', (c.u_limits(1)):c.u_spacing:c.u_limits(2));
set(gca, 'YTick', (c.w_limits(1)):c.w_spacing:c.w_limits(2));

% The logic to show the colorbars is convoluted because we cheat our way around
% the typical MATLAB restriction of one colorbar per plot.
if (c.show_color_bars)
    cb = colorbar('westoutside');
    colormap(cb, c.color_maps{end});
    caxis(c.c_limits);
    % Cache initial color bar's position so we can place subsequent bars. 
    color_bar_pos = cb.Position;
    set(cb, 'TickLabels', []);
    set(cb, 'AxisLocation', 'in');
    set(cb, 'Limits', c.w_limits);
    set(cb, 'Ticks', (c.w_limits(1)):c.w_spacing:c.w_limits(2));
    
    for i=1:(num_maps-1)
        cb = colorbar;
        colormap(cb, c.color_maps{i});
        caxis(c.c_limits);
        % Place color bars one standard color bar's width apart so they're
        % adjacent.
        cb.Position = color_bar_pos - [(num_maps-i)*color_bar_pos(3) 0 0 0];
        set(cb, 'TickLabels', []);
        set(cb, 'AxisLocation', 'in');
        set(cb, 'Limits', c.w_limits);
        set(cb, 'Ticks', (c.w_limits(1)):c.w_spacing:c.w_limits(2));
    end
end

% Add labels and change font size.
my_title = title(c.plot_title);
title_pos = get(my_title, 'Position');
set(gca,'FontSize',c.font_size_pt,'fontWeight','bold');
set(findall(gcf,'type','text'),'FontSize',c.font_size_pt,'fontWeight','bold');
set(my_title, 'Position', title_pos + [0 c.extra_title_margin 0]);

% Save the plot to disc if requested.
if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
