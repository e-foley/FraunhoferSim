% Forms an image showing the region enclosed by a Gaussian profile and its
% reflection across the horizontal axis as transparent, and other areas opaque.
% No anti-aliasing is applied.
%
% canvas_size_px   Dimensions of the image to create (pixels) [height,width]
% rel_peak_height  Amplitude of the Gaussian function (a half that's reflected)
%                  as a ratio of the canvas height
% rel_std_dev      The standard deviation of the Gaussian distribution as a
%                  ratio of the peak height
%
% M                The resulting image, with transparent regions 1 and opaque
%                  regions 0 (2D array)

function [M] = formGaussian(canvas_size_px, rel_peak_height, rel_std_dev)
M = ones(canvas_size_px, 'logical');
peak_height_px = rel_peak_height * canvas_size_px(1);
std_dev_px = rel_std_dev * peak_height_px;
mean_px = (canvas_size_px(2) + 1) / 2;
vert_center_px = (canvas_size_px(1) + 1) / 2;

% Calculate Gaussian in pixel scale.
h = 1:canvas_size_px(2);
vert_scaling = peak_height_px * std_dev_px * sqrt(2*pi);
norm_px = vert_center_px + vert_scaling * ...
    1/(std_dev_px*sqrt(2*pi)) * exp(-(h-mean_px).^2/(2*std_dev_px^2));

% Only calculate values for top half, then reflect result.
x_limit_px = round(canvas_size_px(1) / 2);
for x=1:x_limit_px
    for y=h
        if x < (canvas_size_px(1) + 1 - norm_px(y))
            M(x,y) = 0;
        end
    end
end

% Duplicate result about horizontal axis.
M = M .* flipud(M);

end
