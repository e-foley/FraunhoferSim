function [figure_out] = psfPlot(psf, imagesc_props, imagesc_io_props)
s = imagesc_props;
o = imagesc_io_props;

if (~iscell(s.color_map))
    s.color_map = {s.color_map};
end

num_psfs = numel(psf);
psf_images = cell(num_psfs, 1);
max_size_px = [0 0];
for i=1:num_psfs
    psf_images{i} = psfGetImage(psf(i), s.field_limits, s.output_limits);
    max_size_px = max(max_size_px, size(psf_images{i}));
end
composite = zeros([max_size_px 3]);
for i=1:num_psfs
    map = s.color_map{i};
    num_colors = size(map, 1);
    % Resize small images to size of largest.
    psf_images{i} = imresize(psf_images{i}, max_size_px);
    % Convert psf_images to indices within color map.
    psf_images{i} = round(1 + (num_colors - 1) * max(0, min(1, psf_images{i})));
    for x=1:size(psf_images{i}, 1)
        for y=1:size(psf_images{i}, 2)
            % Add colors element-wise (3D indices are challenging in MATLAB).
            for c=1:3
                composite(x,y,c) = composite(x,y,c) + map(psf_images{i}(x,y),c);
            end
        end
    end
end

figure_out = figure;
imagesc(s.field_limits(1,:), fliplr(s.field_limits(2,:)), composite);
formatImagescPlot(figure_out, s);
caxis(s.output_limits);
h = colorbar;
drawnow;  % MATLAB bug: colorbar colors don't update without this line.
% colormap(s.color_map);
ylabel(h, 'log_1_0 contrast');

if o.save_eps
    print('-depsc', '-painters', o.eps_location);
end
if o.save_png
    print('-dpng', o.png_location);
end

end
