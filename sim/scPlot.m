function [figure_out] = scPlot(sc, imagesc_props, imagesc_io_props)
s = imagesc_props;
o = imagesc_io_props;

% image = log10(sc.data ./ max(max(sc.data)));  % log mag stuff should
% already be factored in
image = sc.data;
image = -2.5 * log10(sc.data);
image = rot90(image);

figure_out = figure;
imagesc(sc.as_bounds(2,:), fliplr(sc.as_bounds(1,:)), image);
formatImagescPlot(figure_out, s);
caxis(fliplr(s.output_limits));
h = colorbar;
colormap(flipud(s.color_map));
drawnow;  % MATLAB bug: colorbar colors don't update without this line.
set(h, 'YDir', 'reverse');
ylabel(h, 'apparent visual magnitude');

if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
