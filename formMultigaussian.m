% Creates an image representing multiple openings in the shape of a region
% enclosed by the profile of a normal distribution and its reflection about its
% horizontal axis. Image size, subaperture placement, and opening dimensions can
% be selected. No antialiasing is applied.
%
% canvas_size_px   Dimensions of the image to create (pixels) [height,width]
% rel_centers      Locations of subapertures as ratios of the larger canvas
%                  dimension [vert1,horiz1;vert2,horiz2;...;vertN,horizN]
% rel_peak_height  Amplitude of the Gaussian function (a half that's reflected)
%                  as a ratio of the canvas height
% rel_std_dev      The standard deviation of the Gaussian distribution as a
%                  ratio of the peak height
%
% M                The resulting image, with transparent regions 1 and opaque
%                  regions 0 (2D array)

function [M] = formMultigaussian(canvas_size_px, rel_centers, ...
    rel_peak_height, rel_std_dev)
M = zeros(canvas_size_px, 'logical');

% Create slices representing single Gaussians and combine them onto the canvas
% by shifting each one by a number of pixels appropriate for the rel_centers
% argument.
for i = 1:size(rel_centers, 1)
    single = formGaussian(canvas_size_px, rel_peak_height, rel_std_dev);
    shift_px = -round(rel_centers(i,:) .* canvas_size_px);
    for j=1:canvas_size_px
        for k=1:canvas_size_px
            if (j + shift_px(1) >= 1 && j + shift_px(1) <= canvas_size_px(1) && ...
                    k + shift_px(2) >= 1 && k + shift_px(2) <= canvas_size_px(2))
                % Combine images using an "or" function to keep the output range
                % within [0, 1].
                M(j,k) = M(j,k) || single(j + shift_px(1), k + shift_px(2));
            end
        end
    end
end

end
