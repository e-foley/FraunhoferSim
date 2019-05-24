function [figure_out] = psfPlot(psf, imagesc_props, log_10_mag_limits, imagesc_io_props)
s = imagesc_props;
o = imagesc_io_props;

image = log10(psf.data ./ max(max(psf.data)));
image = rot90(image);

figure_out = figure;
imagesc(psf.ld_bounds(2,:), fliplr(psf.ld_bounds(1,:)), image);
caxis(log_10_mag_limits);
formatImagescPlot(figure_out, s);
colormap(s.color_map);
h = colorbar;
ylabel(h, 'log_1_0 contrast');

if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
