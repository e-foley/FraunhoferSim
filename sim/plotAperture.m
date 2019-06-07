function [figure_out] = plotAperture(aperture, imagesc_props, imagesc_io_props)
s = imagesc_props;
o = imagesc_io_props;

if (~iscell(s.color_maps))
    s.color_maps = {s.color_maps};
end

figure_out = figure;
imagesc([-0.5 0.5], [0.5 -0.5], aperture);
formatImagescPlot(figure_out, s);

% Apply color map. We can only plot one thing, so we use first map in the list.
colormap(s.color_maps{1});

if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
