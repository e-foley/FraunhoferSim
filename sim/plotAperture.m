function [figure_out] = plotAperture(aperture, imagesc_props, imagesc_io_props)
s = imagesc_props;
o = imagesc_io_props;

figure_out = figure;
imagesc([-0.5 0.5], [0.5 -0.5], aperture);
formatImagescPlot(figure_out, s);
colormap(s.color_map);  % needed to plot black/white if lingering colormap

if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
