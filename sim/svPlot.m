function [figure_out] = svPlot(sv, imagesc_props, imagesc_io_props)
s = imagesc_props;
o = imagesc_io_props;

image = sv.data;
image = -2.5 * log10(image);
image = rot90(image);

figure_out = figure;
imagesc(sv.as_bounds(1,:), fliplr(sv.as_bounds(2,:)), image);
formatImagescPlot(figure_out, s);
caxis(fliplr(s.output_limits));
h = colorbar;
colormap(flipud(s.color_maps));
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
