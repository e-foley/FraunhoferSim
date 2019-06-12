% Creates an image representing multiple openings in the shape of a region
% enclosed by the profile of a normal distribution and its reflection about its
% horizontal axis. Image size, subaperture placement, and opening dimensions can
% be selected.
%
% canvas_size_px   Dimensions of the image to create (pixels) [height,width]
% rel_centers      Locations of subapertures as ratios of the larger canvas
%                  dimension [vert1,horiz1;vert2,horiz2;...;vertN,horizN]
% rel_peak_height  Amplitude of the Gaussian function (a half that's reflected)
%                  as a ratio of the canvas height
% rel_std_dev      The standard deviation of the Gaussian distribution as a
%                  ratio of the peak height
% multiply

function [M] = formMultigaussian(canvas_size_px, rel_centers, ...
    rel_peak_height, rel_std_dev, multiply)

M = zeros(canvas_size_px);

for i = 1:size(rel_centers, 1)
    single = formGaussian(canvas_size_px, rel_peak_height, rel_std_dev);
    
    pixel_shift = -round(rel_centers(i, :) .* canvas_size_px);
    for j=1:canvas_size_px
        for k=1:canvas_size_px
            
            if (j + pixel_shift(1) >= 1 && j + pixel_shift(1) <= canvas_size_px && k + pixel_shift(2) >= 1 && k + pixel_shift(2) <= canvas_size_px)
                M(j, k) = M(j, k) + single(j + pixel_shift(1), k + pixel_shift(2));
            end
        end
    end
end

for i=1:numel(M)
    if (multiply && M(i) < size(rel_centers, 1))
        M(i) = 0;
    end
    M(i) = max(0, min(1, M(i)));
end

end
