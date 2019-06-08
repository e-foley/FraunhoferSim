% Plots an aperture image with labeled coordinate axes.
%
% aperture       The aperture image to plot
% imagesc_props  An ImagescProps object governing how the plot will appear
% io_props       An IoProps object governing whether and how the output is saved
%
% figure_out     A handle to the figure created by this function

function [figure_out] = plotAperture(aperture, imagesc_props, io_props)
s = imagesc_props;
o = io_props;

% Convert color_maps to cell array to allow proper indexing later.
if (~iscell(s.color_maps))
    s.color_maps = {s.color_maps};
end

% Create and scale figure. Aperture image is assumed to represent exactly the
% entire aperture--no more, no less. Larger dimension establishes diameter.
figure_out = figure;
d_px = max(size(aperture));
imagesc([-0.5 0.5] .* size(aperture, 2) / d_px, ...
        [0.5 -0.5] .* size(aperture, 1) / d_px, aperture);
formatImagescPlot(figure_out, s);

% Apply color map. We can only plot one thing, so we use first map in the list.
colormap(s.color_maps{1});

% Save the image to disc if needed.
if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
