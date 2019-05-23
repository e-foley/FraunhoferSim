function [cropped_sc] = scCrop(sc, new_as_bounds)

% Note: cropping is subject to rounding errors.

cropped_sc = sc;

upx_min = 1 + floor(sc.pixels_per_as * (new_as_bounds(1,1) - sc.as_bounds(1,1)));
upx_max = 1 +  ceil(sc.pixels_per_as * (new_as_bounds(1,2) - sc.as_bounds(1,1)));
vpx_min = 1 + floor(sc.pixels_per_as * (new_as_bounds(2,1) - sc.as_bounds(2,1)));
vpx_max = 1 +  ceil(sc.pixels_per_as * (new_as_bounds(2,2) - sc.as_bounds(2,1)));

cropped_sc.data = sc.data(upx_min:upx_max, vpx_min:vpx_max);
cropped_sc.as_bounds = new_as_bounds;

end
